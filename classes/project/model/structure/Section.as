/**
 * classes.project.model.structure.Section
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.structure  {
	
	
	
	
	public class Section {
		
		private var _id:String;
		private var _index:Number;
		private var _clips:Array;
		private var _currentSegs:Array;
		
		/**
		 * Constructor
		 */
		public function Section(sID:String)  {
			trace("\t\tCreating a new Section...");
			this._id = sID;
			
			this.init();
		}
		private function init():void  {
			
			this._clips = new Array();
			this._currentSegs = new Array();
			
		}
		public function addClip(clip:Clip):void  {
			trace("addClip()");
			this._clips.push(clip);
		}
		
		public function get index():Number  {
			return this._index;
		}
		public function set index(n:Number):void  {
			this._index = n;
		}
		
	}
}