/**
 * classes.project.views.components.parts.RegionMapGUIPanel
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components.parts  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.GuiControlEvent;
	import classes.project.events.GameControlEvent;
	import classes.project.events.PanelEvent;
	import classes.project.model.ContainerPanel;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.views.components.parts.MiniMap;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class RegionMapGUIPanel extends ContainerPanel  {
		
		private var _miniMap:MiniMap;
		
		public function RegionMapGUIPanel(sName:String, mc:MovieClip)  {
			trace("Creating new RegionMapGUIPanel -- " + this + " : " + sName);
			super(sName, mc);
		}
		
		public function init(bMap:Bitmap, nW:Number, nH:Number):void  {
			trace("RegionMapGUIPanel initializing...");
			addChild(this.mcContent);
			
			this._miniMap = new MiniMap(bMap, 200, 150);
			this._miniMap.createViewWindow(nW, nH);
			this._miniMap.addEventListener(MouseEvent.CLICK, handleMiniMapClick);
			
			this.createContentContainer(new MovieClip());
			this.sizeToContents();
			this.hideCloseBtn();
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = nPadding;
			
			this.mcHeader.width = this.mcHeader.height = 0;
			this.mcHeader.visible = false;
			
			var nX:Number = 0;
			var nY:Number = 0;
			
			//add some buttons			
			[Inject] var constructionMenuBtn:GuiControl = new GuiControl("constructionMenu", LibFactory.createMovieClip("GameMenuButton"));
			constructionMenuBtn.setReleaseEvent(GuiControlEvent.CONSTRUCTION_BTN_PRESSED);
			[Inject] Server.addControl(constructionMenuBtn, "construction_menu");
			constructionMenuBtn.x = nX;
			constructionMenuBtn.y = nY;
			this.mcContent.addChild(constructionMenuBtn);
			
			nY += constructionMenuBtn.height + nPadding;
			
			[Inject] var worldMapBtn:GuiControl = new GuiControl("worldMapBtn", LibFactory.createMovieClip("GameMenuButton"));
			//worldMapBtn.setReleaseEvent(GuiControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(worldMapBtn, "world_map_btn");
			worldMapBtn.x = nX;
			worldMapBtn.y = nY;
			this.mcContent.addChild(worldMapBtn);
			
			nY += worldMapBtn.height + nPadding;
			
			[Inject] var townMapBtn:GuiControl = new GuiControl("townMapBtn", LibFactory.createMovieClip("GameMenuButton"));
			//townMapBtn.setReleaseEvent(GuiControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(townMapBtn, "town_map_btn");
			townMapBtn.x = nX;
			townMapBtn.y = nY;
			this.mcContent.addChild(townMapBtn);
			
			nY += townMapBtn.height + nPadding;
			
			[Inject] var mainMenuBtn:GameMenuControl = new GameMenuControl("gameMenu", LibFactory.createMovieClip("GameMenuButton"));
			mainMenuBtn.setReleaseEvent(GameControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(mainMenuBtn, "game_menu");
			mainMenuBtn.x = nX;
			mainMenuBtn.y = nY;
			this.mcContent.addChild(mainMenuBtn);
			
			//add the minimap
			nX += constructionMenuBtn.width + nPadding;
			nY = 0;
			
			this._miniMap.x = nX;
			this._miniMap.y = nY;
			this.mcContent.addChild(this._miniMap);
			
			addChild(this.mcContent);
		}
		override public function sizeToContents():void  {
			var nPadding:int = this.mcContent.x;
			var newWidth:int = this.mcContent.width + nPadding*2;
			var newHeight:int = this.mcContent.height + nPadding*2;
			
			this.mcPanel.mcBg.width = newWidth;
			this.mcPanel.mcBg.height = newHeight;
		}
		public function updateMiniMapView(nX:Number, nY:Number):void  {
			this._miniMap.updateViewWindowPosition(nX, nY);
		}
		private function handleMiniMapClick(e:MouseEvent):void  {
			var clickX:Number = e.localX;
			var clickY:Number = e.localY;
			
			this._miniMap.handleClick(clickX, clickY);
			[Inject] Server.dispatch(new PanelEvent(PanelEvent.MINI_MAP_UPDATED, this));
		}
		public function get mapCoords():Array  {
			return this._miniMap.coords;
		}
		
	}
}