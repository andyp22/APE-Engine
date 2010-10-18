/**
 * classes.project.events.GameViewEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import classes.project.views.components.IView;
	
	import flash.events.Event;
	
	public class GameViewEvent extends Event  {
		
		public var view:IView;
		
		public static const GAME_VIEW_OPENED:String = "GAME_VIEW_OPENED";
		public static const GAME_VIEW_CLOSED:String = "GAME_VIEW_CLOSED";
		
		
		public function GameViewEvent(sType:String, gameView:IView = null)  {
			super(sType);
			this.view = gameView;
		}
		
		override public function clone():Event  {
			return new GameViewEvent(type, this.view);
		}
	}
}