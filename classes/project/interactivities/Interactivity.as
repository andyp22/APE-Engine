/**
 * classes.project.interactivities.Interactivity
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.interactivities  {
	
	import classes.project.core.LibFactory;
	import classes.project.interactivities.events.InteractivityEvent;
	import classes.project.interactivities.views.displays.BaseSortingView;
	
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class Interactivity extends Sprite  {
		private static var instance:Interactivity;
		private static var bInit:Boolean = true;
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		private static var _activityType:String;
		private static var _activity;
		
		
		[Inject] public static var contextView:DisplayObjectContainer;
		public static var interactivityView:Sprite;
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Interactivity  {
			if(instance == null)  {
				instance = new Interactivity();
				//init();
			}
			return instance;
		}
		public function Interactivity():void  {
			super();
		}
		public static function init():void  {
			trace("Interactivity initializing...");
			
			interactivityView = Sprite(contextView.getChildByName("interactivity"));
			
			eventMap.mapListener(_eventDispatcher, InteractivityEvent.ACTIVITY_COMPLETED, onActivityCompleted);
			
		}
		public static function onActivityCompleted(e:InteractivityEvent):void  {
			trace("onActivityCompleted()");
			
			//destroyActivity();
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
		/*
		 *
		 *
		 *
		 */
		public static function createActivity(sActivityType:String):void  {
			_activityType = sActivityType;
			switch(_activityType)  {
				case "SORTING":
					[Inject] _activity = new BaseSortingView(LibFactory.createMovieClip("SortingActivity_MC"));
					_activity.x = 10;
					_activity.y = 10;
					interactivityView.addChild(_activity);
					
					break;
			}
			
		}
		
		public static function destroyActivity():void  {
			trace("destroyActivity() -- "+interactivityView);
			if(interactivityView.contains(_activity))  {
				interactivityView.removeChild(_activity);
			}
			_activity = null;
			dispatch(new InteractivityEvent(InteractivityEvent.ACTIVITY_DESTROYED));
		}
		
		
		
	}
}