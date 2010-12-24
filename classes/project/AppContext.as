/**
 * classes.project.commands.AppContext
 * @version 1.0.0
 * @author andrew page
 */

package classes.project  {
	
	import classes.project.commands.*;
	import classes.project.core.*;
	import classes.project.events.*;
	import classes.project.model.*;
	import classes.project.model.controls.*;
	import classes.project.model.grid.*;
	import classes.project.model.loader.*;
	import classes.project.model.popups.*;
	import classes.project.views.*;
	import classes.project.views.components.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import org.robotlegs.adapters.*;
	import org.robotlegs.base.*;
	import org.robotlegs.core.*;
	import org.robotlegs.mvcs.*;
	
	
	public class AppContext extends Context  {
		
		
		public function AppContext(contextView:DisplayObjectContainer)  {
			trace("Creating the context...");
			super(contextView);
		}
		
		override public function startup():void  {
			trace("AppContext startup()");
			// map some commands to events
			this.mapCommands();
			// some classes to use with our views
			this.mapInjectors();
			// bind mediator classes to view classes
			this.mapMediators();
			
			//create some holders for various levels of display objects
			this.initView();
			
			// dispatch the STARTUP event to get everything going
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
		private function mapCommands():void  {
			// these events will only be used once
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitCommand, ContextEvent, true);
			
			// these events will be used multiple times
			commandMap.mapEvent(GuiControlEvent.GUICONTROL_PRESSED, GuiControlErrorCommand, GuiControlEvent);
			
			
			//game controls
			commandMap.mapEvent(GameControlEvent.GAMEMENU_CONTROL_PRESSED, GameControlErrorCommand, GameControlEvent);
			
			
			commandMap.mapEvent(GameControlEvent.CREDITS_BTN_PRESSED, CreditsViewCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.EXIT_BTN_PRESSED, ExitGameCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.GAME_MENU_BTN_PRESSED, GameMenuCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.LOAD_GAME_BTN_PRESSED, LoadGameCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.NEW_GAME_BTN_PRESSED, NewGameCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.OPTIONS_BTN_PRESSED, OptionsViewCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.PROFILES_BTN_PRESSED, ProfileViewCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.REPORT_BUG_BTN_PRESSED, ReportBugCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.SAVE_GAME_BTN_PRESSED, SaveGameCommand, GameControlEvent);
			
			
			
			
		}
		private function mapInjectors():void  {
			
			// map some Singletons for use globally
			injector.mapSingleton(Configs);
			injector.mapSingleton(GameController);
			injector.mapSingleton(Labels);
			injector.mapSingleton(LibFactory);
			injector.mapSingleton(MapManager);
			injector.mapSingleton(OverlayFactory);
			injector.mapSingleton(PanelManager);
			injector.mapSingleton(Preloader);
			injector.mapSingleton(Server);
			injector.mapSingleton(State);
			injector.mapSingleton(Tooltips);
			injector.mapSingleton(UserData);
			injector.mapSingleton(ViewManager);
			injector.mapSingleton(ViewFactory);
			
			// map some classes to their respective interface
			injector.mapClass(ILoader, BaseLoader);
			injector.mapClass(IPanel, ContainerPanel);
			injector.mapClass(IPopup, BasePopup);
			injector.mapClass(IProfile, BaseProfile);
			injector.mapClass(IOverlay, BaseOverlay);
			injector.mapClass(ITile, HexTile);
			injector.mapClass(IView, BaseView);
			
			// map some classes for use with our mediators, etc
			injector.mapClass(GuiControl, GuiControl);
			injector.mapClass(GameMenuControl, GameMenuControl);
			injector.mapClass(HexGrid, HexGrid);
			injector.mapClass(HexTile, HexTile);
			injector.mapClass(Player, Player);
			
			
			
		}
		private function mapMediators():void  {
			/*
			 *	Full Views
			 */
			mediatorMap.mapView(ExitGameView, ExitGameMediator);
			mediatorMap.mapView(GameCreditsView, GameCreditsMediator);
			mediatorMap.mapView(GameMenuView, GameMenuMediator);
			mediatorMap.mapView(IntroView, IntroMediator);
			mediatorMap.mapView(LoadGameView, LoadGameMediator);
			mediatorMap.mapView(NewGameView, NewGameMediator);
			mediatorMap.mapView(OptionsMenuView, OptionsMenuMediator);
			mediatorMap.mapView(ProfileMenuView, ProfileMenuMediator);
			mediatorMap.mapView(RegionMapView, RegionMapMediator);
			mediatorMap.mapView(ReportBugView, ReportBugMediator);
			mediatorMap.mapView(SaveGameView, SaveGameMediator);
			
			/*
			 *	Panels
			 */
			
			
			
			
		}
		private function initView():void  {
			var views:Sprite = new Sprite();
			views.name = "gameViews";
			
			var alerts:Sprite = new Sprite();
			alerts.name = "alerts";
			
			var panels:Sprite = new Sprite();
			panels.name = "panels";
			
			var tooltips:Sprite = new Sprite();
			tooltips.name = "tooltips";
			
			contextView.addChild(views);
			contextView.addChild(panels);
			contextView.addChild(alerts);
			contextView.addChild(tooltips);
		}
		
		
		
	}
}