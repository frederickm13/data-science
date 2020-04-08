import pandas as pd
import matplotlib.pyplot as plt
import os
import CSVFunctions
import sys

#Test csv file path C:\Users\Frederick\Desktop\CodeFiles\tips.csv

#####
#Get/check directory of .csv file
#####
filePath = CSVFunctions.getCsvFile()

#####
#Import .csv file into data frame
#####
try:
    workingData = pd.read_csv(filePath)
    print(".csv file loaded successfully.")
    input("Press enter to proceed...")
except:
    print("Whoops, looks like there is a problem loading this file. Please close the program and try again.")
    input("Press enter to exit the program...")
    sys.exit()

#####
#Determine what user wants to do
#####
counter = 1
while counter == 1:
    print("\nWhat would you like to do?")
    print("1) View .csv file top rows.")
    print("2) View number of rows and columns in the .csv file.")
    print("3) View .csv file column names and data types.")
    print("4) View .csv file column descriptors.")
    print("5) View specific field statistics for numeric fields.")
    print("6) View histogram for specific field.")
    print("7) Exit program...")
    userChoice = input("\nPlease input a number and press enter.\n")
    
    try:
        userChoice = int(userChoice)
    except:
        print("\nInvalid response. Please enter a number.")
        continue    
    
    if userChoice == 1:
        CSVFunctions.getTopRows(workingData)
        input("\nPress enter to continue...")

    elif userChoice == 2:
        CSVFunctions.getFileShape(workingData)
        input("\nPress enter to continue...")

    elif userChoice == 3:
        CSVFunctions.getDataTypes(workingData)
        input("\nPress enter to continue...")

    elif userChoice == 4:
        CSVFunctions.getColumnDescriptors(workingData)
        input("\nPress enter to continue...")

    elif userChoice == 5:
        numObsDataFrame = workingData.select_dtypes(include=['int64','float64'])
        numColumnList = list(numObsDataFrame.columns.values)


        print("\nWhich numeric field would you like to analyze?")
        columnCounter = 1
        for i in numColumnList:
            print("{0}) {1}".format(columnCounter, i))
            columnCounter += 1
        
        userAnalyzeChoice = input("\n")
        try:
            userAnalyzeChoice = int(userAnalyzeChoice) - 1
        except:
            print("\nInvalid response. Please enter a number.")
            continue

        if userAnalyzeChoice > (len(numColumnList) - 1) or userAnalyzeChoice < 0:
            print("Invalid response. Please enter a number between 1 and {0} inclusive.".format(len(numColumnList)))
        else: 
            NumObs = numObsDataFrame[numColumnList[userAnalyzeChoice]].count()
            MeanObs = numObsDataFrame[numColumnList[userAnalyzeChoice]].mean()
            MedianObs = numObsDataFrame[numColumnList[userAnalyzeChoice]].median()
            ModeObs = numObsDataFrame[numColumnList[userAnalyzeChoice]].mode()
            MaxObs = numObsDataFrame[numColumnList[userAnalyzeChoice]].max()
            MinObs = numObsDataFrame[numColumnList[userAnalyzeChoice]].min()
            RangeObs = MaxObs - MinObs
            print("\nThe the total number of observations for this field: {0}".format(NumObs))
            print("The mean of this field is: {0}".format(MeanObs))
            print("The median of this field is: {0}".format(MedianObs))
            print("The mode of this field is: {0}".format(ModeObs))
            print("The maximum value of this field is: {0}".format(MaxObs))
            print("The minimum value of this field is: {0}".format(MinObs))
            print("The range of this field is: {0}".format(RangeObs))
            input("\nPlease press enter to continue...")

    elif userChoice == 6: 
        numObsDataFrame = workingData.select_dtypes(include=['int64','float64'])
        numColumnList = list(numObsDataFrame.columns.values)

        print("\nWhich field would you like to analyze?")
        columnCounter = 1
        for i in numColumnList:
            print("{0}) {1}".format(columnCounter, i))
            columnCounter += 1
        
        userAnalyzeChoice = input()

        try:
            userAnalyzeChoice = int(userAnalyzeChoice) - 1
        except:
            print("\nInvalid response. Please enter a number.")
            continue

        if userAnalyzeChoice > (len(numColumnList) - 1) or userAnalyzeChoice < 0:
            print("Invalid response. Please enter a number between 1 and {0} inclusive.".format(len(numColumnList)))
        else: 
            plt.show((numObsDataFrame[numColumnList[userAnalyzeChoice]]).hist(bins=15))
    
    elif userChoice == 7:
        sys.exit()  
