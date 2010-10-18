/**
 * classes.project.interactivities.models.components.BaseDraggerBay
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.components  {
	
	import classes.project.interactivities.Interactivity;
	import classes.project.interactivities.events.DragAndDropEvent;
	import classes.project.interactivities.models.components.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import flash.text.TextFieldAutoSize;
	
	public class BaseDraggerBay extends Sprite implements IBay  {
		private var PADDING:uint = 3;
		
		private var _clip:MovieClip;
		private var _id:String;
		private var _type:String;
		private var _header_txt:String;
		
		private var _draggerList:Array;
		
		private var MAX_DRAGGERS:uint = 3;
		
		
		public function BaseDraggerBay(mc:MovieClip, sId:String)  {
			//trace("Creating new BaseDraggerBay -- " + this);
			this._clip = mc;
			this._id = sId;
			this._type = "target";
			this.init();
		}
		
		private function init():void  {
			//trace("BaseDraggerBay initializing...");
			this._draggerList = new Array();
			
			this.addChild(this._clip);
		}
		
		public function setPosition(nX:Number, nY:Number):void  {
			this.x = nX;
			this.y = nY;
		}
		public function setHeader(sText:String):void  {
			var nPadding:int = this._clip.mcHeader.tf.y - this._clip.mcHeader.mcBg.y;
			this._header_txt = sText;
			this._clip.mcHeader.tf.htmlText = this._header_txt;
			this._clip.mcHeader.tf.autoSize = TextFieldAutoSize.CENTER;
			this._clip.mcHeader.mcBg.height = this._clip.mcHeader.tf.height + nPadding*2;
			
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
		public function getWidth():Number  {
			return this.width;
		}
		public function getHeight():Number  {
			return this.height;
		}
		public function getType():String  {
			return this._type;
		}
		public function setType(sType:String):void  {
			this._type = sType;
		}
		
		public function addDragger(dragger:IDragger):void  {
			this._draggerList.push(dragger);
		}
		public function hasDragger(sId:String):Boolean  {
			for(var i:int = 0; i < this._draggerList.length; i++)  {
				if(this._draggerList[i].getID() == sId)  {
					return true;
				}
			}
			return false;
		}
		public function getDragger(sId:String):IDragger  {
			for(var i:int = 0; i < this._draggerList.length; i++)  {
				if(this._draggerList[i].getID() == sId)  {
					return this._draggerList[i];
				}
			}
			return null;
		}
		public function removeDragger(sId:String):void  {
			for(var i:int = 0; i < this._draggerList.length; i++)  {
				if(this._draggerList[i].getID() == sId)  {
					this._draggerList.splice(i, 1);
				}
			}
		}
		public function draggerList():Array  {
			return this._draggerList;
		}
		
		public function updateDisplay():void  {
			var nX:Number = this.x + 5;
			var nY:Number = this.y + this._clip.mcHeader.height + PADDING;
			
			for(var i:int = 0; i < this._draggerList.length; i++)  {
				this._draggerList[i].setStartPos(nX, nY);
				nY += this._draggerList[i].height + PADDING;
			}
		}
		public function hasMaxDraggers():Boolean  {
			if(this._draggerList.length >= MAX_DRAGGERS)  {
					return true;
			}
			return false;
		}
		public function setMaxDraggers(n:uint):void  {
			MAX_DRAGGERS = n;
		}
		
		public function resetDisplay():void  {
			this._draggerList = new Array();
		}
		
		
		
		
		override public function toString():String  {
			return "classes.project.interactivities.models.components.BaseDraggerBay";
		}
	}
}