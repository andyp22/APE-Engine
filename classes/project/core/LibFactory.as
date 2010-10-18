/**
 * classes.project.core.LibFactory
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.core {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.utils.getDefinitionByName;

	
	public class LibFactory {
		public static function createMovieClip(classname:String):MovieClip{
			return MovieClip(createClassObject(classname));
		}
		public static function createSimpleButton(classname:String):SimpleButton {
			return SimpleButton(createClassObject(classname));
		}
		private static function createClassObject(classname:String):* {
			var c:Class = Class(getDefinitionByName(classname));
			return new c();
		}
	}
}