/**
 * classes.project.model.grid.HexPiece
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.core.Labels;
	import classes.project.core.MapManager;
	import classes.project.model.Tooltips;
	import classes.project.model.grid.IGrid;
	import classes.project.model.grid.IHexPiece;
	import classes.project.model.grid.ITile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class HexPiece extends Sprite implements IHexPiece {
		
		protected var _clip:MovieClip;
		protected var _id:Number;
		protected var _sName:String;
		protected var _factionID:Number;
		
		protected var _currentTile:ITile = null;
		protected var CURRENT_MAP:String = "game_map";
		
		/**
		 * Constructor
		 */
		public function HexPiece(id:Number, sName:String, mc:MovieClip)  {
			//trace("Creating a new HexPiece...");
			super();
			this._clip = mc;
			this._id = id;
			this._sName = sName;
			
			this.init();
		}
		private function init():void  {
			//trace("HexPiece init()");
			this.addChild(this._clip);
			
			this.addEventListener(MouseEvent.ROLL_OVER, handleRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, handleRollOut);
			this.addEventListener(MouseEvent.CLICK, handleMousePress);
		}
		public function setPosition(nX:Number, nY:Number):void  {
			this.x = nX;
			this.y = nY;
			this._currentTile = this.getCurrentTile();
		}
		
		public function handleRollOver(e:MouseEvent):void  {
			[Inject] Tooltips.create(e);
		}
		public function handleRollOut(e:MouseEvent):void  {
			[Inject] Tooltips.destroy();
		}
		public function handleMousePress(e:MouseEvent):void  {
			//will do something here based on extension
		}
		public function getTooltipText():String  {
			return Labels.getLabel("sample_piece_txt");
		}
		public function getCurrentTile():ITile  {
			[Inject] var grid:IGrid = MapManager.getGrid(CURRENT_MAP);
			return grid.getTileByLocation(this.x, this.y);
		}
		public function getID():Number  {
			return this._id;
		}
		public function setID(n:Number):void  {
			this._id = n;
		}
		public function getName():String  {
			return this._sName;
		}
		public function getFactionID():Number  {
			return this._factionID;
		}
		public function setFactionID(n:Number):void  {
			this._factionID = n;
		}
		public function destroy():void  {
			this.removeEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
			this.removeEventListener(MouseEvent.CLICK, this.handleMousePress);
			
			this.handleRollOut(new MouseEvent(MouseEvent.ROLL_OUT));
		}
		
	}
}