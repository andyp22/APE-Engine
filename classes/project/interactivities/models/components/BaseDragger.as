/**
 * classes.project.interactivities.models.components.BaseDragger
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.components  {
	
	import classes.project.interactivities.Interactivity;
	import classes.project.interactivities.events.DragAndDropEvent;
	import classes.project.interactivities.models.components.IDragger;
	import classes.project.interactivities.models.components.IBay;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class BaseDragger extends Sprite implements IDragger  {
		
		private var _clip:MovieClip;
		private var _id:String;
		private var _txt:String;
		private var _bEnabled:Boolean;
		
		private var _startX:Number;
		private var _startY:Number;
		
		private var _correctBay:IBay;
		private var _currentBay:IBay;
		private var _sourceBay:IBay;
		private var _correct:Boolean;
		
		
		public function BaseDragger(mc:MovieClip, sId:String)  {
			//trace("Creating new BaseDragger -- " + this);
			this._clip = mc;
			this._id = sId;
			this._correct = false;
			this._bEnabled = true;
			this.init();
		}
		
		private function init():void  {
			//trace("BaseDragger initializing...");
			this.addChild(this._clip);
			this._clip.buttonMode = true;
			this._clip.mouseChildren = false;
			
			this.initDragger();
			
			this._startX = this.x;
			this._startY = this.y;
		}
		private function initDragger():void  {
			
			this._clip.addEventListener(MouseEvent.MOUSE_DOWN, handlePress);
			this._clip.addEventListener(MouseEvent.MOUSE_UP, handleRelease);
			this._clip.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			this._clip.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
		}
		
		public function getID():String  {
			return this._id;
		}
		public function getXPos():Number  {
			return this.x;
		}
		public function getYPos():Number  {
			return this.y;
		}
		public function getStartX():Number  {
			return this._startX;
		}
		public function getStartY():Number  {
			return this._startY;
		}
		public function resetPos():void  {
			this.x = this._startX;
			this.y = this._startY;
		}
		public function setStartPos(nX:Number, nY:Number):void  {
			this.x = this._startX = nX;
			this.y = this._startY = nY;
		}
		
		public function setText(sText:String):void  {
			var nPadding:int = this._clip.tf.y - this._clip.mcBg.y;
			this._txt = sText;
			this._clip.tf.htmlText = this._txt;
			this._clip.tf.autoSize = TextFieldAutoSize.CENTER;
			this._clip.mcBg.height = this._clip.tf.height + nPadding*2;
		}
		public function setCorrectBay(bay:IBay):void  {
			this._correctBay = bay;
		}
		public function getCorrectBay():IBay  {
			return this._correctBay;
		}
		public function setCurrentBay(bay:IBay):void  {
			this._currentBay = bay;
		}
		public function getCurrentBay():IBay  {
			return this._currentBay;
		}
		public function setSourceBay(bay:IBay):void  {
			this._sourceBay = bay;
		}
		public function getSourceBay():IBay  {
			return this._sourceBay;
		}
		public function setCorrect(b:Boolean):void  {
			this._correct = b;
		}
		public function isCorrect():Boolean  {
			return this._correct;
		}
		
		/*
		 *	Mouse handlers
		 */
		 public function handlePress(e:MouseEvent):void  {
			 //trace("dragger press");
			 if(this._bEnabled)  {
				 this.startDrag(false);
				 [Inject] Interactivity.dispatch(new DragAndDropEvent(DragAndDropEvent.START_DRAG, this));
			 }
		 }
		 public function handleRelease(e:MouseEvent):void  {
			 //trace("dragger release");
			 if(this._bEnabled)  {
				 this.stopDrag();
				 [Inject] Interactivity.dispatch(new DragAndDropEvent(DragAndDropEvent.STOP_DRAG, this));
			 }
		 }
		 public function handleOver(e:MouseEvent):void  {
			 //trace("dragger over");
			 if(this._bEnabled)  {
				 
			 }
		 }
		 public function handleOut(e:MouseEvent):void  {
			 //trace("dragger out");
			 if(this._bEnabled)  {
				 
			 }
		 }
		 
		 
		 public function disable():void  {
			 //trace("disable()");
			 this._bEnabled = false;
			 this._clip.buttonMode = false;
		 }
		 public function enable():void  {
			 //trace("enable()");
			 this._bEnabled = true;
			 this._clip.buttonMode = true;
		 }
		
		
		override public function toString():String  {
			return "classes.project.interactivities.models.components.BaseDragger";
		}
	}
}