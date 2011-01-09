/**
 * classes.project.model.controls.ConstructionPanelUndoControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.controls {
	
	import classes.project.core.Labels;
	import classes.project.core.Server;
	import classes.project.model.controls.ConstructionPanelControl;
	import classes.project.events.ConstructionPanelEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ConstructionPanelUndoControl extends ConstructionPanelControl {
		
		
		/**
		 *	Constructor
		 */
		public function ConstructionPanelUndoControl(sName:String, mc:MovieClip, bAutosize:Boolean = false)  {
			super(sName, mc, bAutosize);
			this._releaseEvent = ConstructionPanelEvent.UNDO_LAST_BUILDING_CONSTRUCTION;
			
			this.setText("undo");
			
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				//trace("handleRelease -- "+ this + " : " + this.sName);
				[Inject] Server.dispatch(new ConstructionPanelEvent(this._releaseEvent, null));
			}
			this.mcBg.gotoAndPlay("_disabled");
			disable();
		}
		override public function setText(sText:String):void  {
			this.sText = sText;
		}
		override public function getTooltipText():String  {
			return Labels.getLabel(this.sText);
		}
		/**
		 *	Methods
		 */
		
	}
}