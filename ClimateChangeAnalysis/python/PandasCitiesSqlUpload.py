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

        # Read full csv.
        df = pandas.read_csv(file_name)

        # Upload to SQL.
        df.to_sql("city_questions_csv", con=conn, if_exists="append", index=False, chunksize=chunk_size)

        print(f"Completed SQL INSERT of {file_name}...")

print("Completed processing all files...")