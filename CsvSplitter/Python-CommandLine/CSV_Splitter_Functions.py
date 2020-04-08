import csv
import numpy as np

def importCSV(csvFile):
    csvFileList = []
    with open(csvFile,'r') as file2:
        read = csv.reader(file2)
        for i in read:
            csvFileList.append(i)
    return csvFileList

def splitIntoChunks(csvFile, numChunks, destinationFilePath):
    newFiles = np.array_split(np.asarray(csvFile),numChunks)
    counter = 1
    for i in newFiles:
        fileName = str(destinationFilePath) + "\Chunk_" + str(counter) + ".csv"
        with open(fileName,'w',newline='\n') as fileChunk:
            for x in i:
                write = csv.writer(fileChunk)
                write.writerow(x)
        print("{0} file written.".format(counter))
        counter += 1