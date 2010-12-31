/**
 * classes.project.model.controls.ConstructionPanelControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.controls {
	
	import classes.project.core.Labels;
	import classes.project.core.Server;
	import classes.project.model.GuiControl;
	import classes.project.model.grid.HexStructure;
	import classes.project.events.ConstructionPanelEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ConstructionPanelControl extends GuiControl {
		
		private var _building:HexStructure;
		private var mcIcon:MovieClip;
		
		
		/**
		 *	Constructor
		 */
		public function ConstructionPanelControl(sName:String, mc:MovieClip, bAutosize:Boolean = false, building:HexStructure = null)  {
			super(sName, mc, bAutosize);
			this._building = building;
			this.mcIcon = mc.mcIcon;
			this._releaseEvent = ConstructionPanelEvent.SELECT_BUILDING_FOR_CONSTRUCTION;
			this.updateIcon();
			
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				//trace("handleRelease -- "+ this + " : " + this.sName);
				[Inject] Server.dispatch(new ConstructionPanelEvent(this._releaseEvent, this._building));
			}
			this.mcBg.gotoAndPlay("_overNoOut");
		}
		override public function setText(sText:String):void  {
			this.sText = sText;
		}
		override public function getTooltipText():String  {
			return Labels.getLabel("construct_txt") + this.sText;
		}
		private function updateIcon():void  {
			this.mcIcon.gotoAndStop(this.sName + "_icon");
		}
		/**
		 *	Methods
		 */
		
	}
}