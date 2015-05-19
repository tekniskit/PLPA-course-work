using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Media;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using IronFist.Handlers;
using IronFist.Model;
using IronScheme;

namespace IronFist
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow
    {
        private readonly MapHandler _mapHandler;
        public ObservableCollection<Instruction> Instructions;
        public bool Busy;
  
        public MainWindow()
        {
            InitializeComponent();
            "(include \"Scheme/main.scm\")".Eval();
            _mapHandler = new MapHandler(MapCanvas);
            Instructions = new ObservableCollection<Instruction> {new Instruction()};

            InstructionListView.ItemsSource = Instructions;
                       
            CreateFileWatcher();
            CreateCounterFileWatcher();
            CreateErrorFileWatcher();
        }

        private void RunButton_Click(object sender, RoutedEventArgs eventArgs)
        {
            if (!Busy && Instructions.Count > 0)
            {
                foreach (var instruction in Instructions)
                    instruction.BackgroundColor = Brushes.Black;
                
                Busy = true;
                try
                {
                    var ins = string.Join(" ", Instructions);
                    Task.Run(() =>
                    {
                        InstructionHandler.Run(ins);
                        Busy = false;
                        Instructions.Last().BackgroundColor = Brushes.Green;
                        SoundPlayer player = new SoundPlayer(@"Sounds/work-complete.wav");
                        player.Play();
                        MessageBox.Show("Okey dokey", "Job's done!", MessageBoxButton.OK, MessageBoxImage.Information);
                    });

                }
                catch (Exception exception)
                {
                    ErrorConsole.Text = exception.Message;
                }   
            }
            else
            {
                var player = new SoundPlayer(@"Sounds/annoyed5.wav");
                player.Play();
                MessageBox.Show("You can only run one command at a time", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        public void CreateFileWatcher()
        {
            // Create a new FileSystemWatcher and set its properties.
            var watcher = new FileSystemWatcher
            {
                Path = AppDomain.CurrentDomain.BaseDirectory,
                NotifyFilter = NotifyFilters.LastWrite,
                Filter = "log.txt"
            };

            // Add event handlers.
            watcher.Changed += OnChanged;
            watcher.Created += OnChanged;

            // Begin watching.
            watcher.EnableRaisingEvents = true;
        }

        private void OnChanged(object source, FileSystemEventArgs e)
        {
            var file = File.Open(e.FullPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            var text = "";
            
            using (var sr = new StreamReader(file, Encoding.Default))
            {
                while (!sr.EndOfStream)
                {
                    text += sr.ReadLine();
                }
            }

            if (string.IsNullOrEmpty(text)) return;

            TouchRobot(text);
            Application.Current.Dispatcher.Invoke(() =>
            {
                var item = text.Split(';').Last();
                var value = "";
                Console.WriteLine(text);
                switch (item)
                {
                    case "1":
                        value = "Hammer";
                        break;
                    case "2":
                        value = "Wrench";
                        break;
                    case "3":
                        value = "Drill";
                        break;
                    case "4":
                        value = "Saw";
                        break;
                    default:
                        value = "No objects";
                        break;
                }
                TextBlockConsoleOutput.Text = value;
            });
        }

        public void CreateCounterFileWatcher()
        {
            // Create a new FileSystemWatcher and set its properties.
            var watcher = new FileSystemWatcher
            {
                Path = AppDomain.CurrentDomain.BaseDirectory,
                NotifyFilter = NotifyFilters.LastWrite,
                Filter = "program-counter.txt"
            };

            // Add event handlers.
            watcher.Changed += OnCounterChanged;
            watcher.Created += OnCounterChanged;

            // Begin watching.
            watcher.EnableRaisingEvents = true;
        }

        private void OnCounterChanged(object sender, FileSystemEventArgs e)
        {
            var file = File.Open(e.FullPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            var text = "";
            
            using (var sr = new StreamReader(file, Encoding.Default))
            {
                while (!sr.EndOfStream)
                {
                    text += sr.ReadLine();
                }
            }
            try
            {
                var number = int.Parse(text);
                Instructions[number].BackgroundColor = Brushes.Red;
                if (number != 0)
                {
                    Instructions[number - 1].BackgroundColor = Brushes.Green;
                }
                var player = new SoundPlayer(@"Sounds/basic-spell-sound.wav");
                player.Play();
            }
            catch (Exception)
            {
                // ignored
            }
        }

        public void CreateErrorFileWatcher()
        {
            // Create a new FileSystemWatcher and set its properties.
            var watcher = new FileSystemWatcher
            {
                Path = AppDomain.CurrentDomain.BaseDirectory,
                NotifyFilter = NotifyFilters.LastWrite,
                Filter = "error.txt"
            };

            // Add event handlers.
            watcher.Changed += OnErrorChanged;
            watcher.Created += OnErrorChanged;

            // Begin watching.
            watcher.EnableRaisingEvents = true;
        }

        private void OnErrorChanged(object sender, FileSystemEventArgs e)
        {
            var file = File.Open(e.FullPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            var text = "";

            using (var sr = new StreamReader(file, Encoding.Default))
            {
                while (!sr.EndOfStream)
                {
                    text += sr.ReadLine();
                }
            }

            var player = new SoundPlayer(@"Sounds/annoyed2.wav");
            player.Play();
            Application.Current.Dispatcher.Invoke(() => { ErrorConsole.Text = text; });
        }

        private void AddInstruction(object sender, RoutedEventArgs e)
        {
            Instructions.Add(new Instruction());
        }
        
        private void TouchRobot(string text)
        {
            if (text.Length == 0)
                return;

            var values = Regex.Split(text, ";");
            int xVal;
            int yVal;
            int direc;

            int.TryParse(values[0], out xVal);
            int.TryParse(values[1], out yVal);
            int.TryParse(values[2], out direc);
            Application.Current.Dispatcher.Invoke(() => { _mapHandler.SetRobot(xVal, yVal, direc); });
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Instructions.Clear();
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "10" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "10" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "9" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "6" });
            Instructions.Add(new Instruction { Command = "PICK OBJECT", Value = "Hammer" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "2" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "6" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "10" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "10" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "1" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "7" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "2" });
            Instructions.Add(new Instruction { Command = "DROP OBJECT", Value = "" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "2" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "2" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "3" });
            Instructions.Add(new Instruction { Command = "PICK OBJECT", Value = "Wrench" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "4" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "10" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "2" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "3" });
            Instructions.Add(new Instruction { Command = "DROP OBJECT", Value = "" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "2" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "6" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "2" });
            Instructions.Add(new Instruction { Command = "PICK OBJECT", Value = "Drill" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "2" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "2" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "5" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "2" });
            Instructions.Add(new Instruction { Command = "DROP OBJECT", Value = "" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "4" });
            Instructions.Add(new Instruction { Command = "PICK OBJECT", Value = "Saw" });
            Instructions.Add(new Instruction { Command = "TURN LEFT", Value = "2" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "6" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "8" });
            Instructions.Add(new Instruction { Command = "TURN RIGHT", Value = "1" });
            Instructions.Add(new Instruction { Command = "MOVE FORWARD", Value = "8" });
            Instructions.Add(new Instruction { Command = "DROP OBJECT", Value = "" });
        }

        private void ResetButton_Click(object sender, RoutedEventArgs e)
        {
            Instructions.Clear();
        }

        private void RemoveInstructionButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedInstruction = InstructionListView.SelectedValue as Instruction;
            Instructions.Remove(selectedInstruction);
        }
    }
}
