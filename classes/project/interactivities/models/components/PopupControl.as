/**
 * classes.project.interactivities.models.components.PopupControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.components {
	
	import classes.project.core.Server;
	
	import classes.project.model.GuiControl;
	import classes.project.interactivities.events.PopupEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class PopupControl extends GuiControl {
		
		/**
		 *	Constructor
		 */
		public function PopupControl(sName:String, mc:MovieClip, bAutosize:Boolean = true)  {
			super(sName, mc, bAutosize);
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				trace("handleRelease -- "+ this + " : " + this.sName);
				this.mcBg.gotoAndPlay("_overNoOut");
				[Inject] Server.dispatch(new PopupEvent(this._releaseEvent));
			}
		}
	}
}