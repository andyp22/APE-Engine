/**
 * classes.project.model.PlayerResource
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model  {
	
	import classes.project.core.Server;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class PlayerResource extends Sprite  {
		private var _sName:String;
		private var _nQuantity:Number;
		private var _sClip:String;
		
		
		/**
		 * Constructor
		 */
		public function PlayerResource(sName:String, sMovieClip:String, qty:Number = 0)  {
			super();
			trace("Creating new PlayerResource...");
			this._sName = sName;
			this._nQuantity = qty;
			this._sClip = sMovieClip;
			
			
		}
		
		public function getName():String  {
			return this._sName;
		}
		public function getQty():Number  {
			return this._nQuantity;
		}
		public function getClipID():String  {
			return this._sClip;
		}
		public function update(n:Number):void  {
			this._nQuantity += n;
		}
		
		
		
		
	}
}