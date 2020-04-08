using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace CSV_Splitter_GUI
{
    class CSV_GUI_Functions
    {
        public static int CheckCsvPath(string filePath, Label lbl1)
        {
            if (File.Exists(filePath) == false)
            {
                lbl1.Visibility = Visibility.Visible;
                return 0;
            }

            else if (File.Exists(filePath))
            {
                lbl1.Visibility = Visibility.Hidden;
                return 1;
            }

            else
            {
                lbl1.Visibility = Visibility.Visible;
                return 0;
            }
        }

        public static int CheckChunksInput(int chunksInput, Label lbl1)
        {
            if (chunksInput > 1)
            {
                lbl1.Visibility = Visibility.Hidden;
                return 1;
            }

            else
            {
                lbl1.Visibility = Visibility.Visible;
                return 0;
            }
        }
        
        public static int ValidateDestPath(string destPath, Label lbl1)
        {
            if (!Directory.Exists(destPath))
            {
                lbl1.Visibility = Visibility.Visible;
                return 0;
            }

            else if (Directory.Exists(destPath))
            {
                lbl1.Visibility = Visibility.Hidden;
                return 1;
            }

            else
            {
                lbl1.Visibility = Visibility.Visible;
                return 0;
            }
        }

        public static List<string> ImportCSV(string filePath)
        {
            List<string> csvLines = new List<string>();

            using (StreamReader sr = new StreamReader(filePath))
            {
                string line = null;
                while ((line = sr.ReadLine()) != null)
                {
                    csvLines.Add(line);
                }
            }

            return csvLines;
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

        public static void WriteMultipleListsToCSV(int chunks, List<List<string>> smallerLists, string filePath)
        {
            int i = 1;
            int listCounter = 0;
            while (i <= chunks & listCounter <= (smallerLists.Count - 1))
            {
                string fileChunkName = filePath + "\\Chunk_" + i + ".csv";
                List<string> currentList = smallerLists[listCounter];
                WriteListToCSV(currentList, fileChunkName);
                i += 1;
                listCounter += 1;
            }
        }
    }
}
