/**
 * classes.project.model.structures.MainTownStructure
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.structures {
	
	import classes.project.core.Server;
	import classes.project.events.ConstructionPanelEvent;
	import classes.project.model.grid.HexStructure;
	
	import flash.display.MovieClip;
	
	public class MainTownStructure extends HexStructure {
		
		/**
		 * Constructor
		 */
		public function MainTownStructure(id:Number, sName:String, sMCid:String)  {
			trace("Creating a new MainTownStructure...");
			super(id, sName, sMCid);
			
			this.init();
		}
		
		private function init():void  {
			[Inject] Server.dispatch(new ConstructionPanelEvent(ConstructionPanelEvent.MAIN_TOWN_CONSTRUCTED, this));
			
		}
		
		override public function destroy():void  {
			[Inject] Server.dispatch(new ConstructionPanelEvent(ConstructionPanelEvent.MAIN_TOWN_DESTROYED, this));
			
			super.destroy();
		}
		
	}
}