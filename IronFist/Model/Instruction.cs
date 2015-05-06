using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronFist.Model
{
    public class Instruction
    {
        private string _command;
        public string Command
        {
            set
            {
                _command = value;
                if (_command == "PICK OBJECT")
                {
                    Values.Clear();
                    Values.Add("Hammer");
                    Values.Add("Wrench");
                    Values.Add("Drill");
      
                }
                else if (_command == "DROP OBJECT")
                {
                    Values.Clear();
                }
                else
                {
                    Values.Clear();
                    Values.Add("1");
                    Values.Add("2");
                    Values.Add("3");  
                }
                
            }
            get { return _command; }
        }

        public string Value { get; set; }

        private string ToScheme()
        {
            return (Command == null) ? " " :  '(' + Command.ToLower().Replace(" ", "_") +' '+ Value+ ')';
        }

        public override string ToString()
        {
            return ToScheme();
        }

        public List<string> Commands { get; set; }

        public ObservableCollection<string> Values { get; set; }

        public Instruction()
        {
            Commands = new List<string>() { "MOVE FORWARD", "MOVE BACKWARD", "TURN LEFT", "TURN RIGHT", "DROP OBJECT", "PICK OBJECT" };
            Values = new ObservableCollection<string>();
            Command = Commands[0];
        }
        

    }
}
