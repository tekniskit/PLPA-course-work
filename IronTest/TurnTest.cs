using System;
using IronScheme;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IronTest
{
    [TestClass]
    public class TurnTest
    {
        [TestInitialize]
        public void Setup()
        {
            "(include \"../../../IronFist/Scheme/main.scm\")".Eval();
        }
        [TestMethod]
        public void TestMethod1()
        {
        }
    }
}
