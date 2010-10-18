/**
 * classes.project.views.components.HexMapView
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.MapManager;
	import classes.project.core.Server;
	import classes.project.model.ContainerPanel;
	import classes.project.model.Player;
	import classes.project.model.grid.HexGrid;
	import classes.project.model.grid.ITile;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class HexMapView extends ContainerPanel  {
		
		[Inject] private var _hexGrid:HexGrid;
		[Inject] private var _player:Player;
		
		private var _mask:Sprite;
		private var MASK_WIDTH:Number = 500;
		private var MASK_HEIGHT:Number = 400;
		
		
		public function HexMapView(sName:String, mc:MovieClip)  {
			trace("Creating new HexMapView -- " + this + " : " + sName);
			super(sName, mc);
			
			
			
			this.init();
		}
		
		private function init():void  {
			trace("HexMapView initializing...");
			addChild(this.mcContent);
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = this.mcHeader.height + nPadding;
			
			this.loadBackground();
			// build our grid
			this.initGrid();
			this.initPlayer();
			
			addChild(this.mcContent);
		}
		
		override public function sizeToContents():void  {
			var nPadding:int = this.mcContent.x;
			var newWidth:int = this._mask.width + nPadding*2;
			var newHeight:int = this.mcHeader.height + this._mask.height + nPadding*2;
			var widthDiff:int = this.mcPanel.mcBg.width - newWidth;
			
			this.mcPanel.mcBg.width = this.mcHeader.mcBg.width = newWidth;
			this.mcPanel.mcBg.height = newHeight;
			this.mcClose.x -= widthDiff;
		}
		
		private function initGrid():void  {
			var startX:int = 20;
			var startY:int = 20;
			
			this._mask = this.createMask();
			this.mcContent.addChild(this._mask);
			
			this._hexGrid = new HexGrid("sample_map", startX, startY, "small");
			[Inject] this._hexGrid.setGridData(MapManager.getGridXML("sample_map"));
			this._hexGrid.mask = this._mask;
			this.mcContent.addChild(this._hexGrid);
			
			[Inject] MapManager.registerGrid(this._hexGrid);
			
			
		}
		private function createMask():Sprite  {
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0xFF0000);
			square.graphics.drawRect(0, 0, MASK_WIDTH, MASK_HEIGHT);
			return square;
			
		}
		private function loadBackground():void  {
			var square:Sprite = new Sprite();
			square.name = "background";
			square.graphics.beginFill(0x003399);
			square.graphics.drawRect(0, 0, MASK_WIDTH, MASK_HEIGHT);
			this.mcContent.addChild(square);
		}
		
		
		private function initPlayer():void  {
			this._player = new Player(LibFactory.createMovieClip("Player_MC"));
			
			var nX:Number = 260;
			var nY:Number = 340;
			this._player.setPosition(nX, nY);
			
			this.mcContent.addChild(this._player);

			this._player.buttonMode = true;
			this._player.mouseChildren = false;
			
			this._player.centerMap();
			
			trace("Current Tile: "+this._hexGrid.getTileByLocation(this._player.x, this._player.y).getID());
			
		}
		
	}
}