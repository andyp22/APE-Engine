﻿/**
 * classes.project.views.components.RegionMapView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.MapManager;
	import classes.project.core.Server;
	import classes.project.core.StructureFactory;
	import classes.project.events.GameControlEvent;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.model.grid.HexGrid;
	import classes.project.model.grid.HexStructure;
	import classes.project.model.grid.HexUnit;
	import classes.project.model.grid.HexWaterUnit;
	import classes.project.model.grid.ITile;
	import classes.project.views.components.BaseView;
	import classes.project.views.components.parts.RegionMapConstructionPanel;
	import classes.project.views.components.parts.RegionMapGUIPanel;
	import classes.project.views.components.parts.RegionMapResourcesPanel;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	import flash.geom.Point;
	
	import be.dauntless.astar.Astar;
	import be.dauntless.astar.AstarEvent;
	import be.dauntless.astar.IMap;
	import be.dauntless.astar.PathRequest;
	import be.dauntless.astar.analyzers.WalkableAnalyzer;
	
	
	
	
	
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
		
		private var _updateX:Number = 0;
		private var _updateY:Number = 0;
		private var _buffer:Number = 50;
		
		[Inject] private var _hexGrid:HexGrid;
		private var _guiPanel:RegionMapGUIPanel;
		private var _constructionPanel:RegionMapConstructionPanel;
		private var _resourcesPanel:RegionMapResourcesPanel;
		
		private var _buildings:Array;
		
		
		private var astar : Astar;
		private var map : IMap;
		
		
		/**
		 * Constructor
		 */
		public function RegionMapView(sName:String, mc:MovieClip)  {
			super(sName, mc);
			trace("Creating new RegionMapView()...");
		}
		public function init(nW:Number, nH:Number):void  {
			
			stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
			
			this._buildings = new Array();
			
			//create the level holders
			this.initLevels();
			
			//create the mask and attach to the clip
			this._mapMask = this.createMask(nW, nH);
			this.addChild(this._mapMask);
			this._clip.mask = this._mapMask;
			
			//create the map and attach to the map level
			this.initGrid();
			
			//testing code
			this.testPieces();
			
			//create the GUI
			this.initGUI();
			this.initContructionPanel();
			this.initResourcesPanel();
			
			//notifications list
			
			//unit/structure info area
			
			
			
			this.aStarTest()
			
			
		}
		private function initLevels():void  {
			//each level as the z-index should be from bottom to top
			this._map_lvl = new Sprite();			//0
			this._terrain_lvl = new Sprite();		//1
			this._structures_lvl = new Sprite();	//2
			this._units_lvl = new Sprite();			//3
			this._clip = new Sprite();				//5
			this._gui_lvl = new Sprite();			//6
			this._popup_lvl = new Sprite();			//7
			this._alert_lvl = new Sprite();			//8
			
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
			var sMapName:String = "game_map";
			var sMapSize:String = "huge"; //tiny, small, standard, large, huge
			
			//this._hexGrid = new HexGrid(sMapName, startX, startY, sMapSize);
			this._hexGrid = new HexGrid(sMapName, startX, startY);
			[Inject] this._hexGrid.setGridData(MapManager.getGridXML(sMapName));
			this._map_lvl.addChild(this._hexGrid);
			
			[Inject] MapManager.registerGrid(this._hexGrid);
		}
		private function addScrollMask():void  {
			this.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			this.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		private function removeScrollMask():void  {
			this.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		private function mouseLeaveHandler(e:Event):void  {
			//if the mouse leaves the stage
			this.removeScrollMask();
			this.addEventListener(MouseEvent.ROLL_OVER, mouseReturnHandler);
		}
		private function mouseReturnHandler(e:Event):void  {
			//when the mouse returns to the stage
			this.removeEventListener(MouseEvent.ROLL_OVER, mouseReturnHandler);
			this.addScrollMask();
		}
		private function handleEnterFrame(e:Event):void  {
			var nX:Number = 0;
			var nY:Number = 0;
			
			var scrollSpeed:Number = 10;
			
			if(this._updateX <= this._buffer)  {
				nX = scrollSpeed;
			} else if(this._updateX >= (this._mapMask.width - this._buffer))  {
				//as long as we are not over the gui panel
				if(this._updateY <= (this._mapMask.height - this._guiPanel.height))  {
					nX = -scrollSpeed;
				}
			}
			
			if(this._updateY <= this._buffer)  {
				nY = scrollSpeed;
			} else if(this._updateY >= (this._mapMask.height - this._buffer))  {
				//as long as we are not over the gui panel
				if(this._updateX <= (this._mapMask.width - this._guiPanel.width))  {
					nY = -scrollSpeed;
				}
			}
			if(nX > 0 || nX < 0 || nY > 0 || nY < 0)  {
				this.updateMapPosition(nX, nY);
			}
		}
		private function handleMouseMove(e:MouseEvent):void  {
			this._updateX = e.stageX;
			this._updateY = e.stageY;
		}
		private function initGUI():void  {
			var bitmapData:BitmapData = new BitmapData(this._map_lvl.width, this._map_lvl.height, true, 0x00000000);
			bitmapData.draw(this._map_lvl);
			//panel for mini-map and buttons
			this._guiPanel = new RegionMapGUIPanel("region_map_gui_panel", LibFactory.createMovieClip("GuiControlPanelMC"));
			this._guiPanel.init(new Bitmap(bitmapData), this._mapMask.width, this._mapMask.height);
			
			var nX:Number = this._mapMask.width - this._guiPanel.width;
			var nY:Number = this._mapMask.height - this._guiPanel.height;
			
			this._guiPanel.setPos(nX, nY);
			this._guiPanel.show();
			this._gui_lvl.addChild(this._guiPanel);
		}
		private function initContructionPanel():void  {
			this._constructionPanel = new RegionMapConstructionPanel("region_map_construction_panel", LibFactory.createMovieClip("GuiControlPanelMC"));
			var nX:Number = this._mapMask.width - this._guiPanel.width - this._constructionPanel.getWidth();
			var nY:Number = this._mapMask.height - this._constructionPanel.height - this._buffer;
			this._constructionPanel.setPos(nX, nY);
			this._constructionPanel.hide();
			this._gui_lvl.addChild(this._constructionPanel);
		}
		private function initResourcesPanel():void  {
			 this._resourcesPanel = new RegionMapResourcesPanel("region_map_resources_panel", LibFactory.createMovieClip("GuiControlPanelMC"), this._mapMask.width);
			 this._resourcesPanel.setPos(0, 0);
			 this._gui_lvl.addChild(this._resourcesPanel);
		}
		/*
			used to change the map position incrementally
		
		*/
		public function updateMapPosition(nX:Number, nY:Number):void  {
			var newX:Number = this._clip.x + nX;
			var newY:Number = this._clip.y + nY;
			this.updateMap(newX, newY);
		}
		public function updateMap(nX:Number, nY:Number):void  {
			var newX:Number = nX;
			var newY:Number = nY;
			//do some bounds checking
			if(newX > 0)  {
				newX = 0;
			} else if(newX < ((this._clip.width - this._mapMask.width) * -1))  {
				newX = ((this._clip.width - this._mapMask.width) * -1);
			}
			if(newY > 0)  {
				newY = 0;
			} else if(newY < ((this._clip.height - this._mapMask.height) * -1))  {
				newY = ((this._clip.height - this._mapMask.height) * -1);
			}
			
			this._clip.x = newX;
			this._clip.y = newY;
			this._guiPanel.updateMiniMapView(newX, newY);
		}
		public function get clip():Sprite  {
			return this._clip;
		}
		public function get grid():HexGrid  {
			return this._hexGrid;
		}
		override public function show() : void  {
			super.show();
			this._updateX = 0;
			this._updateY = 0;
			this.addScrollMask();
		}
		override public function hide() : void  {
			super.hide();
			if(this._constructionPanel != null && this.constructionPanelVisible())  {
				this.hideConstructionPanel();
			}
			this.removeScrollMask();
		}
		public function showConstructionPanel():void  {
			this._constructionPanel.show();
		}
		public function hideConstructionPanel():void  {
			this._constructionPanel.hide();
		}
		public function constructionPanelVisible():Boolean  {
			return this._constructionPanel.visible;
		}
		public function constructBuilding(building:HexStructure, tile:ITile):void  {
			//trace("constructBuilding: "+tile.xPos() +"  "+tile.yPos() + " " +building.getName() + "_" + building.getID());
			building.setPosition(tile.xPos(), tile.yPos());
			this._structures_lvl.addChild(building);
			this._buildings[building.getName() + "_" + building.getID()] = building;
		}
		public function destroyBuilding(sID:String):void  {
			//trace("destroyBuilding: "+sID);
			//get the tile at the click location
			var building:HexStructure = this._buildings[sID];
			var currTile:ITile = this._hexGrid.getTileByLocation(building.x, building.y);
			currTile.removeBuilding();
			building.destroy();
			this._structures_lvl.removeChild(building);
			this._buildings[sID] = null;
		}
		public function updateResourcePanel():void  {
			this._resourcesPanel.update();
		}
		public function resetFocus():void  {
			stage.stageFocusRect = false;
			stage.focus = this;
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
			test3.setPosition(2030, 1200);
			this._units_lvl.addChild(test3);
			
			
		}
		
		private function aStarTest() : void  {
			
			astar = new Astar();
			astar.addAnalyzer(new WalkableAnalyzer());
			
			astar.addEventListener(AstarEvent.PATH_FOUND, onPathFound);
			astar.addEventListener(AstarEvent.PATH_NOT_FOUND, onPathNotFound);
			
			//astar.getPath(new PathRequest(new Point(6, 10), new Point(6, 12), this._hexGrid.getMap()));
			
			
		}
		
		private function onPathNotFound(event : AstarEvent) : void  {
			trace("path not found");
		}
 
		private function onPathFound(event : AstarEvent) : void  {
			trace("Path was found: " + event.getPath().toString());
		}
		

		
	}
}