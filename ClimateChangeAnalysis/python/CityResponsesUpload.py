# Imports
import csv
import json
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
    
        cityQuestionsSqlParamsArray = []
        cityResponsesSqlParamsArray = []

        with open(file_name) as csv_file:
            csv_reader = csv.DictReader(csv_file)
            
            for row in csv_reader:
                # Create question record.
                questionParamDict = {
                    "city_id": int(row["Account Number"]),
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

                # Create response record.
                responseParamDict = {
                    "city_id": int(row["Account Number"]),
                    "question_number": row["Question Number"],
                    "survey_year": int(row["Year Reported to CDP"]),
                    "response": row["Response Answer"],
                    "comments": row["Comments"]
                }

                cityResponsesSqlParamsArray.append(responseParamDict)

        print(f"Completed reading {file_name}...")

        # Calculate insert chunks.
        remainderVal = len(cityQuestionsSqlParamsArray) % chunk_size
        numChunks = int(((len(cityQuestionsSqlParamsArray) - remainderVal) / chunk_size))

        if remainderVal > 0:
            numChunks += 1

        print(f"Beginning SQL INSERT of {file_name}...")

        # Insert city question records.
        print("Inserting into the city_questions table...")
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
                            city_id,
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
                            :city_id,
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
                            city_id,
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
                        ) SELECT city_id,
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
                        FROM temp
                        WHERE NOT EXISTS (
                            SELECT question_number
                            FROM city_questions
                            WHERE question_number = temp.question_number
                                AND survey_year = temp.survey_year
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

        # Insert city response records.
        print("Inserting into the city_responses table...")

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
                            city_id,
                            question_number,
                            survey_year,
                            response,
                            comments
                        ) AS (VALUES (
                            :city_id,
                            :question_number,
                            :survey_year,
                            :response,
                            :comments
                        ))

                        WITH temp_two (
                            city_id,
                            question_id,
                            survey_year,
                            response,
                            comments
                        ) AS (
                            SELECT city_id,
                                city_questions.question_id,
                                survey_year,
                                response,
                                comments
                            FROM temp
                            INNER JOIN city_questions ON temp.question_number = city_questions.question_number
                                AND temp.survey_year = city_questions.survey_year
                        )

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
                            SELECT id
                            FROM city_responses
                            WHERE city_id = temp_two.city_id
                                AND question_id = temp_two.question_id
                                AND survey_id = temp_two.survey_id
                        )
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