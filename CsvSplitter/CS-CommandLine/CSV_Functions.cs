using System;
using System.Collections.Generic;
using System.IO;

namespace CSV_Splitter
{
    class CSV_Functions
    {
        public static string VerifyDirectory()
        {
            bool loopVar = true;
            string filePath = null;

                while (loopVar == true)
                {
                    Console.WriteLine("Please input directory path of .csv file that you wish to split:");
                    filePath = Console.ReadLine();

                    if (File.Exists(filePath))
                    {
                        Console.WriteLine("\nThe file exists. Press enter to continue...");
                        Console.ReadLine();
                        loopVar = false;
                    }

                    else
                    {
                        Console.WriteLine("\nWhoops! Looks like that file does not exist. Please press enter to try again.");
                        Console.ReadLine();
                    }
                }

            return filePath;
        }

        public static List<string> ImportCSV(string filePath)
        {
            List<string> csvLines = new List<string>();
            try
            {
                using (StreamReader sr = new StreamReader(filePath))
                {
                    string line = null;
                    while ((line = sr.ReadLine()) != null)
                    {
                        csvLines.Add(line);
                    }
                }
            }

            catch
            {
                Console.WriteLine("Whoops! Something went wrong. Please press enter to close the program and try again.");
                Console.ReadLine();
                Environment.Exit(0);
            }

            return csvLines;
        }

        public static void WriteListToCSV(List<string> listVar, string fileName)
        {
            using (StreamWriter sw = new StreamWriter(fileName))
            {
                foreach (string listItem in listVar)
                {
                    sw.WriteLine(listItem);
                }
            }
        }

        public static List<List<string>> SplitListToMoreLists(List<string> listVar, int numOfLists)
        {
            //Create number of smaller lists
            List<List<string>> smallerLists = new List<List<string>>();
            int i = 1;
            while (i <= numOfLists)
            {
                smallerLists.Add(new List<string>());
                i += 1;
            }

            //Split .csv file into smaller lists
            int listSize = listVar.Count;
            int numLinesPerFile = listSize / numOfLists;
            int leftoverLines = listSize % numOfLists;
            int firstFileLines = numLinesPerFile + leftoverLines;
            int listCounter = 0;
            int t = 1;

            foreach (string x in listVar)
            {
                int index = listVar.IndexOf(x);

                if (index < firstFileLines)
                {
                    smallerLists[listCounter].Add(x);

                    if ((index + 1) == firstFileLines)
                    {
                        listCounter += 1;
                    }
                }

                else if (index >= firstFileLines & index <= listSize)
                {
                    if (t > numLinesPerFile)
                    {
                        t = 0;
                        listCounter += 1;
                    }

                    smallerLists[listCounter].Add(x);

                    t += 1;
                }
            }

            return smallerLists;
        }
    }
}
