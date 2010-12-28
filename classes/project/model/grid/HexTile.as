/**
 * classes.project.model.grid.HexTile
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.model.grid.ITile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class HexTile extends Sprite implements ITile {
		
		private var _clip:MovieClip;
		private var _id:String;
		
		private var _xPos:int;
		private var _yPos:int;
		
		private var _type:String;
		
		private var _walkable:Boolean;
		
		
		/**
		 * Constructor
		 */
		public function HexTile(sId:String, mc:MovieClip, sType:String = "default")  {
			//trace("Creating new HexTile...");
			this._id = sId;
			this._clip = mc;
			this.init();
			this.setType(sType);
		}
		private function init():void  {
			addChild(this._clip);
			
			this._walkable = true;
			
			//TODO: have the visiblity of this field by based on release tag
			//var bTesting:Boolean = true;
			var bTesting:Boolean = false;
			if(!bTesting)  {
				this._clip.mcBg.tf.visible = false;
			}
			this._clip.mcBg.tf.text = this._id;
			
			this._clip.mcBg.buttonMode = true;
			this._clip.mcBg.mouseChildren = false;
			this._clip.mcBg.mcHover.visible = false;
			
			this._clip.mcBg.addEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
			this._clip.mcBg.addEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
		}
		
		public function setPos(nX:Number, nY:Number):void  {
			this.x = this._xPos = nX;
			this.y = this._yPos = nY;
		}
		public function atPosition(nX:Number, nY:Number):Boolean  {
			if(this.x == nX && this.y == nY)  {
				return true;
			}
			return false
		}
		public function getID():String  {
			return this._id;
		}
		public function getHeight():Number  {
			return this._clip.mcBg.height;
		}
		public function getWidth():Number  {
			return this._clip.mcBg.width;
		}
		public function xPos():Number  {
			return this._xPos;
		}
		public function yPos():Number  {
			return this._yPos;
		}
		public function setWalkable(b:Boolean):void  {
			this._walkable = b;
		}
		public function isWalkable():Boolean  {
			return this._walkable;
		}
		public function isWater():Boolean  {
			if(this._type.indexOf("water") > -1)  {
				return true;
			}
			return false;
		}
		public function setType(sType:String):void  {
			this._type = sType;
			this._clip.mcBg.mcTerrain.gotoAndStop(this._type);
		}
		
		public function handleRollOver(e:MouseEvent):void  {
			//trace("handleRollOver() -- "+e.target);
			//trace("Position: "+this.x+" -- "+this.y);
			this._clip.mcBg.mcHover.visible = true;
		}
		public function handleRollOut(e:MouseEvent):void  {
			//trace("handleRollOver() -- "+e.target);
			this._clip.mcBg.mcHover.visible = false;
		}
		
	}
}