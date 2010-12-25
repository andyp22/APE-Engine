/**
 * classes.project.model.grid.HexUnit
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.core.MapManager;
	import classes.project.core.Server;
	import classes.project.events.UnitFocusEvent;
	import classes.project.model.grid.HexPiece;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class HexUnit extends HexPiece {
		
		private var _ctrlPressed:Boolean = false;
		
		private var _offenseRating:Number = -1;
		private var _defenseRating:Number = -1;
		private var _hitpoints:Number = 1;
		private var _movementPoints:Number = 1;
		
		/**
		 * Constructor
		 */
		public function HexUnit(id:Number, sName:String, mc:MovieClip)  {
			trace("Creating a new HexUnit...");
			super(id, sName, mc);
			
			this.init();
		}
		private function init():void  {
			trace("HexUnit init()");
			
			this.buttonMode = true;
			this.mouseChildren = false;
		}
		override public function handleRollOver(e:MouseEvent):void  {
			super.handleRollOver(e);
		}
		override public function handleRollOut(e:MouseEvent):void  {
			super.handleRollOut(e);
		}
		override public function handleMousePress(e:MouseEvent):void  {
			//when clicked this piece should dispatch two events
			// one that destroys the old focus and
			// one that tells the RegionMapMediator this unit has focus now
			[Inject] Server.dispatch(new UnitFocusEvent("DESTROY_UNIT_FOCUS"));
			
			this.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyPress);
			this.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyRelease);
			[Inject] Server.dispatch(new UnitFocusEvent("NEW_UNIT_FOCUS", this));
		}
		public function handleKeyPress(e:KeyboardEvent):void  {
			//trace("handleKeyPress() -- "+e.keyCode);
			var _Ctrl:Number = 17;		//Control key
			
			switch(e.keyCode)  {
				case _Ctrl:
					_ctrlPressed = true;
					break;
			}
			
		}
		public function handleKeyRelease(e:KeyboardEvent):void  {
			//trace("handleKeyRelease() -- "+typeof(e.keyCode));
			
			var _Q:Number = 81;			//NW
			var _W:Number = 87;			//N
			var _E:Number = 69;			//NE
			var _A:Number = 65;			//SW
			var _S:Number = 83;			//S
			var _D:Number = 68;			//SE
			
			var _Ctrl:Number = 17;		//Control key
			var _C:Number = 67;			//Center map on me
			
			var nX:Number = 0;
			var nY:Number = 0;
			
			//trace("e.keyCode: "+e.keyCode);
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
				case _C:
					if(_ctrlPressed)  {
						[Inject] Server.dispatch(new UnitFocusEvent("CENTER_FOCUSED_UNIT"));
					}
					return;
				case _Ctrl:
					_ctrlPressed = false;
					return;
			}
			var moveX:Number = this.x + nX;
			var moveY:Number = this.y + nY;
			if(this.checkMove(moveX, moveY))  {
				this.setPosition(moveX, moveY);
				[Inject] Server.dispatch(new UnitFocusEvent("UNIT_POSITION_UPDATED"));
			}
		}
		public function checkMove(nX:Number, nY:Number):Boolean  {
			[Inject] var grid:IGrid = MapManager.getGrid(CURRENT_MAP);
			if(grid.getTileByLocation(nX, nY) != null)  {
				if(grid.getTileByLocation(nX, nY).isWalkable())  {
					return true;
				}
			}
			return false;
		}
		
		public function removeFocus():void  {
			trace("removing focus: "+ this._sName);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyPress);
			this.removeEventListener(KeyboardEvent.KEY_UP, this.handleKeyRelease);
		}
		public function rotateAvatar(nDir:Number):void  {
			//trace("rotation: "+this._clip.rotation);
			this._clip.rotation = nDir;
		}
		
		
	}
}