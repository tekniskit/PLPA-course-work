using System;
using IronScheme;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IronTest
{
    [TestClass]
    public class MoveTest
    {
        private const string Main = "(include \"../../../IronFist/Scheme/main.scm\")";

        [TestMethod]
        public void ItShould_Move0StepsForwardOnPath()
        {
            var result = (bool)(Main + "(= (get-x (move_forward '(0 8 0 0) 0)) 0)").Eval();

            Assert.IsTrue(result);
        }
        
        [TestMethod]
        public void ItShould_Move1StepForwardOnPath()
        {
            var result = (bool)(Main +  "(= (get-x (move_forward '(0 8 0 0) 1)) 1)").Eval();

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void ItShould_Move10StepsForwardOnPath()
        {
            var result = (bool)(Main + "(= (get-x (move_forward '(0 8 0 0) 10)) 10)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_NotLeaveDesignatedPathsWhileMovingForward()
        {
            var result = (bool)(Main + "(= (get-x (move_forward '(0 9 0 0) 10)) 3)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_BeAbleToCrossPickUpPoints()
        {
            var result = (bool)(Main + "(= (get-x (move_forward '(5 1 0 0) 2)) 7)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_AbleToCrossDropOffPoints()
        {
            var result = (bool)(Main + "(= (get-y (move_forward '(8 3 3 0) 2)) 5)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_NotBeAbleToMoveIntoWorkstation()
        {
            var result = (bool)(Main + "(= (get-y (move_forward '(7 1 3 0) 1)) 1)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_Move0StepsBackwardOnPath()
        {
            var result = (bool)(Main + "(= (get-x (move_backward '(0 8 0 0) 0)) 0)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_Move1StepBackwardOnPath()
        {
            var result = (bool)(Main + "(= (get-x (move_backward '(0 8 2 0) 1)) 1)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_Move10StepsBackwardOnPath()
        {
            var result = (bool)(Main + "(= (get-x (move_backward '(0 8 2 0) 10)) 10)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_NotLeaveDesignatedPathsWhileMovingBackward()
        {
            var result = (bool)(Main + "(= (get-x (move_backward '(0 9 2 0) 10)) 3)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_BeAbleToCrossPickUpPointsBackward()
        {
            var result = (bool)(Main + "(= (get-x (move_backward '(5 1 2 0) 2)) 7)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_BeAbleToCrossDropOffPointsBackward()
        {
            var result = (bool)(Main + "(= (get-y (move_backward '(8 3 1 0) 2)) 5)").Eval();

            Assert.IsTrue(result);
        }
        [TestMethod]
        public void ItShould_NotBeAbleToMoveIntoWorkstationBackward()
        {
            var result = (bool)(Main + "(= (get-y (move_backward '(7 1 1 0) 1)) 1)").Eval();

            Assert.IsTrue(result);
        }

    }
}
