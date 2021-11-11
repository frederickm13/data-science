# Imports
import csv
import json
import pandas
from sqlalchemy import create_engine, text
from sqlalchemy.exc import IntegrityError


print("\nStarting city questions upload script...\n")

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
        cityQuestionsSqlParamsArray = []

        # Read full csv.
        df = pandas.read_csv(file_name)

        # Filter columns down for questions.
        df_questions = df[["Questionnaire", 
            "Year Reported to CDP", 
            "Parent Section", 
            "Section", 
            "Question Number",
            "Question Name", 
            "Column Number",
            "Column Name", 
            "Row Number",
            "Row Name"
        ]].copy().drop_duplicates()

        for index, row in df_questions.iterrows():
            # Create question record.
            questionParamDict = {
                "questionnaire": row["Questionnaire"],
                "survey_year": int(row["Year Reported to CDP"]),
                "parent_section": row["Parent Section"],
                "section": row["Section"],
                "question_number": row["Question Number"],
                "question_name": row["Question Name"],
                "column_number": int(row["Column Number"]),
                "column_name": row["Column Name"],
                "row_number": int(row["Row Number"]),
                "row_name": row["Row Name"]
            }

            cityQuestionsSqlParamsArray.append(questionParamDict)

        print(f"Completed reading {file_name}...")

        # Calculate insert chunks for questions.
        remainderVal = len(cityQuestionsSqlParamsArray) % chunk_size
        numChunks = int(((len(cityQuestionsSqlParamsArray) - remainderVal) / chunk_size))

        if remainderVal > 0:
            numChunks += 1

        print(f"Beginning SQL INSERT of {file_name} into city_questions table...")

        # Insert city question records.
        print(f"Total number of chunks to insert: {numChunks}")

        for x in range(numChunks):
            print(f"Inserting chunk {x+1} of {numChunks}")

            startingIndex = x * chunk_size
            endingIndex = startingIndex + chunk_size

            if endingIndex > len(cityQuestionsSqlParamsArray):
                endingIndex = len(cityQuestionsSqlParamsArray)

            try:
                cityTrans = conn.begin()
                conn.execute(
                    text("""
                        WITH temp (
                            questionnaire,
                            survey_year,
                            parent_section,
                            section,
                            question_number,
                            question_name,
                            column_number,
                            column_name,
                            row_number,
                            row_name
                        ) AS (VALUES (
                            :questionnaire,
                            :survey_year,
                            :parent_section,
                            :section,
                            :question_number,
                            :question_name,
                            :column_number,
                            :column_name,
                            :row_number,
                            :row_name
                        ))

                        INSERT INTO city_questions (
                            questionnaire,
                            survey_year,
                            parent_section,
                            section,
                            question_number,
                            question_name,
                            column_number,
                            column_name,
                            row_number,
                            row_name
                        ) SELECT questionnaire,
                            survey_year,
                            parent_section,
                            section,
                            question_number,
                            question_name,
                            column_number,
                            column_name,
                            row_number,
                            row_name
                        FROM temp
                        WHERE NOT EXISTS (
                            SELECT id,
                            FROM city_questions
                            WHERE survey_year = temp.survey_year
                                AND question_number = temp.question_number
                                AND column_number = temp.column_number
                                AND row_number = temp.row_number
                        )
                        """
                    ),
                    cityQuestionsSqlParamsArray[startingIndex:endingIndex]
                )
                cityTrans.commit()
            except IntegrityError as ex:
                if "duplicate key value" not in str(ex):
                    print("Uh oh!")
                    raise

        print(f"Completed SQL INSERT of {file_name}...")

print("Completed processing all files...")