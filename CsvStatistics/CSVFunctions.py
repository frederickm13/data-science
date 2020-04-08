import pandas as pd
import matplotlib.pyplot as plt
import os

def getCsvFile():
    counter = 1
    while counter == 1:
        file = input("Please input the path for your .csv file:\n")
        if os.path.isfile(file) == True:
            input("File confirmed to exist... Please press enter to load file.\n")
            counter = 0
        else:
            input("Whoops! It looks like that file doesn't exist.\nPlease press enter to try again.")
    return file

def getTopRows(file):
    print("\nTOP FIVE ROWS:")
    print(file.head())

def getFileShape(file):
    print("\nFILE SHAPE (ROWS,COLUMNS):")
    print(file.shape)

def getDataTypes(file):
    print("\nCOLUMN DATA TYPES:")
    print(file.dtypes)

def getColumnDescriptors(file):
    print("\nCATEGORICAL COLUMN DESCRIPTORS:")
    print(file.select_dtypes(include=['object']).describe())

    print("\nNUMERICAL COLUMN DESCRIPTORS:")
    print(file.select_dtypes(include=['int64','float64']).describe())

'''
def fieldStats(file):
    if numerical:
        data type
        mean
        median
        Mode
        max
        min
        range
        isunique
        number of duplicates
        number of unique
    elif object:
        data type
        isunique
        number of duplicates
        number of unique
'''
