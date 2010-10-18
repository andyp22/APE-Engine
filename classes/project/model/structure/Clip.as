/**
 * classes.project.model.structure.Clip
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.structure  {
	
	
	
	
	public class Clip {
		
		private var _id:String;
		private var _index:Number;
		private var _sUrl:String;
		private var _sLink:String;
		private var _segments:Array;
		
		/**
		 * Constructor
		 */
		public function Clip(sID:String)  {
			trace("\t\t\tCreating a new Clip...");
			this._id = sID;
			
			this.init();
		}
		private function init():void  {
			
			this._segments = new Array();
			
		}
		public function addSegment(segment:Segment):void  {
			trace("addSegment()");
			this._segments.push(segment);
		}
		public function get index():Number  {
			return this._index;
		}
		public function set index(n:Number):void  {
			this._index = n;
		}
		public function get url():String  {
			return this._sUrl;
		}
		public function set url(s:String):void  {
			this._sUrl = s;
		}
		public function get link():String  {
			return this._sLink;
		}
		public function set link(s:String):void  {
			this._sLink = s;
		}
		
	}
}