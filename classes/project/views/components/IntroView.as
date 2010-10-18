/**
 * classes.project.views.components.IntroView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.core.Server;
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	
	public class IntroView extends BaseView  {
		
		/**
		 * Constructor
		 */
		public function IntroView(sName:String, mc:MovieClip)  {
			super(sName, mc);
			trace("Creating new IntroView() -- " + sName);
			//trace("test for git");
			
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
					//handle flow to next part of the game
					
					this.removeView();
					break;
				default:
					this._display.gotoAndPlay("openingCredits");
					this._display.mcOpening.play();
					break;
			}
		}
		public function startShow() : void  {
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			this._display.gotoAndPlay("openingCredits");
			this._display.mcOpening.play();
			show();
		}
		private function removeView() : void  {
			stage.removeEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			
		}
		
		
	}
}