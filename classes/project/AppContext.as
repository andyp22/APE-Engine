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
	import classes.project.model.structure.*;
	import classes.project.views.*;
	import classes.project.views.components.*;
	
	import classes.project.interactivities.Interactivity;
	import classes.project.interactivities.models.components.*;
	import classes.project.interactivities.models.evaluation.*;
	import classes.project.interactivities.views.displays.*;
	import classes.project.interactivities.views.mediators.*;
	
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
			commandMap.mapEvent(GuiControlEvent.SAVE_CONTROL_PRESSED, SaveCommand, GuiControlEvent);
			
			commandMap.mapEvent(GuiControlEvent.CLIP_NEXT_BTN_PRESSED, GuiControlNextCommand, GuiControlEvent);
			commandMap.mapEvent(GuiControlEvent.CLIP_BACK_BTN_PRESSED, GuiControlBackCommand, GuiControlEvent);
			
			
			//game
			commandMap.mapEvent(GameControlEvent.GAMEMENU_CONTROL_PRESSED, GameControlErrorCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.NEW_GAME_BTN_PRESSED, NewGameCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.LOAD_GAME_BTN_PRESSED, LoadGameCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.SAVE_GAME_BTN_PRESSED, SaveGameCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.PROFILES_BTN_PRESSED, ProfileViewCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.OPTIONS_BTN_PRESSED, OptionsViewCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.CREDITS_BTN_PRESSED, CreditsViewCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.REPORT_BUG_BTN_PRESSED, ReportBugCommand, GameControlEvent);
			commandMap.mapEvent(GameControlEvent.EXIT_BTN_PRESSED, ExitGameCommand, GameControlEvent);
			
		}
		private function mapInjectors():void  {
			
			// map some Singletons for use globally
			injector.mapSingleton(Configs);
			injector.mapSingleton(GameController);
			injector.mapSingleton(Interactivity);
			injector.mapSingleton(Labels);
			injector.mapSingleton(LibFactory);
			injector.mapSingleton(MapManager);
			injector.mapSingleton(Navigator);
			injector.mapSingleton(PanelManager);
			injector.mapSingleton(Preloader);
			injector.mapSingleton(Server);
			injector.mapSingleton(State);
			injector.mapSingleton(Structure);
			injector.mapSingleton(Tooltips);
			injector.mapSingleton(ViewManager);
			
			// map some classes to their respective interface
			injector.mapClass(IBay, BaseDraggerBay);
			injector.mapClass(IDragger, BaseDragger);
			injector.mapClass(IEvaluation, BaseEvaluation);
			injector.mapClass(ILoader, BaseLoader);
			injector.mapClass(IPanel, ContainerPanel);
			injector.mapClass(IPopup, BasePopup);
			injector.mapClass(IProfile, BaseProfile);
			injector.mapClass(ITile, HexTile);
			
			// map some classes for use with our mediators, etc
			injector.mapClass(GuiControl, GuiControl);
			injector.mapClass(GameMenuControl, GameMenuControl);
			injector.mapClass(HexGrid, HexGrid);
			injector.mapClass(HexTile, HexTile);
			injector.mapClass(Player, Player);
			
			injector.mapClass(Chapter, Chapter);
			injector.mapClass(Section, Section);
			injector.mapClass(Clip, Clip);
			injector.mapClass(Segment, Segment);
			
		}
		private function mapMediators():void  {
			/*
			 *	Full Views
			 */
			mediatorMap.mapView(BaseView, BaseMediator);
			mediatorMap.mapView(ExampleView, ExampleMediator);
			mediatorMap.mapView(GameMenuView, GameMenuMediator);
			mediatorMap.mapView(IntroView, IntroMediator);
			/*
			 *	Panels
			 */
			mediatorMap.mapView(CalculatorView, CalculatorMediator);
			mediatorMap.mapView(ClipView, ClipMediator);
			mediatorMap.mapView(HexMapView, HexMapMediator);
			mediatorMap.mapView(MainMenuView, MainMenuMediator);
			mediatorMap.mapView(SlidingPanelView, SlidingPanelMediator);
			mediatorMap.mapView(TimerPanelView, TimerPanelMediator);
			/*
			 *	Interactivities
			 */
			mediatorMap.mapView(BaseSortingView, BaseSortingMediator);
			
			
		}
		private function initView():void  {
			var views:Sprite = new Sprite();
			views.name = "gameViews";
			
			var interactivity:Sprite = new Sprite();
			interactivity.name = "interactivity";
			
			var panels:Sprite = new Sprite();
			panels.name = "panels";
			
			var tooltips:Sprite = new Sprite();
			tooltips.name = "tooltips";
			
			contextView.addChild(views);
			contextView.addChild(interactivity);
			contextView.addChild(panels);
			contextView.addChild(tooltips);
		}
		
		
		
	}
}