/**
 * classes.project.model.controls.TabControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.controls {
	
	import classes.project.core.Server;
	import classes.project.model.GuiControl;
	import classes.project.events.TabControlEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TabControl extends GuiControl {
		
		private var _selected:Boolean = false;
		private var mcSelected:MovieClip;
		
		/**
		 *	Constructor
		 */
		public function TabControl(sName:String, mc:MovieClip, bAutosize:Boolean = false)  {
			super(sName, mc, bAutosize);
			
			this._releaseEvent = TabControlEvent.TAB_CONTROL_PRESSED;
			this.disableTooltip();
			this.mcSelected = this.mcButton.mcBg.mcSelected;
			this.deselect();
		}
		/**
		 *	Overrides
		 */
		override protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled && !this._selected)  {
				trace("handleRelease -- "+ this + " : " + this.sName);
				[Inject] Server.dispatch(new TabControlEvent(this._releaseEvent, this));
			}
			this.mcBg.gotoAndPlay("_overNoOut");
		}
		/**
		 *	Methods
		 */
		public function select():void  {
			this.mcSelected.visible = true;
			this._selected = true;
		}
		public function deselect():void  {
			this.mcSelected.visible = false;
			this._selected = false;
		}
	}
}