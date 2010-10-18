/**
 * classes.project.model.Player
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model {
	
	import classes.project.core.Labels;
	import classes.project.core.MapManager;
	import classes.project.model.Tooltips;
	import classes.project.model.grid.IGrid;
	import classes.project.model.grid.ITile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class Player extends Sprite {
		
		private var CURRENT_MAP:String = "sample_map";
		
		private var _clip:MovieClip;
		private var _currentTile:ITile = null;
		
		
		/**
		 * Constructor
		 */
		public function Player(mc:MovieClip)  {
			trace("Creating a new Player...");
			super();
			this._clip = mc;
			this.init();
		}
		private function init():void  {
			addChild(this._clip);
			
			this.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyPress);
			this.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyRelease);
			this.addEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
		}
		public function setPosition(nX:Number, nY:Number):void  {
			this.x = nX;
			this.y = nY;
			this._currentTile = this.getCurrentTile();
		}
		public function centerMap():void  {
			[Inject] var grid:IGrid = MapManager.getGrid(CURRENT_MAP);
			
			var mapH:Number = grid.getHeight();
			var mapW:Number = grid.getWidth();
			var maskH:Number = grid.getMask().height;
			var maskW:Number = grid.getMask().width;
			
			if(this.x != maskW/2 || this.y != maskH/2)  {
				var xDiff:Number = (maskW/2 - this.x);
				var yDiff:Number = (maskH/2 - this.y);
				
				if(this._currentTile.xPos() < (maskW/2 - this._currentTile.getWidth()*(1/4)))  {
					//trace("less than halfway to the left side");
					xDiff = 0;
				}
				if(this._currentTile.xPos() > (mapW - (maskW/2 - this._currentTile.getWidth()*(1/4))))  {
					//trace("less than halfway to the right side");
					xDiff = 0;
				}
				if(this._currentTile.yPos() < (maskH/2 - this._currentTile.getHeight()*(3/4)))  {
					//trace("less than halfway to the top");
					yDiff = 0;
				}
				if(this._currentTile.yPos() > (mapH - (maskH/2 - this._currentTile.getHeight()*(3/4))))  {
					//trace("less than halfway to the bottom");
					yDiff = 0;
				}
				
				grid.updatePosition(xDiff, yDiff);
				this.x += xDiff;
				this.y += yDiff;
			}
		}
		
		public function handleKeyPress(e:KeyboardEvent):void  {
			//trace("handleKeyPress() -- "+e.keyCode);
			//trace("ctrlKey: " + e.ctrlKey);
            //trace("keyLocation: " + e.keyLocation);
            //trace("shiftKey: " + e.shiftKey);
            //trace("altKey: " + e.altKey);
		}
		public function handleKeyRelease(e:KeyboardEvent):void  {
			//trace("handleKeyRelease() -- "+typeof(e.keyCode));
			
			var _Q:Number = 81;		//NW
			var _W:Number = 87;		//N
			var _E:Number = 69;		//NE
			var _A:Number = 65;		//SW
			var _S:Number = 83;		//S
			var _D:Number = 68;		//SE
			
			var nX:Number = 0;
			var nY:Number = 0;
			
			switch(e.keyCode)  {
				case _Q:
					//trace("Q -- northwest");
					//subtract half the height of the tile
					//and subtract 3/4 of the width
					nX = (this._currentTile.getWidth()*(3/4)) * (-1);
					nY = (this._currentTile.getHeight()/2) * (-1);
					this.rotateAvatar(305);
					break;
				case _W:
					//trace("W -- north");
					//subtract the height of the tile
					nY = this._currentTile.getHeight() * (-1);
					this.rotateAvatar(0);
					break;
				case _E:
					//trace("E -- northeast");
					//subtract half the height of the tile
					//and add 3/4 of the width
					nX = this._currentTile.getWidth()*(3/4);
					nY = (this._currentTile.getHeight()/2) * (-1);
					this.rotateAvatar(55);
					break;
				case _A:
					//trace("A -- southwest");
					//add half the height of the tile
					//and subtract 3/4 of the width
					nX = (this._currentTile.getWidth()*(3/4)) * (-1);
					nY = this._currentTile.getHeight()/2;
					this.rotateAvatar(235);
					break;
				case _S:
					//trace("S -- south");
					//add the height of the tile
					nY = this._currentTile.getHeight();
					this.rotateAvatar(180);
					break;
				case _D:
					//trace("D -- southeast");
					//add half the height of the tile
					//and add 3/4 of the width
					nX = this._currentTile.getWidth()*(3/4);
					nY = this._currentTile.getHeight()/2;
					this.rotateAvatar(125);
					break;
			}
			var moveX:Number = this.x + nX;
			var moveY:Number = this.y + nY;
			if(this.checkMove(moveX, moveY))  {
				this.setPosition(moveX, moveY);
				this.centerMap();
			}
		}
		
		public function handleRollOver(e:MouseEvent):void  {
			[Inject] Tooltips.create(e);
		}
		public function handleRollOut(e:MouseEvent):void  {
			[Inject] Tooltips.destroy();
		}
		public function getTooltipText():String  {
			return Labels.getLabel("player_control_txt");
		}
		
		public function getCurrentTile():ITile  {
			[Inject] var grid:IGrid = MapManager.getGrid(CURRENT_MAP);
			return grid.getTileByLocation(this.x, this.y);
		}
		
		private function checkMove(nX:Number, nY:Number):Boolean  {
			[Inject] var grid:IGrid = MapManager.getGrid(CURRENT_MAP);
			if(grid.getTileByLocation(nX, nY) != null)  {
				if(grid.getTileByLocation(nX, nY).isWalkable())  {
					return true;
				}
			}
			return false;
		}
		public function rotateAvatar(nDir:Number):void  {
			//trace("rotation: "+this._clip.rotation);
			this._clip.rotation = nDir;
		}
		
		
		
	}
}