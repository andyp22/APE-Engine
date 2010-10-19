/**
 * classes.project.model.controls.GameMenuControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.controls {
	
	import classes.project.core.Server;
	
	import classes.project.model.GuiControl;
	import classes.project.events.GameControlEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class GameMenuControl extends GuiControl {
		
		/**
		 *	Constructor
		 */
		public function GameMenuControl(sName:String, mc:MovieClip, bAutosize:Boolean = false)  {
			super(sName, mc, bAutosize);
			
			this._releaseEvent = GameControlEvent.GAMEMENU_CONTROL_PRESSED;
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				trace("handleRelease -- "+ this + " : " + this.sName);
				this.mcBg.gotoAndPlay("_overNoOut");
				[Inject] Server.dispatch(new GameControlEvent(this._releaseEvent));
			}
		}
	}
}