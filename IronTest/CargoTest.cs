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
        public void ItShould_PickUpObject1AtWorkstation1()
        {
            var result = (bool)"(= (get-cargo (pick_object '(29 2 0 0) 1)) 1)".Eval();

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_NotPickUpObject2AtWorkstation1()
        {
            var result = (bool)"(= (get-cargo (pick_object '(29 2 0 0) 2)) 0)".Eval();

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_NotPickUpObject1OutsidePickUpPoint()
        {
            var result = (bool)"(= (get-cargo (pick_object '(0 8 0 0) 1)) 0)".Eval();

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_DropObject1AtWorkstation2()
        {
            var result = (bool)"(= (get-cargo (drop_object '(6 1 0 1))) 0)".Eval();

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_NotDropObject2AtWorkstation2()
        {
            var result = (bool)"(= (get-cargo (drop_object '(6 1 0 2))) 2)".Eval();

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_NotDropObjectOutsideDropOffPoint()
        {
            var result = (bool)"(= (get-cargo (drop_object '(0 8 0 2))) 2)".Eval();

            Assert.IsTrue(result);
        }  
    }
}
