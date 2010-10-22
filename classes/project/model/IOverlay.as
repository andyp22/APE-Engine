/**
 * classes.project.model.IOverlay
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model  {
	import flash.display.DisplayObject;
	
	public interface IOverlay  {
		
		function getName():String;
		function show():void;
		function hide():void;
		function disable():void;
		function enable():void;
		function isEnabled():Boolean;
		function isShowing():Boolean;
		function setPos(nX:Number, nY:Number):void;
	}
}