using System;
using IronScheme;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IronTest
{
    [TestClass]
    public class CargoTest
    {
        [TestInitialize]
        public void Setup()
        {
            "(include \"../../../IronFist/Scheme/main.scm\")".Eval();
        }
        [TestMethod]
        public void Pick_up_object_1_at_workstation_1()
        {
            var result = "(pick_object '(29 2 0 0) 1)".Eval() as IronScheme.Runtime.Cons;
            
            
            //var command = "#t";
            Assert.AreEqual(result.PrettyPrint, "(29 2 0 1)\n");
        }
    }
}
