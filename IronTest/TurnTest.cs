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
        public void ItShould_TurnMinus90DegreeLeft()
        {
            var result = (bool) "(= (get-dir (turn_left '(0 8 0 0) -1)) 3)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Turn0DegreeLeft()
        {
            var result = (bool)"(= (get-dir (turn_left '(0 8 0 0) 0)) 0)".Eval();
            Assert.IsTrue(result);
        }


        [TestMethod]
        public void ItShould_Turn90DegreeLeft()
        {
            var result = (bool)"(= (get-dir (turn_left '(0 8 0 0) 1)) 1)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Turn180DegreeLeft()
        {
            var result = (bool)"(= (get-dir (turn_left '(0 8 0 0) 2)) 2)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Turn900DegreeLeft()
        {
            var result = (bool)"(= (get-dir (turn_left '(0 8 0 0) 10)) 2)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_TurnMinus90DegreeRight()
        {
            var result = (bool)"(= (get-dir (turn_right '(0 8 0 0) -1)) 1)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Turn0DegreeRight()
        {
            var result = (bool)"(= (get-dir (turn_right '(0 8 0 0) 0)) 0)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Turn90DegreeRight()
        {
            var result = (bool)"(= (get-dir (turn_right '(0 8 0 0) 1)) 3)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Turn180DegreeRight()
        {
            var result = (bool)"(= (get-dir (turn_right '(0 8 0 0) 2)) 2)".Eval();
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Turn900DegreeRight()
        {
            var result = (bool)"(= (get-dir (turn_right '(0 8 0 0) 10)) 2)".Eval();
            Assert.IsTrue(result);
        }
    }
}
