# Imports
import csv
import json
from sqlalchemy import create_engine, text
from sqlalchemy.exc import IntegrityError


print("\nStarting cities upload script...\n")

# Create array of CSV file names.
file_names = [
    "../hidden/2018_Cities_Disclosing_to_CDP.csv",
    "../hidden/2019_Cities_Disclosing_to_CDP.csv",
    "../hidden/2020_Cities_Disclosing_to_CDP.csv"
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
    
        citySqlParamsArray = []
        cityReportingSqlParamsArray = []
        populationSqlParamsArray = []

        with open(file_name) as csv_file:
            csv_reader = csv.DictReader(csv_file)
            
            for row in csv_reader:
                # Create city record.
                cityParamDict = {
                    "account_number": int(row["Account Number"]),
                    "organization": row["Organization"],
                    "city": row["City"],
                    "country": row["Country"],
                    "cdp_region": row["CDP Region"],
                    "reporting_authority": row["Reporting Authority"],
                    "access": row["Access"],
                    "location": row["City Location"]
                }

                citySqlParamsArray.append(cityParamDict)

                # Create city reporting years record.
                cityReportingParamDict = {
                    "city_id": int(row["Account Number"]),
                    "reporting_year": int(row["Year Reported to CDP"])
                }

                cityReportingSqlParamsArray.append(cityReportingParamDict)

                # Create population record.
                populationParamDict = {
                    "city_id": int(row["Account Number"]),
                    "population_year": int(row["Population Year"]),
                    "population": 0 if row["Population"] == "" else int(float(row["Population"]))
                }

                populationSqlParamsArray.append(populationParamDict)

        print(f"Completed reading {file_name}...")
        print(f"Beginning SQL INSERT of {file_name}...")

        # Insert city records.
        print("Inserting into the cities table...")
        try:
            cityTrans = conn.begin()
            conn.execute(
                text("""
                    WITH temp (
                        account_number, 
                        organization, 
                        city, 
                        country, 
                        cdp_region, 
                        reporting_authority, 
                        access, 
                        location
                    ) AS (VALUES (
                        :account_number,
                        :organization, 
                        :city, 
                        :country, 
                        :cdp_region, 
                        :reporting_authority, 
                        :access, 
                        :location
                    ))

                    INSERT INTO cities (
                        account_number, 
                        organization, 
                        city, 
                        country, 
                        cdp_region, 
                        reporting_authority, 
                        access, 
                        location
                    ) SELECT account_number, 
                        organization, 
                        city, 
                        country, 
                        cdp_region, 
                        reporting_authority, 
                        access, 
                        location
                    FROM temp
                    WHERE NOT EXISTS (
                        SELECT account_number
                        FROM cities
                        WHERE account_number = temp.account_number
                    )
                    """
                ),
                citySqlParamsArray
            )
            cityTrans.commit()
        except IntegrityError as ex:
            if "duplicate key value" not in str(ex):
                print("Uh oh!")
                raise

        # Insert city reporting year records.
        print("Inserting into the city_reporting_years table...")
        try:
            reportingTrans = conn.begin()
            conn.execute(
                text("""
                    WITH temp (
                        city_id,
                        reporting_year
                    ) AS (VALUES (
                        :city_id,
                        :reporting_year
                    ))

                    INSERT INTO city_reporting_years (
                        city_id,
                        reporting_year
                    ) SELECT city_id,
                        reporting_year
                    FROM temp
                    WHERE NOT EXISTS (
                        SELECT city_id,
                            reporting_year
                        FROM city_reporting_years
                        WHERE city_id = temp.city_id
                            AND reporting_year = temp.reporting_year
                    )
                    """
                ),
                cityReportingSqlParamsArray
            )
            reportingTrans.commit()
        except IntegrityError as ex:
            if "duplicate key value" not in str(ex):
                print("Uh oh!")
                raise

        # Insert population records.
        print("Inserting into the populations table...")
        try:
            popTrans = conn.begin()
            conn.execute(
                text("""
                    WITH temp (
                        city_id,
                        population_year,
                        population
                    ) AS (VALUES (
                        :city_id,
                        :population_year,
                        :population
                    ))

                    INSERT INTO populations (
                        city_id,
                        population_year,
                        population
                    ) SELECT city_id,
                        population_year,
                        population
                    FROM temp
                    WHERE NOT EXISTS (
                        SELECT city_id,
                            population_year
                        FROM populations
                        WHERE city_id = temp.city_id
                            AND population_year = temp.population_year
                    )
                    """
                ),
                populationSqlParamsArray
            )
            popTrans.commit()
        except IntegrityError as ex:
            if "duplicate key value" not in str(ex):
                print("Uh oh!")
                raise

        print(f"Completed SQL INSERT of {file_name}...")

print("Completed processing all files...")