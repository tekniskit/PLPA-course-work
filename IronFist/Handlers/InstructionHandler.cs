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
            instructionsInput.Eval();
        }
    }
}
