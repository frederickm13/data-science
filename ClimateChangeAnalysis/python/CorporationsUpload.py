# Imports
import csv
import json
from sqlalchemy import create_engine, text
from sqlalchemy.exc import IntegrityError


print("\nStarting corporations upload script...\n")

# Create array of CSV file names.
file_names = [
    "../hidden/2018_Corporates_Disclosing_to_CDP_Climate_Change.csv",
    "../hidden/2018_Corporates_Disclosing_to_CDP_Water_Security.csv",
    "../hidden/2019_Corporates_Disclosing_to_CDP_Climate_Change.csv",
    "../hidden/2019_Corporates_Disclosing_to_CDP_Water_Security.csv",
    "../hidden/2020_Corporates_Disclosing_to_CDP_Climate_Change.csv",
    "../hidden/2020_Corporates_Disclosing_to_CDP_Water_Security.csv",
]

# Get app settings values.
db_host = ""
db_port = ""
db_name = ""
db_username = ""
db_password = ""
with open("../appsettings.json", "r") as appsettings_file:
    json_data = json.load(appsettings_file)
    db_host = json_data["postgres_host"]
    db_port = json_data["postgres_port"]
    db_name = json_data["postgres_dbname"]
    db_username = json_data["postgres_username"]
    db_password = json_data["postgres_password"]

# Create connection to DB.
connection_string = f"postgresql://{db_username}:{db_password}@{db_host}:{db_port}/{db_name}"
engine = create_engine(connection_string)

# Read and parse through each cities CSV.
with engine.connect() as conn:
    for file_name in file_names:
        print(f"Reading {file_name}...")
    
        corporationsSqlParamsArray = []
        corporationReportingYearsSqlParamsArray = []

        with open(file_name) as csv_file:
            csv_reader = csv.DictReader(csv_file)
            
            for row in csv_reader:
                # Create corporation record.
                corpParamDict = {
                    "account_number": int(row["account_number"]),
                    "organization": row["organization"],
                    "country": row["country"],
                    "region": row["region"],
                    "public": row["public"],
                    "authority_types": row["authority_types"],
                    "activities": row["activities"],
                    "sectors": row["sectors"],
                    "industries": row["industries"],
                    "primary_activity": row["primary_activity"],
                    "primary_sector": row["primary_sector"],
                    "primary_industry": row["primary_industry"],
                    "primary_ticker": row["primary_ticker"],
                    "tickers": row["tickers"]
                }

                corporationsSqlParamsArray.append(corpParamDict)

                # Create corporation reporting years record.
                corpReportingParamDict = {
                    "corp_id": int(row["account_number"]),
                    "reporting_year": int(row["survey_year"]),
                    "samples": row["samples"],
                    "response_received_date": row["response_received_date"],
                    "minimum_tier": row["minimum_tier"],
                    "selected_tier": row["selected_tier"],
                    "questionnaire": row["questionnaire"],
                    "theme": row["theme"],
                    "primary_questionnaire_sector": row["primary_questionnaire_sector"]
                }

                corporationReportingYearsSqlParamsArray.append(corpReportingParamDict)

        print(f"Completed reading {file_name}...")
        print(f"Beginning SQL INSERT of {file_name}...")

        # Insert city records.
        print("Inserting into the corporations table...")
        try:
            cityTrans = conn.begin()
            conn.execute(
                text("""
                    WITH temp (
                        account_number, 
                        organization, 
                        country, 
                        region, 
                        public,
                        authority_types,
                        activities,
                        sectors,
                        industries,
                        primary_activity,
                        primary_sector,
                        primary_industry,
                        primary_ticker,
                        tickers
                    ) AS (VALUES (
                        :account_number, 
                        :organization, 
                        :country, 
                        :region, 
                        :public,
                        :authority_types,
                        :activities,
                        :sectors,
                        :industries,
                        :primary_activity,
                        :primary_sector,
                        :primary_industry,
                        :primary_ticker,
                        :tickers
                    ))

                    INSERT INTO corporations (
                        account_number, 
                        organization, 
                        country, 
                        region, 
                        public,
                        authority_types,
                        activities,
                        sectors,
                        industries,
                        primary_activity,
                        primary_sector,
                        primary_industry,
                        primary_ticker,
                        tickers
                    ) SELECT account_number, 
                        organization, 
                        country, 
                        region, 
                        public,
                        authority_types,
                        activities,
                        sectors,
                        industries,
                        primary_activity,
                        primary_sector,
                        primary_industry,
                        primary_ticker,
                        tickers
                    FROM temp
                    WHERE NOT EXISTS (
                        SELECT account_number
                        FROM corporations
                        WHERE account_number = temp.account_number
                    )
                    """
                ),
                corporationsSqlParamsArray
            )
            cityTrans.commit()
        except IntegrityError as ex:
            if "duplicate key value" not in str(ex):
                print("Uh oh!")
                raise

        # Insert corporation reporting year records.
        print("Inserting into the corporations_reporting_years table...")
        try:
            cityTrans = conn.begin()
            conn.execute(
                text("""
                    WITH temp (
                        corp_id,
                        reporting_year,
                        samples,
                        response_received_date,
                        minimum_tier,
                        selected_tier,
                        questionnaire,
                        theme,
                        primary_questionnaire_sector
                    ) AS (VALUES (
                        :corp_id,
                        :reporting_year,
                        :samples,
                        :response_received_date,
                        :minimum_tier,
                        :selected_tier,
                        :questionnaire,
                        :theme,
                        :primary_questionnaire_sector
                    ))

                    INSERT INTO corporations_reporting_years (
                        corp_id,
                        reporting_year,
                        samples,
                        response_received_date,
                        minimum_tier,
                        selected_tier,
                        questionnaire,
                        theme,
                        primary_questionnaire_sector
                    ) SELECT corp_id,
                        reporting_year,
                        samples,
                        CAST (response_received_date AS TIMESTAMP),
                        minimum_tier,
                        selected_tier,
                        questionnaire,
                        theme,
                        primary_questionnaire_sector
                    FROM temp
                    WHERE NOT EXISTS (
                        SELECT corp_id
                        FROM corporations_reporting_years
                        WHERE corp_id = temp.corp_id
                            AND reporting_year = temp.reporting_year
                    )
                    """
                ),
                corporationReportingYearsSqlParamsArray
            )
            cityTrans.commit()
        except IntegrityError as ex:
            if "duplicate key value" not in str(ex):
                print("Uh oh!")
                raise

        print(f"Completed SQL INSERT of {file_name}...")

print("Completed processing all files...")