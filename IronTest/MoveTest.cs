using System;
using IronScheme;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IronTest
{
    [TestClass]
    public class MoveTest
    {
        [TestInitialize]
        public void Setup()
        {
            "(include \"../../../IronFist/Scheme/main.scm\")".Eval();
        }
        [TestMethod]
        public void move_1_step_forward_on_path()
        {
            var result = (bool) "(= (get-x (move_forward '(0 8 0 0) 1)) 1)".Eval();

            Assert.IsTrue(result);
        }

    }
}
