/**
 * classes.project.core.GameController
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class GameController  {
		private static var instance:GameController;
		private static var bInit:Boolean = true;
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():GameController  {
			if(instance == null)  {
				instance = new GameController();			}
			return instance;
		}
		public function GameController():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				trace("GameController initializing...");
				
				
				bInit = false;
				
			} else  {
				trace("GameController have already been initialized.");
			}
		}
		/*
		 *  event dispatcher
		 *
		 *
		 */
		public static function setEventDispatcher(value:IEventDispatcher):void
		{
			_eventDispatcher = value;
		}
		public static function get eventMap():IEventMap
		{
			return _eventMap || (_eventMap = new EventMap(_eventDispatcher));
		}
		/*
		 * Dispatch helper method
		 *
		 * @param event The <code>Event</code> to dispatch on the <code>IContext</code>'s <code>IEventDispatcher</code>
		 */
		public static function dispatch(event:Event):Boolean
		{
 		    if(_eventDispatcher.hasEventListener(event.type))
 		        return _eventDispatcher.dispatchEvent(event);
 		 	return false;
		}
		
		
	}
}