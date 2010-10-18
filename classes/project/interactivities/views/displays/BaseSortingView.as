/**
 * classes.project.interactivities.views.displays.BaseSortingView
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.views.displays  {
	
	import classes.project.core.LibFactory;
	import classes.project.interactivities.Interactivity;
	import classes.project.interactivities.events.DragAndDropEvent;
	import classes.project.interactivities.events.InteractivityEvent;
	import classes.project.interactivities.models.components.BaseDragger;
	import classes.project.interactivities.models.components.BaseDraggerBay;
	import classes.project.interactivities.models.components.IBay;
	import classes.project.interactivities.models.components.IDragger;
	import classes.project.interactivities.models.components.SubmitButton;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class BaseSortingView extends Sprite  {
		
		private var _clip:MovieClip;
		//bays
		private var _optionsBay:BaseDraggerBay;
		private var _primaryBay:BaseDraggerBay;
		private var _secondaryBay:BaseDraggerBay;
		
		private var _startX:Number;
		private var _startY:Number;
		private var _currentDragger:IDragger;
		private var _draggers:Array;
		private var _bays:Array;
		private var bShowing:Boolean;
		
		private var _submit_btn:SubmitButton;
		
		public function BaseSortingView(mc:MovieClip)  {
			trace("Creating new BaseSortingView -- " + this);
			this._clip = mc;
			this._currentDragger = null;
			this._draggers = new Array();
			this._bays = new Array();
		}
		
		public function init():void  {
			trace("BaseSortingView initializing...");
			
			this.initBays();
			this.initDraggers();
			this.initSubmit();
			
			this.addChild(this._clip);
			[Inject] Interactivity.dispatch(new InteractivityEvent(InteractivityEvent.ACTIVITY_CREATED));
			this.hide();
		}

		private function initBays():void  {
			var nX:Number = 10;
			var nY:Number = 10;
			
			
			_optionsBay = new BaseDraggerBay(LibFactory.createMovieClip("DraggerBay_MC"), "b0");
			_optionsBay.setPosition(nX, nY);
			_optionsBay.setHeader("Options Sheet");
			_optionsBay.setType("source");
			
			this._clip.addChild(_optionsBay);
			this._bays.push(_optionsBay);
			
			nX += _optionsBay.width + 20;
			
			_primaryBay = new BaseDraggerBay(LibFactory.createMovieClip("DraggerBay_MC"), "b1");
			_primaryBay.setPosition(nX, nY);
			_primaryBay.setHeader("Primary Expenses");
			
			this._clip.addChild(_primaryBay);
			this._bays.push(_primaryBay);
			
			nX += _primaryBay.width + 10;
			
			_secondaryBay = new BaseDraggerBay(LibFactory.createMovieClip("DraggerBay_MC"), "b2");
			_secondaryBay.setPosition(nX, nY);
			_secondaryBay.setHeader("Secondary Expenses");
			
			this._clip.addChild(_secondaryBay);
			this._bays.push(_secondaryBay);
			
		}
		
		private function initDraggers():void  {
			var nX:Number = 10;
			var nY:Number = 10;
			
			
			var dragger0:BaseDragger = new BaseDragger(LibFactory.createMovieClip("BaseDragger_MC"), "d0");
			dragger0.setText("dragger0");
			dragger0.setCorrectBay(_secondaryBay);
			this._draggers.push(dragger0);
			
			var dragger1:BaseDragger = new BaseDragger(LibFactory.createMovieClip("BaseDragger_MC"), "d1");
			dragger1.setText("dragger1");
			dragger1.setCorrectBay(_primaryBay);
			this._draggers.push(dragger1);
			
			var dragger2:BaseDragger = new BaseDragger(LibFactory.createMovieClip("BaseDragger_MC"), "d2");
			dragger2.setText("dragger2");
			dragger2.setCorrectBay(_secondaryBay);
			this._draggers.push(dragger2);
			
			var dragger3:BaseDragger = new BaseDragger(LibFactory.createMovieClip("BaseDragger_MC"), "d3");
			dragger3.setText("dragger3");
			dragger3.setCorrectBay(_primaryBay);
			this._draggers.push(dragger3);
			
			var dragger4:BaseDragger = new BaseDragger(LibFactory.createMovieClip("BaseDragger_MC"), "d4");
			dragger4.setText("dragger4");
			dragger4.setCorrectBay(_secondaryBay);
			this._draggers.push(dragger4);
			
			for(var i:int = 0; i < this._draggers.length; i++)  {
				this._clip.addChild(this._draggers[i]);
				_optionsBay.addDragger(this._draggers[i]);
				this._draggers[i].setSourceBay(_optionsBay);
			}
			
			_optionsBay.updateDisplay();
		}
		
		private function initSubmit():void  {
			this._submit_btn = new SubmitButton("activity_submit_btn", LibFactory.createMovieClip("MenuButton"));
			this._submit_btn.setReleaseEvent(InteractivityEvent.SUBMIT_PRESSED);
			this._submit_btn.setText("Submit");
			this._submit_btn.disableTooltip();
			this._submit_btn.x = this._clip.width/2 - this._submit_btn.width/2;
			this._submit_btn.y = this._clip.height - (this._submit_btn.height + 5);
			this._clip.addChild(this._submit_btn);
			this.disableSubmit();
			
		}
		public function enableSubmit():void  {
			if(this.targetBaysFilled() || this.allDraggersHaveBays())  {
				trace("enableSubmit()");
				this._submit_btn.enable();
			}
		}
		public function disableSubmit():void  {
			this._submit_btn.disable();
		}
		
		public function handleDrop():void  {
			//trace("handleDrop()");
			var currentX:Number = stage.mouseX;
			var currentY:Number = stage.mouseY;
			var currentBay:IBay;
			
			for(var j:int = 0; j < this._bays.length; j++)  {
				if(this._bays[j].hasDragger(this._currentDragger.getID()))  {
					currentBay = this._bays[j];
				}
			}
			for(var k:int = 0; k < this._bays.length; k++)  {
				if((currentX >= this._bays[k].getXPos()) && (currentX <= (this._bays[k].getXPos() + this._bays[k].getWidth())))  {
					if((currentY >= this._bays[k].getYPos()) && (currentY <= (this._bays[k].getYPos() + this._bays[k].getHeight())))  {
						if(!this._bays[k].hasMaxDraggers() || this._bays[k].getType() == "source")  {
							currentBay.removeDragger(this._currentDragger.getID());
							currentBay.updateDisplay();
							this._bays[k].addDragger(this._currentDragger);
							this._bays[k].updateDisplay();
						}
					}
				}
			}
			this.resetDraggerPos();
			this.enableSubmit();
		}
		
		public function resetDraggerPos():void  {
			this._currentDragger.resetPos();
		}
		public function setDragger(dragger:IDragger):void  {
			this._currentDragger = dragger;
		}
		
		public function lockDraggers():void  {
			for(var i:int = 0; i < this._draggers.length; i++)  {
				this._draggers[i].disable();
			}
		}
		public function unlockDraggers():void  {
			for(var i:int = 0; i < this._draggers.length; i++)  {
				this._draggers[i].enable();
			}
		}
		private function resetDraggers():void  {
			for(var i:int = 0; i < this._draggers.length; i++)  {
				var dragger:IDragger = this._draggers[i];
				var sourceBay:IBay = dragger.getSourceBay();
				sourceBay.addDragger(dragger);
			}
			for(var j:int = 0; j < this._bays.length; j++)  {
				this._bays[j].updateDisplay();
			}
		}
		private function resetBays():void  {
			for(var i:int = 0; i < this._bays.length; i++)  {
				this._bays[i].resetDisplay();
			}
		}
		public function targetBaysFilled():Boolean  {
			var bFilled:Boolean = true;
			for(var i:int = 0; i < this._bays.length; i++)  {
				if(this._bays[i].getType() == "target")  {
					if(!this._bays[i].hasMaxDraggers())  {
						bFilled = false;
					}
				}
			}
			return bFilled;
		}
		public function allDraggersHaveBays():Boolean  {
			var bEmpty:Boolean = true;
			for(var i:int = 0; i < this._bays.length; i++)  {
				if(this._bays[i].getType() == "source")  {
					if(!(this._bays[i].draggerList().length == 0))  {
						bEmpty = false;
					}
				}
			}
			return bEmpty;
		}
		public function getEvaluatorArgs():Object  {
			var oArgs:Object = new Object();
			oArgs.bays = this._bays;
			oArgs.draggers = this._draggers;
			return oArgs;
		}
		public function showCorrect():void  {
			for(var i:int = 0; i < this._draggers.length; i++)  {
				var dragger:IDragger = this._draggers[i];
				var currentBay:IBay = dragger.getCurrentBay();
				var correctBay:IBay = dragger.getCorrectBay();
				currentBay.removeDragger(dragger.getID());
				correctBay.addDragger(dragger);
				
			}
			for(var j:int = 0; j < this._bays.length; j++)  {
				this._bays[j].updateDisplay();
			}
		}
		public function toggleView():void  {
			if(this.bShowing)  {
				this.hide();
			} else  {
				this.show();
			}
		}
		public function show():void  {
			trace("Showing -- sorting");
			this.bShowing = true;
			this.visible = true;
		}
		public function hide():void  {
			trace("Hiding -- sorting");
			this.bShowing = false;
			this.visible = false;
		}
		public function isShowing():Boolean  {
			return this.bShowing;
		}
		public function resetView():void  {
			this.resetBays();
			this.resetDraggers();
			this.unlockDraggers();
			this.disableSubmit();
			
			this._currentDragger = null;
		}
		
	}
}