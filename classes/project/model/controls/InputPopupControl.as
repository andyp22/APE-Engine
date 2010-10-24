/**
 * classes.project.model.controls.InputPopupControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.controls {
	
	import classes.project.core.Server;
	import classes.project.model.GuiControl;
	import classes.project.events.InputPopupEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class InputPopupControl extends GuiControl {
		
		/**
		 *	Constructor
		 */
		public function InputPopupControl(sName:String, mc:MovieClip, bAutosize:Boolean = true)  {
			super(sName, mc, bAutosize);
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				trace("handleRelease -- "+ this + " : " + this.sName);
				this.mcBg.gotoAndPlay("_overNoOut");
				var sInput:String = MovieClip(this.parent).mcInput.text;
				[Inject] Server.dispatch(new InputPopupEvent(this._releaseEvent, sInput));
			}
		}
	}
}