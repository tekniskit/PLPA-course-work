using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using IronScheme;

namespace IronFist.Handlers
{
    public class InstructionHandler
    {
        /* Basic commands:
         * TURN_LEFT
         * TURN_RIGHT
         * MOVE_FORWARD
         * MOVE_BACKWARD
         * DROP_OBJECT
         * PICK_OBJECT
         */
        public static void Run(string instructionsInput)
        {
            string[] instructions = instructionsInput.Split(new []{'\r','\n' }, StringSplitOptions.RemoveEmptyEntries);
            var result = new List<string>();
            // Evaluate instructions
            foreach (string instruction in instructions)
            {
                string[] splitInstruction = instruction.Split(null);
                int instructionCount = int.Parse(splitInstruction[1]);
                if (splitInstruction[0] == "DROP_OBJECT" || splitInstruction[0] == "PICK_OBJECT")
                {
                    
                }
                else
                {
                    int numberOfRepetitions = int.Parse(splitInstruction[1]);
                    for (int i = 0; i < numberOfRepetitions; i++)
                    {
                        result.Add("(" + splitInstruction[0] + ")");
                    }
                }
                
            }

            // This SHOULD be in Scheme however IronScheme threading library is impossible to import.
            Task.Run(() =>
            {
                foreach (var ins in result)
                {
                    ins.Eval();
                    Thread.Sleep(1000);
                }
            });
            
            //var joinedResult = string.Join(" ", result);
            //var resultFromScheme = joinedResult.Eval();
        }
    }
}
