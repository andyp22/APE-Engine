/**
 * classes.project.core.ViewManager
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.LibFactory;
	import classes.project.core.ViewFactory;
	import classes.project.events.GameViewEvent;
	import classes.project.views.components.IView;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class ViewManager  {
		private static var instance:ViewManager;
		private static var bInit:Boolean = true;
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		private static var _currentView:IView = null;
		private static var _views:Array;
		
		
		[Inject] public static var contextView:DisplayObjectContainer;
		
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():ViewManager  {
			if(instance == null)  {
				instance = new ViewManager();			}
			return instance;
		}
		public function ViewManager():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				trace("ViewManager initializing...");
				
				[Inject] ViewFactory.getInstance();
				
				_views = new Array();
				
				
				eventMap.mapListener(_eventDispatcher, GameViewEvent.GAME_VIEW_OPENED, onViewOpened);
				eventMap.mapListener(_eventDispatcher, GameViewEvent.GAME_VIEW_CLOSED, onViewClosed);
				
				bInit = false;
			} else  {
				trace("ViewManager has already been initialized.");
			}
			
		}
		/*
		 *  event dispatcher
		 *
		 *
		 */
		public static function setEventDispatcher(value:IEventDispatcher) : void
		{
			_eventDispatcher = value;
		}
		public static function get eventMap() : IEventMap
		{
			return _eventMap || (_eventMap = new EventMap(_eventDispatcher));
		}
		/*
		 *  Event Handler Methods
		 *
		 *
		 */
		public static function onFileLoaded(sName:String, mcDisplay:MovieClip) : void  {
			//trace("ViewManager onFileLoaded(" + sName +")");
			
			
			
		}
		public static function onViewOpened(e:GameViewEvent) : void  {
			trace("onViewOpened() -- "+ e.view.id);
			_currentView = e.view;
			
			for(var i:int = 0; i < _views.length; i++)  {
				if((_currentView.id != _views[i].id) && _views[i].isShowing())  {
					_views[i].hide();
				}
			}
			
		}
		public static function onViewClosed(e:GameViewEvent) : void  {
			trace("onViewClosed() -- "+ e.view.id);
			
		}
		public static function onEndContent() : void  {
			//trace("onEndContent()");
			_currentView.endContent();
		}
		/*
		 *  
		 *
		 *
		 */
		public static function addView(sView:String):void  {
			[Inject] var viewHolder:Sprite = Sprite(contextView.getChildByName("gameViews"));
			[Inject] var view:IView = ViewFactory.makeView(sView);
			view.hide();
			viewHolder.addChild(Sprite(view));
			registerView(view);
			
		}
		public static function registerView(view:IView):void  {
			trace("Registering view -- " + view.id);
			_views.push(view);
		}
		
		public static function hasView(sID:String):Boolean  {
			for(var i = 0; i < _views.length; i++)  {
				if(_views[i].id == sID)  {
					return true;
				}
			}
			return false;
		}
		public static function getView(sID:String):IView  {
			for(var i = 0; i < _views.length; i++)  {
				if(_views[i].id == sID)  {
					return _views[i];
				}
			}
			return null;
		}
		public static function showView(sID:String):void  {
			for(var i = 0; i < _views.length; i++)  {
				if(_views[i].id == sID)  {
					_currentView = _views[i];
				}
			}
			_currentView.show();
		}
		
		
		
	}
}