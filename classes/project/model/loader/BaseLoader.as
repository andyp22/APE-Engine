/**
 * classes.project.model.loader.BaseLoader
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.loader  {
	
	//import classes.project.events.LoaderEvent;
	import classes.project.model.loader.ILoader;
	import classes.project.model.loader.LoadData;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class BaseLoader implements ILoader  {
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		public function BaseLoader()  {
			//trace("Creating BaseLoader...");
			
		}
		
		/*
		 *  event dispatcher
		 *
		 *
		 */
		public function setEventDispatcher(value:IEventDispatcher):void
		{
			_eventDispatcher = value;
		}
		public function get eventMap():IEventMap
		{
			return _eventMap || (_eventMap = new EventMap(_eventDispatcher));
		}
		/*
		 * Dispatch helper method
		 *
		 * @param event The <code>Event</code> to dispatch on the <code>IContext</code>'s <code>IEventDispatcher</code>
		 */
		public function dispatch(event:Event):Boolean
		{
 		    if(_eventDispatcher.hasEventListener(event.type))
 		        return _eventDispatcher.dispatchEvent(event);
 		 	return false;
		}
		
		public function load(lData:LoadData):void { }
		public function kill():void { }
		public function getLoadData():LoadData  { return null; }
		
	}
}