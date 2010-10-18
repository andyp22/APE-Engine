/**
 * classes.project.interactivities.models.evaluation.BaseEvaluation
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.evaluation  {
	
	import classes.project.interactivities.models.components.IBay;
	import classes.project.interactivities.models.evaluation.IEvaluation;
	
	
	public class BaseEvaluation implements IEvaluation  {
		
		private var _correctDraggers:Array;
		private var _incorrectDraggers:Array;
		private var _allCorrect:Boolean;
		
		private var _bays:Array = new Array();
		private var _draggers:Array = new Array();
		
		public function BaseEvaluation()  {
			trace("Creating BaseEvaluation...");
			
		}
		public function setupEvaluator(oArgs:Object):void  {
			this._correctDraggers = new Array();
			this._incorrectDraggers = new Array();
			this._allCorrect = false;
			
			this._bays = oArgs.bays;
			this._draggers = oArgs.draggers;
		}
		
		public function doEvaluation():void  {
			trace("doEvaluation()");
			this._allCorrect = true;
			for(var i:int = 0; i < this._bays.length; i++)  {
				if(!this.evaluateBay(this._bays[i]))  {
					this._allCorrect = false;
				}
			}
			trace("All correct? "+this._allCorrect);
			if(!this._allCorrect)  {
				for(var j:int = 0; j < this._draggers.length; j++)  {
					if(!this._draggers[j].isCorrect())  {
						this._draggers[j].getCurrentBay().removeDragger(this._draggers[j].getID());
						this._draggers[j].getSourceBay().addDragger(this._draggers[j]);
						this._draggers[j].setCurrentBay(this._draggers[j].getSourceBay());
					}
				}
				for(var k:int = 0; k < this._bays.length; k++)  {
					this._bays[k].updateDisplay();
				}
			}
			
		}
		private function evaluateBay(bay:IBay):Boolean  {
			var aList:Array = bay.draggerList();
			var bAllCorrect:Boolean = true;
			for(var i:int = 0; i < aList.length; i++)  {
				aList[i].setCurrentBay(bay);
				if(aList[i].getCorrectBay().getID() == bay.getID())  {
					aList[i].setCorrect(true);
					this._correctDraggers.push(aList[i]);
				} else  {
					bAllCorrect = false;
					aList[i].setCorrect(false);
					this._incorrectDraggers.push(aList[i]);
				}
			}
			return bAllCorrect;
		}
		
		public function getCorrectDraggers():Array  {
			return this._correctDraggers;
		}
		public function getIncorrectDraggers():Array  {
			return this._incorrectDraggers;
		}
		public function allCorrect():Boolean  {
			return this._allCorrect;
		}
		public function resetEval():void  {
			this._correctDraggers = new Array();
			this._incorrectDraggers = new Array();
			this._allCorrect = false;
		}
		
		
	}
}