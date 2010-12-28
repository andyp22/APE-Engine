/**
 * classes.project.model.controls.ConstructionPanelControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.controls {
	
	import classes.project.core.Server;
	import classes.project.model.GuiControl;
	import classes.project.events.GuiControlEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ConstructionPanelControl extends GuiControl {
		
		
		/**
		 *	Constructor
		 */
		public function ConstructionPanelControl(sName:String, mc:MovieClip, bAutosize:Boolean = false)  {
			super(sName, mc, bAutosize);
			
			this._releaseEvent = GuiControlEvent.GUICONTROL_PRESSED;
			
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				trace("handleRelease -- "+ this + " : " + this.sName);
				[Inject] Server.dispatch(new GuiControlEvent(this._releaseEvent));
			}
			this.mcBg.gotoAndPlay("_overNoOut");
		}
		override public function setText(sText:String):void  {	}
		override public function getTooltipText():String  {
			return "Building Name";
		}
		/**
		 *	Methods
		 */
		 
	}
}