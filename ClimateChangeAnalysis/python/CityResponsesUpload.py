# Imports
import csv
import json
import pandas
from sqlalchemy import create_engine, text
from sqlalchemy.exc import IntegrityError


print("\nStarting city responses upload script...\n")

# Create array of CSV file names.
file_names = [
    "../hidden/2018_Full_Cities_Dataset.csv",
    "../hidden/2019_Full_Cities_Dataset.csv",
    "../hidden/2020_Full_Cities_Dataset.csv"
]

# Get app settings values.
db_host = ""
db_port = ""
db_name = ""
db_username = ""
db_password = ""
chunk_size = 0
with open("../appsettings.json", "r") as appsettings_file:
    json_data = json.load(appsettings_file)
    db_host = json_data["postgres_host"]
    db_port = json_data["postgres_port"]
    db_name = json_data["postgres_dbname"]
    db_username = json_data["postgres_username"]
    db_password = json_data["postgres_password"]
    chunk_size = json_data["chunk_size"]

# Create connection to DB.
connection_string = f"postgresql://{db_username}:{db_password}@{db_host}:{db_port}/{db_name}"
engine = create_engine(connection_string)

# Read and parse through each cities CSV.
with engine.connect() as conn:
    for file_name in file_names:
        print(f"Reading {file_name}...")
    
        # Create SQL param arrays.
        cityResponsesSqlParamsArray = []

        # Read full csv.
        df = pandas.read_csv(file_name)

        # Filter columns for responses.
        df_responses = df[[
            "Account Number",
            "Question Number",
            "Column Number",
            "Row Number",
            "Year Reported to CDP",
            "Response Answer",
            "Comments"
        ]].copy()

        for index, row in df_responses.iterrows():
            # Create response record.
            responseParamDict = {
                "city_id": int(row["Account Number"]),
                "question_number": row["Question Number"],
                "column_number": int(row["Column Number"]),
                "row_number": int(row["Row Number"]),
                "survey_year": int(row["Year Reported to CDP"]),
                "response": row["Response Answer"],
                "comments": row["Comments"]
            }

            cityResponsesSqlParamsArray.append(responseParamDict)

        print(f"Completed reading {file_name}...")

        # Calculate insert chunks for questions.
        remainderVal = len(cityResponsesSqlParamsArray) % chunk_size
        numChunks = int(((len(cityResponsesSqlParamsArray) - remainderVal) / chunk_size))

        if remainderVal > 0:
            numChunks += 1

        print(f"Beginning SQL INSERT of {file_name} into city_responses table...")

        # Insert city response records.
        print(f"Total number of chunks to insert: {numChunks}")

        for x in range(numChunks):
            print(f"Inserting chunk {x+1} of {numChunks}")

            startingIndex = x * chunk_size
            endingIndex = startingIndex + chunk_size

            if endingIndex > len(cityResponsesSqlParamsArray):
                endingIndex = len(cityResponsesSqlParamsArray)

            try:
                cityTrans = conn.begin()
                conn.execute(
                    text("""
                        WITH temp (
                            city_id,
                            question_number,
                            column_number,
                            row_number,
                            survey_year,
                            response,
                            comments
                        ) AS (VALUES (
                            :city_id,
                            :question_number,
                            :column_number,
                            :row_number,
                            :survey_year,
                            :response,
                            :comments
                        ))

                        CREATE TEMP TABLE temp_two (
                            city_id INT,
                            question_id INT,
                            survey_year SMALLINT,
                            response VARCHAR(5000),
                            comments VARCHAR(5000)
                        );

                        INSERT INTO temp_two (
                            city_id,
                            question_id,
                            survey_year,
                            response,
                            comments
                        )
                        SELECT city_id,
                            city_questions.question_id,
                            survey_year,
                            response,
                            comments
                        FROM temp
                        INNER JOIN city_questions 
                            ON temp.question_number = city_questions.question_number
                                AND temp.column_number = city_questions.column_number
                                AND temp.row_number = city_questions.row_number
                                AND temp.survey_year = city_questions.survey_year;

                        INSERT INTO city_responses (
                            question_id,
                            city_id,
                            survey_year,
                            response,
                            comments
                        ) SELECT 
                            question_id,
                            city_id,
                            survey_year,
                            response,
                            comments
                        FROM temp_two
                        WHERE NOT EXISTS (
                            SELECT id,
                            FROM city_responses
                            WHERE question_id = temp_two.question_id
                                AND city_id = temp_two.city_id
                                AND survey_year = temp_two.survey_year
                        );

                        DROP TABLE temp_two;
                        """
                    ),
                    cityResponsesSqlParamsArray[startingIndex:endingIndex]
                )
                cityTrans.commit()
            except IntegrityError as ex:
                if "duplicate key value" not in str(ex):
                    print("Uh oh!")
                    raise

        print(f"Completed SQL INSERT of {file_name}...")

print("Completed processing all files...")