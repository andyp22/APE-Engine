/**
 * classes.project.views.components.IntroView
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
	import classes.project.core.GameController;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	
	public class IntroView extends BaseView  {
		
		private var _assetId:String;
		/**
		 * Constructor
		 */
		public function IntroView(sName:String, sAsset:String)  {
			super(sName, MovieClip(Server.getAsset(sAsset)));
			trace("Creating new IntroView() -- " + sName);
			this._assetId = sAsset;
			this.show();
		}
		override public function endContent() : void  {
			//trace("endContent()");
			this.playAnimation();
			
		}
		
		public function reportKeyUp(event:KeyboardEvent):void  {
			// trace("Key Pressed: " + String.fromCharCode(event.charCode) +         " (character code: " + event.charCode + ")");
			if(Number(event.charCode) == 32)  {
				//trace("Space button pressed!!");
				this.playAnimation();
				if(this._display.currentLabel == "loadingCredits")  {
					stage.removeEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
				}
			}
		}
		
		public function playAnimation() : void  {
			//trace("currentLabel: "+this._display.currentLabel);
			switch(this._display.currentLabel)  {
				case "openingCredits":
					this._display.gotoAndPlay("introAnimation");
					break;
				case "introAnimation":
					this._display.gotoAndPlay("titleAnimation");
					break;
				case "titleAnimation":
					this._display.gotoAndPlay("loadingCredits");
					break;
				case "loadingCredits":
					this.stopShow();
					//handle flow to next part of the game
					[Inject] GameController.onIntroComplete();
					break;
				default:
					this._display.gotoAndPlay("openingCredits");
					this._display.mcOpening.play();
					break;
			}
		}
		public function startShow() : void  {
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			this._display = MovieClip(Server.getAsset(this._assetId));
			this.addChild(this._display);
			this._display.gotoAndPlay("openingCredits");
			this._display.mcOpening.play();
			show();
		}
		private function stopShow() : void  {
			stage.removeEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			
		}
		
		private function addGameMenuBtn():void  {
			[Inject] var control:GameMenuControl = new GameMenuControl("gameMenu", LibFactory.createMovieClip("GameMenuButton"));
			control.setReleaseEvent(GameControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(control, "game_menu");
			control.x = 50;
			control.y = 50;
			this.addChild(control);
		}
		
		/*override public function show():void  {
			this._display = MovieClip(Server.getAsset(this._assetId));
			this.addChild(this._display);
			//this.addGameMenuBtn();
			super.show();
			
		}*/
		
		
	}
}