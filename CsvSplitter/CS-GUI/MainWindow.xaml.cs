using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Forms;



namespace CSV_Splitter_GUI
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void SubmitClick(object sender, RoutedEventArgs e)
        {
            //Update button
            SubmitButton.Content = "RUNNING...";
            SubmitButton.IsEnabled = false;

            //Get/check directory of .csv file
            string csvFilePath = CSVFileTextBox.Text;
            int filePathProceed = CSV_GUI_Functions.CheckCsvPath(csvFilePath, InvalidFilePathLbl);

            //Validate and assign number of chunks input
            int numChunks = 0;
            int numChunksProceed = 0;
            try
            {
                numChunks = int.Parse(NumChunksTextBox.Text);
                numChunksProceed = CSV_GUI_Functions.CheckChunksInput(numChunks, InvalidChunksInputLabel);
            }

            catch
            {
                InvalidChunksInputLabel.Visibility = Visibility.Visible;
                SubmitButton.Content = "SUBMIT";
                SubmitButton.IsEnabled = true;
            }
            
            //Validate and/or create destination path
            string destPath = DestPathTextBox.Text;
            int destPathProceed = CSV_GUI_Functions.ValidateDestPath(destPath, InvalidDirPathLbl);

            if (filePathProceed == 1 & numChunksProceed == 1 & destPathProceed == 1)
            {
                bool importSuccessful = false;
                bool splitSuccessful = false;
                bool writeSuccessful = false;

                List<string> csvLines = new List<string>();
                List<List<string>> smallerLists = new List<List<string>>();

                try
                {
                    csvLines = CSV_GUI_Functions.ImportCSV(csvFilePath);
                    importSuccessful = true;
                }

                catch
                {
                    //show error
                    SubmitButton.Content = "FAILED";
                    SubmitButton.IsEnabled = false;
                }

                if (importSuccessful == true)
                {
                    try
                    {
                        smallerLists = CSV_GUI_Functions.SplitListToMoreLists(csvLines, numChunks);
                        splitSuccessful = true;
                    }

                    catch
                    {
                        //show error
                        SubmitButton.Content = "FAILED";
                        SubmitButton.IsEnabled = false;
                    }
                }

                if (importSuccessful == true & splitSuccessful == true)
                {
                    try
                    {
                        CSV_GUI_Functions.WriteMultipleListsToCSV(numChunks, smallerLists, destPath);
                        writeSuccessful = true;


                    }

                    catch
                    {
                        //show error
                        SubmitButton.Content = "FAILED";
                        SubmitButton.IsEnabled = false;
                    }
                }

                if (writeSuccessful == true)
                {
                    SubmitButton.Content = "DONE!";
                    SubmitButton.IsEnabled = false;
                }
            }

            else if (filePathProceed == 0 || numChunksProceed == 0 || destPathProceed == 0)
            {
                SubmitButton.Content = "SUBMIT";
                SubmitButton.IsEnabled = true;
            }
        }   

        private void PickDestPath(object sender, RoutedEventArgs e)
        {
            FolderBrowserDialog folderDlg = new FolderBrowserDialog();
            DialogResult result = folderDlg.ShowDialog();

            if (result.ToString() == "OK")
            {
                DestPathTextBox.Text = folderDlg.SelectedPath;
            }
        }

        private void PickSourceFile(object sender, RoutedEventArgs e)
        {
            Microsoft.Win32.OpenFileDialog fileDlg = new Microsoft.Win32.OpenFileDialog();
            fileDlg.Filter = "Csv Files (.csv)|*.csv";

            if (fileDlg.ShowDialog() == true)
            {
                CSVFileTextBox.Text = fileDlg.FileName;
            }
        }

        private void ResetClick(object sender, RoutedEventArgs e)
        {
            DestPathTextBox.Text = "";
            CSVFileTextBox.Text = "";
            NumChunksTextBox.Text = "";
            SubmitButton.Content = "SUBMIT";
            SubmitButton.IsEnabled = true;
            InvalidDirPathLbl.Visibility = Visibility.Hidden;
            InvalidFilePathLbl.Visibility = Visibility.Hidden;
            InvalidChunksInputLabel.Visibility = Visibility.Hidden;
        }
    }
}
