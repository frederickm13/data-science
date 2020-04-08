import csv
import os
import numpy as np
import CSV_Splitter_Functions

print(os.getcwd())

#####
#Get/check directory of .csv file
#####
counter = 1
while counter == 1:
    filePath = input("Please input the path for your .csv file:")
    if os.path.isfile(filePath) == True:
        input("File confirmed to exist... Please press enter to proceed forward.")
        counter = 0
    else:
        input("Whoops! It looks like that file doesn't exist. \nPlease press enter to try again.")


#####
#Get objective details
#####
counter4 = 1
while counter4 == 1:
    tempResponse = input("How many files would you like to break this .csv into?")
    try:
        numChunks = int(tempResponse)
        if numChunks < 2:
            print("Invalid response. Please enter a number greater than 2.")
        elif numChunks >= 2 and numChunks < 20:
            print("Okay, we will break this .csv file into {0} chunks.".format(numChunks))
        counter4 = 0
    except:
        print("Invalid response. Please enter a whole number.")


#####
#Get/create directory of destination path
#####
counter2 = 1
while counter2 == 1:
    destinationFilePath = input("Please enter the directory path where you would like to save the output .csv files:")
    if os.path.exists(destinationFilePath) == False:
        counter3 = 1
        while counter3 == 1:
            print("It looks like this directory does not currently exist, would you like to create it? (Please enter Y or N):")
            response = input()
            if response == "Y" or response == "y":
                os.mkdir(destinationFilePath)
                counter3 = 0
                counter2 = 0
            elif response == "N" or response == "n":
                counter3 = 0
            else:
                print("Hmmm, it looks like you did not enter Y or N.")
    elif os.path.exists(destinationFilePath) == True:
        counter2 = 0


#####
#Confirm before continuing
#####
print("Okay, I think this is all of the information that we need.")
print("However, I would like to confirm before proceeding.")
print("We are splitting the following file: {0}".format(filePath))
print("We are splitting this file into {0} chunks.".format(numChunks))
print("Finally, we are saving these chunks at the following location: {0}".format(destinationFilePath))
print()
finalResponse = input("Is the above information correct? (Please enter Y or N)")

counter5 = 1
while counter5 == 1:
    if finalResponse == "Y" or finalResponse == "y":
        counter5 = 0
    elif finalResponse == "N" or finalResponse == "n":
        continue
    else:
        print("Invalid response. Please enter Y or N.")


#####
#Import CSV file
#####
fullCsvFileList = CSV_Splitter_Functions.importCSV(filePath)

#####
#Split CSV file
#####
CSV_Splitter_Functions.splitIntoChunks(fullCsvFileList, numChunks, destinationFilePath)
input("File split completed. Please press enter to exit the application...")


