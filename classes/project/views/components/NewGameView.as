/**
 * classes.project.views.components.NewGameView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.GameControlEvent;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	
	public class NewGameView extends BaseView  {
		
		private var _assetId:String;
		/**
		 * Constructor
		 */
		public function NewGameView(sName:String, sAsset:String)  {
			super(sName, MovieClip(Server.getAsset(sAsset)));
			trace("Creating new NewGameView() -- " + sName);
			
			this._assetId = sAsset;
			this.show();
			
		}
		
		private function addGameMenuBtn():void  {
			[Inject] var control:GameMenuControl = new GameMenuControl("gameMenu", LibFactory.createMovieClip("GameMenuButton"));
			control.setReleaseEvent(GameControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(control, "game_menu");
			control.x = 50;
			control.y = 50;
			this.addChild(control);
		}
		
		override public function show():void  {
			this._display = MovieClip(Server.getAsset(this._assetId));
			this.addChild(this._display);
			this._display.gotoAndPlay("newGame");
			this.addGameMenuBtn();
			super.show();
			
		}
		
	}
}