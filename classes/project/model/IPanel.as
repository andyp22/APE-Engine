/**
 * classes.project.model.IPanel
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model  {
	import flash.display.DisplayObject;
	
	public interface IPanel  {
		
		function getName():String;
		function setHeader(sText:String):void
		function createContentContainer(mc:DisplayObject):void;
		function sizeToContents():void;
		function show():void;
		function hide():void;
		function disable():void;
		function enable():void;
		function isShowing():Boolean;
		function setPos(nX:Number, nY:Number):void;
	}
}