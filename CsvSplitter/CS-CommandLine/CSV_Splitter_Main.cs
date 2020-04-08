using System;
using System.IO;
using System.Collections.Generic;

namespace CSV_Splitter
{
    class CSV_Splitter_Main
    {
        static void Main(string[] args)
        {
            //Get/check directory of .csv file
            string filePath = CSV_Functions.VerifyDirectory();

            //Get objective details
            bool loopVar = true;
            string numChunksString = null;
            int numChunks = 0;

            while (loopVar == true)
            {
                Console.WriteLine("\nHow many chunks would you like to break this .csv file into?");
                numChunksString = Console.ReadLine();

                try
                {
                    numChunks = int.Parse(numChunksString);
                    if (numChunks < 2)
                    {
                        Console.WriteLine("\nWhoops! That didn't work. Please enter a number greater than 2.");                        
                    }

                    else if (numChunks >= 2 & numChunks <= 20)
                    {
                        Console.WriteLine("Okay, we will break this file into {0} chunks.", numChunksString);
                        Console.WriteLine("Please press enter to continue...");
                        Console.ReadLine();
                        loopVar = false;
                    }

                    else
                    {
                        Console.WriteLine("\nWhoops! Invalid response. Please enter a number between 2 and 20 (inclusive).");
                    }
                }

                catch
                {
                    Console.WriteLine("\nWhoops! That didn't work. Please enter a number.");
                }
            }

            //Get/create directory of destination directory path
            loopVar = true;
            string destinationFilePath = null;

            while (loopVar == true)
            {
                Console.WriteLine("\nPlease enter the destination file path where you would like to save the files.");
                destinationFilePath = Console.ReadLine();

                if (!Directory.Exists(destinationFilePath))
                {
                    Console.WriteLine("\nIt looks like this directory doesn't exist. Would you like to create it? Please enter 'Y' or 'N'.");
                    string dirResponse = Console.ReadLine();

                    if (dirResponse == "Y" | dirResponse == "y")
                    {
                        //Make directory
                        Directory.CreateDirectory(destinationFilePath);
                        Console.WriteLine("Directory has been created.");
                        loopVar = false;
                    }

                    else if (dirResponse == "N" | dirResponse == "n")
                    {
                        //Please try again
                        Console.WriteLine("Okay, please try again.");
                    }

                    else
                    {
                        //Try again
                        Console.WriteLine("Whoops! It looks like you did not enter 'Y' or 'N'. Please try again.");
                    }
                }

                else if (Directory.Exists(destinationFilePath))
                {
                    Console.WriteLine("\nDestination directory has been set: {0}", destinationFilePath);
                    Console.WriteLine("Please press enter to continue.");
                    Console.ReadLine();
                    loopVar = false;
                }

                else
                {
                    Console.WriteLine("Whoops! Looks like something went wrong. Please try again.");
                }
            }

            //Confirm objective before proceeding
            Console.WriteLine("\nOkay, I think this is all of the information that we need. However, I would like to confirm before proceeding." +
                "\nWe are splitting the following file: {0}" +
                "\nWe are splitting this file into {1} chunks." +
                "\nFinally, we are saving these chunks at the following location: {2}" +
                "\nIs the above information correct? Please enter 'Y' or 'N'.", filePath, numChunksString, destinationFilePath);
            string confirmResp = Console.ReadLine();

            loopVar = true;
            while (loopVar == true)
            {
                if (confirmResp.ToLower() == "y")
                {
                    Console.WriteLine("\nThanks for your confirmation. Please press enter to continue.");
                    Console.ReadLine();
                    loopVar = false;
                }

                else if (confirmResp.ToLower() == "n")
                {
                    //Exit program
                    Console.WriteLine("Okay, please press enter to exit the program and try again.");
                    Console.ReadLine();
                    Environment.Exit(0);
                }

                else
                {
                    Console.WriteLine("\nWhoops! Invalid response. Please enter 'Y' or 'N'.");
                }
            }

            //Import .csv file
            List<string> csvLines = CSV_Functions.ImportCSV(filePath);

            //Split .csv file into smaller lists
            List<List<string>> smallerLists = CSV_Functions.SplitListToMoreLists(csvLines, numChunks);
            

            //Write smaller lists to new .csv files
            int i = 1;
            int listCounter = 0;
            while (i <= numChunks & listCounter <= (smallerLists.Count - 1))
            {
                string fileChunkName = destinationFilePath + "\\Chunk_" + i + ".csv";
                CSV_Functions.WriteListToCSV(smallerLists[listCounter], fileChunkName);
                i += 1;
                listCounter += 1;
            }

            Console.WriteLine("Completed Succesfully...");
            Console.WriteLine("{0} files have been created...", numChunksString);
            Console.WriteLine("Please press enter to close this program");
            Console.ReadLine();
        }
    }
}
