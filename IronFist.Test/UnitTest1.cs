using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using IronScheme;

namespace IronFist.Test
{
    [TestClass]
    public class UnitTest1
    {
        [TestInitialize]
        public void Setup()
        {
            "(include \"Scheme/main.scm\")".Eval();
        }

        [TestMethod]
        public void RunTest()
        {
            Assert.AreEqual("(include \"Scheme/Tests/test.scm\")".Eval(),"Lala");
        }
    }
}
