/**
 * classes.project.core.Structure
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.model.structure.*;
	
	
	public class Structure  {
		private static var instance:Structure;
		private static var bInit:Boolean = true;
		
		private static var _xml:XML;
		private static var _xmlData:Array;
		
		private static var _chapters:Array = new Array();
		private static var _sections:Array = new Array();
		private static var _clips:Array = new Array();
		private static var _segments:Array = new Array();
		
		
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Structure  {
			if(instance == null)  {
				instance = new Structure();			}
			return instance;
		}
		public function Structure():void  {
			
		}
		public static function init(xml:XML):void  {
			if(bInit)  {
				trace("Structure initializing...");
				_xml = xml;
				parseXMLData();
				bInit = false;
				
			} else  {
				trace("Structure has already been initialized.");
			}
		}
		private static function parseXMLData():void  {
			trace("\n\t\Course\n------------------------------------------------------------");
			var chapters:Array = new Array();
			var nAbsoluteIndex:Number = 0;
			var nRelativeIndex:Number = 0;
			
			var nChapter:Number = 0;
			var nSection:Number = 0;
			var nClip:Number = 0;
			
			
			for each (var chapter:XML in _xml..chapter) {
				//trace("\tchapter --  id: "+chapter.@id);
				var currentChapter:Chapter = new Chapter(chapter.@id);
				currentChapter.index = nChapter;
				nSection = 0;
				
				for each (var section:XML in chapter..section) {
					//trace("\t\tsection --  id: "+section.@id);
					var currentSection:Section = new Section(section.@id);
					currentSection.index = nSection;
					nClip = 0;
					
					for each (var clip:XML in section..clip) {
						//trace("\t\t\tclip --  id: "+clip.@id);
						var currentClip:Clip = new Clip(clip.@id);
						currentClip.index = nClip;
						//"clips/chap1/sect1/c2"
						currentClip.url = "clips/chap" + (nChapter + 1) + "/sect" + (nSection + 1) + "/c" + (nClip + 1);
						//"clips_chap1_sect1_c1"
						currentClip.link = "clips_chap" + (nChapter + 1) + "_sect" + (nSection + 1) + "_c" + (nClip + 1);
						
						for each (var segment:XML in clip..segment) {
							
							var sLink:String = chapter.@id + "_" + section.@id + "_" + clip.@id + "_" + segment.@id;
							var currentSegment:Segment = new Segment(segment.@id, sLink, nAbsoluteIndex, nRelativeIndex);
							
							currentSegment.chapter = currentChapter;
							currentSegment.section = currentSection;
							currentSegment.clip = currentClip;
							
							
							//add each element in the column to the array
							var attNamesList:XMLList = segment.@*;
							//create our output trace
							var sOutput:String = "\t\t\t\tsegment -- ";
							var aArgs:Array = new Array();
							for (var z:int = 0; z < attNamesList.length(); z++)  {
								//get the element name
								var element:String = String(attNamesList[z].name());
								//get the element's value
								var elementValue:String = String(attNamesList[z].valueOf());
								//add it to our array
								aArgs[element] = elementValue;
								//add each element to our output string
								sOutput += ("\t " + element + ": " + elementValue);
							}
							trace(sOutput);
							
							currentSegment.setArgs(aArgs);
							
							nRelativeIndex++;
							nAbsoluteIndex++;
							currentClip.addSegment(currentSegment);
							_segments.push(currentSegment);
							
						}
						nClip++;
						nRelativeIndex = 0;
						currentSection.addClip(currentClip);
						_clips.push(currentClip);
						
					}
					nSection++;
					currentChapter.addSection(currentSection);
					_sections.push(currentSection);
					
				}				
				nChapter++;
				_chapters.push(currentChapter);
				
				
			}
			_xmlData = _chapters;
			
			
		}
		
		public static function getSegmentByIndex(nIndex:Number):Segment  {
			return _segments[nIndex];
		}
		
		
		
	}
}