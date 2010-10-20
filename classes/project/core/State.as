/*
 * classes.project.core.State
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.core  {
	
	import classes.project.core.ViewState;
	
	
	public class State  {
		private static var instance:State;
		private static var bInit:Boolean = true;
		
		public static var sCurrentViewState:String = ViewState.START_UP_STATE;
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():State  {
			if(instance == null)  {
				instance = new State();			}
			return instance;
		}
		public function State():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				trace("State initializing...");
				bInit = false;
				
			} else  {
				trace("State has already been initialized.");
			}
		}
		
		
	}
}