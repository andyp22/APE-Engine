/**
 * classes.project.model.BaseOverlay
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model  {
	
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.model.IOverlay;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class BaseOverlay extends Sprite implements IOverlay  {
		private var _sName:String;
		protected var _overlay:MovieClip;
		
		
		/**
		 * Constructor
		 */
		public function BaseOverlay(sName:String, mc:MovieClip)  {
			super();
			trace("Creating new BaseOverlay -- " + this + " : " + sName);
			this._sName = sName;
			this._overlay = mc;
			
			this.init();
		}
		
		private function init():void  {
			//trace("BaseOverlay initializing...");
			addChild(this._overlay);
			
			
			
			
		}
		
		public function getName():String  {
			return this._sName;
		}
		public function show():void  {
			this.visible = true;
		}
		public function hide():void  {
			this.visible = false;
		}
		public function disable():void  {
			this._overlay.enabled = false;
		}
		public function enable():void  {
			this._overlay.enabled = true;
		}
		public function isEnabled():Boolean  {
			return this._overlay.enabled;
		}
		public function isShowing():Boolean  {
			return this.visible;
		}
		public function setPos(nX:Number, nY:Number):void  {
			this.x = nX;
			this.y = nY;
		}
		
		
		
	}
}