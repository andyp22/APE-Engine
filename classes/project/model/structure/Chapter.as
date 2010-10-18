/**
 * classes.project.model.structure.Chapter
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.structure  {
	
	import classes.project.model.structure.*;
	
	
	public class Chapter {
		
		private var _id:String;
		private var _index:Number;
		private var _sections:Array;
		private var _currentClips:Array;
		private var _currentSegs:Array;
		
		/**
		 * Constructor
		 */
		public function Chapter(sID:String)  {
			trace("\tCreating a new Chapter...");
			this._id = sID;
			
			this.init();
		}
		private function init():void  {
			this._sections = new Array();
			this._currentClips = new Array();
			this._currentSegs = new Array();
			
			
		}
		public function addSection(section:Section):void  {
			trace("addSection()");
			this._sections.push(section);
		}
		
		public function get index():Number  {
			return this._index;
		}
		public function set index(n:Number):void  {
			this._index = n;
		}
		
	}
}