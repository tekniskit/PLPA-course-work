﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Text.RegularExpressions;
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
using IronFist.Handlers;
using IronScheme;

namespace IronFist
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private MapHandler mapHandler;
        public MainWindow()
        {
            InitializeComponent();
            "(include \"Scheme/main.scm\")".Eval();
            mapHandler = new MapHandler(MapCanvas);
            mapHandler.DrawMap();
            
            CreateFileWatcher();
        }

        private void RunButton_Click(object sender, RoutedEventArgs eventArgs)
        {
            try
            {
                InstructionHandler.Run(InputA.Text);
            }
            catch (Exception exception)
            {
                ErrorConsole.Text = exception.Message;
            }
        }

        public void CreateFileWatcher()
        {
            // Create a new FileSystemWatcher and set its properties.
            FileSystemWatcher watcher = new FileSystemWatcher();
            watcher.Path = System.AppDomain.CurrentDomain.BaseDirectory;
            watcher.NotifyFilter = NotifyFilters.LastWrite;
            watcher.Filter = "log.txt";

            // Add event handlers.
            watcher.Changed += new FileSystemEventHandler(OnChanged);
            watcher.Created += new FileSystemEventHandler(OnChanged);

            // Begin watching.
            watcher.EnableRaisingEvents = true;
        }

        // Define the event handlers.
        private void OnChanged(object source, FileSystemEventArgs e)
        {
            var file = File.Open(e.FullPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            string text = "";
            
            using (var sr = new StreamReader(file, Encoding.Default))
            {
                while (!sr.EndOfStream)
                {
                    text += sr.ReadLine();
                }
            }

            TouchRobot(text);

            Application.Current.Dispatcher.Invoke(new Action(() => { TextBlockConsoleOutput.Text = text; }));
        }

        private void TouchRobot(string text)
        {
            if (text.Length == 0)
                return;

            var values = Regex.Split(text, ";");
            int xVal;
            int yVal;
            int direc;
            var cargo = values[3];

            int.TryParse(values[0], out xVal);
            int.TryParse(values[1], out yVal);
            int.TryParse(values[2], out direc);
            Application.Current.Dispatcher.Invoke(() => { mapHandler.SetRobot(xVal, yVal, direc); });
        }
    }
}
