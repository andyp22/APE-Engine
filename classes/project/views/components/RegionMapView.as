/**
 * classes.project.views.components.RegionMapView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.MapManager;
	import classes.project.core.Server;
	import classes.project.events.GameControlEvent;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.model.grid.HexGrid;
	
	
	import classes.project.model.grid.HexPiece;
	import classes.project.model.grid.HexStructure;
	import classes.project.model.grid.HexUnit;
	import classes.project.model.grid.HexWaterUnit;
	
	
	import classes.project.model.grid.ITile;
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class RegionMapView extends BaseView  {
		
		private var _alert_lvl:Sprite;
		private var _popup_lvl:Sprite;
		private var _gui_lvl:Sprite;
		private var _clip:Sprite;
		private var _units_lvl:Sprite;
		private var _structures_lvl:Sprite;
		private var _terrain_lvl:Sprite;
		private var _map_lvl:Sprite;
		private var _mapMask:Sprite;
		
		[Inject] private var _hexGrid:HexGrid;
		
		
		/**
		 * Constructor
		 */
		public function RegionMapView(sName:String, mc:MovieClip)  {
			super(sName, mc);
			trace("Creating new RegionMapView() -- " + sName);
		}
		public function init(nW:Number, nH:Number):void  {
			//create the level holders
			this.initLevels();
			
			//create the mask and attach to the clip
			this._mapMask = this.createMask(nW, nH);
			this.addChild(this._mapMask);
			this._clip.mask = this._mapMask;
			
			//create the map and attach to the map level
			this.initGrid();
			
			//create the GUI
				//panel for mini-map and buttons
					//construction
					//World map
					//Town map
					//Main menu
				//notifications list
				//unit/structure info area
					//only visible when a unit/structure is selected
			
			//testing code
			this.testPieces();
			this.addGameMenuBtn();
			
		}
		private function initLevels():void  {
			//each level as the z-index should be from bottom to top
			this._map_lvl = new Sprite();			//0
			this._terrain_lvl = new Sprite();		//1
			this._structures_lvl = new Sprite();	//2
			this._units_lvl = new Sprite();			//3
			this._clip = new Sprite();				//4
			this._gui_lvl = new Sprite();			//5
			this._popup_lvl = new Sprite();			//6
			this._alert_lvl = new Sprite();			//7
			
			this._clip.addChild(this._map_lvl);
			this._clip.addChild(this._terrain_lvl);
			this._clip.addChild(this._structures_lvl);
			this._clip.addChild(this._units_lvl);
			this.addChild(this._clip);
			this.addChild(this._gui_lvl);
			this.addChild(this._popup_lvl);
			this.addChild(this._alert_lvl);
		}
		private function createMask(nW:Number, nH:Number):Sprite  {
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0xFF0000);
			square.graphics.drawRect(0, 0, nW, nH);
			return square;
		}
		private function initGrid():void  {
			var startX:int = 20;
			var startY:int = 20;
			var sMapName:String = "sample_map";
			
			this._hexGrid = new HexGrid(sMapName, startX, startY);
			[Inject] this._hexGrid.setGridData(MapManager.getGridXML(sMapName));
			this._map_lvl.addChild(this._hexGrid);
			
			[Inject] MapManager.registerGrid(this._hexGrid);
		}
		
		public function updatePosition(nX:Number, nY:Number):void  {
			this._clip.x += nX;
			this._clip.y += nY;
		}
		public function get clip():Sprite  {
			return this._clip;
		}
		/*
		
			Code Testing
		
		*/
		private function testPieces() : void  {
			var i:Number = 100;
			
			var test1:HexUnit = new HexUnit(i++, "test_piece_01", LibFactory.createMovieClip("Sample_single_unit_MC"));
			test1.setPosition(200, 340);
			this._units_lvl.addChild(test1);
			
			var test2:HexUnit = new HexUnit(i++, "test_piece_02", LibFactory.createMovieClip("Sample_single_unit_MC"));
			test2.setPosition(620, 540);
			this._units_lvl.addChild(test2);
			
			var test3:HexWaterUnit = new HexWaterUnit(i++, "test_piece_03", LibFactory.createMovieClip("Sample_single_water_unit_MC"));
			test3.setPosition(110, 120);
			this._units_lvl.addChild(test3);
			
			var test4:HexStructure = new HexStructure(i++, "test_piece_04", LibFactory.createMovieClip("Sample_single_structure_MC"));
			test4.setPosition(200, 540);
			this._structures_lvl.addChild(test4);
			
		}
		
		private function addGameMenuBtn():void  {
			[Inject] var control:GameMenuControl = new GameMenuControl("gameMenu", LibFactory.createMovieClip("GameMenuButton"));
			control.setReleaseEvent(GameControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(control, "game_menu");
			control.x = 10;
			control.y = 10;
			this._gui_lvl.addChild(control);
		}
		
		
		
	}
}