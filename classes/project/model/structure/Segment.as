/**
 * classes.project.model.structure.Segment
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.structure  {
	
	import classes.project.model.structure.*;
	
	
	public class Segment {
		
		private var _id:String;
		private var _link:String;
		private var _absoluteIndex:Number;
		private var _relativeIndex:Number;
		private var _chapter:Chapter;
		private var _section:Section;
		private var _clip:Clip;
		
		private var _args:Array;
		
		
		/**
		 * Constructor
		 */
		public function Segment(sID:String, sLink:String, abs:Number, rel:Number)  {
			trace("\t\t\t\tCreating a new Segment...");
			this._id = sID;
			this._link = sLink;
			this._absoluteIndex = abs;
			this._relativeIndex = rel;
			this.init();
		}
		private function init():void  {
			
			this._args = new Array();
			
			trace("\t\t\t\tSegment -- id: " + this._id + " link: " + this._link + " Abs: " + this._absoluteIndex + " Rel: " + this._relativeIndex);
			
		}
		public function setArgs(args:Array):void  {
			this._args = args;
		}
		
		public function get id():String  {
			return this._id;
		}
		public function get link():String  {
			return this._link;
		}
		public function get absoluteIndex():Number  {
			return this._absoluteIndex;
		}
		public function get relativeIndex():Number  {
			return this._relativeIndex;
		}
		
		public function set chapter(c:Chapter):void  {
			this._chapter = c;
		}
		public function get chapter():Chapter  {
			return this._chapter;
		}
		public function set section(s:Section):void  {
			this._section = s;
		}
		public function get section():Section  {
			return this._section;
		}
		public function set clip(c:Clip):void  {
			this._clip = c;
		}
		public function get clip():Clip  {
			return this._clip;
		}
		
	}
}