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
		
		protected var _currentTile:ITile = null;
		protected var CURRENT_MAP:String = "sample_map";
		
		/**
		 * Constructor
		 */
		public function HexPiece(id:Number, sName:String, mc:MovieClip)  {
			trace("Creating a new HexPiece...");
			super();
			this._clip = mc;
			this._id = id;
			this._sName = sName;
			
			this.init();
		}
		private function init():void  {
			trace("HexPiece init()");
			this.addChild(this._clip);
			
			this.addEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
			this.addEventListener(MouseEvent.CLICK, this.handleMousePress);
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
		public function getName():String  {
			return this._sName;
		}
		
	}
}