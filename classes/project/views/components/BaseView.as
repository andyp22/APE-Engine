/**
 * classes.project.views.components.BaseView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.core.Server;
	import classes.project.events.GameViewEvent;
	import classes.project.views.components.IView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class BaseView extends Sprite implements IView  {
		private var _id:String;
		protected var _display:MovieClip;
		protected var _bShowing:Boolean;
		
		/**
		 * Constructor
		 */
		public function BaseView(sName:String, mc:MovieClip)  {
			super();
			//trace("Creating new BaseView() -- " + sName);
			
			this._id = sName;
			this._display = mc;
			
			this.init();
			
		}
		private function init() : void  {
			//trace("BaseView initializing...");
			
			this.addChild(this._display);
			
		}
		public function show() : void  {
			trace("Showing -- " + this._id);
			this._bShowing = true;
			this.visible = true;
			[Inject] Server.dispatch(new GameViewEvent(GameViewEvent.GAME_VIEW_OPENED, this));
		}
		public function hide() : void  {
			trace("Hiding -- " + this._id);
			this._bShowing = false;
			this.visible = false;
			[Inject] Server.dispatch(new GameViewEvent(GameViewEvent.GAME_VIEW_CLOSED, this));
		}
		public function toggleView() : void  {
			if(this._bShowing)  {
				hide();
			} else  {
				show();
			}
		}
		public function isShowing() : Boolean  {
			return this._bShowing;
		}
		public function get id() : String  {
			return this._id;
		}
		public function endContent() : void  {	}
		
		
		
	}
}