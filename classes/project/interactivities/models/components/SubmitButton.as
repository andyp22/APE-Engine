/**
 * classes.project.interactivities.models.components.SubmitButton
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.components {
	
	import classes.project.core.Server;
	
	import classes.project.model.GuiControl;
	import classes.project.interactivities.events.InteractivityEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class SubmitButton extends GuiControl {
		
		/**
		 *	Constructor
		 */
		public function SubmitButton(sName:String, mc:MovieClip, bAutosize:Boolean = true)  {
			super(sName, mc, bAutosize);
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				trace("handleRelease -- "+ this + " : " + this.sName);
				this.mcBg.gotoAndPlay("_overNoOut");
				[Inject] Server.dispatch(new InteractivityEvent(this._releaseEvent));
			}
		}
	}
}