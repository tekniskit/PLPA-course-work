using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Documents;
using IronScheme;
using IronScheme.Scripting;

namespace IronFist.Handlers
{
    public class MapHandler
    {
        private List<List<string>> mapList;
        public MapHandler()
        {
            // Load file
            var factory = "factory".Eval();

            mapList = new List<List<string>>();
            foreach (var row in (IEnumerable)factory)
            {
                var interm = new List<string>();
                interm.AddRange(from object item in (IEnumerable) row select item.ToString());
                mapList.Add(interm);
            }
        }

        public void DrawMap()
        {
            foreach (var row in mapList)
            {
                foreach (var sym in row)
                {
                    Console.WriteLine(sym);
                }
            }
        }
    }
}
