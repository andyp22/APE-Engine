/**
 * classes.project.interactivities.models.components.IPopup
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.components  {
	
	
	public interface IPopup  {
		
		function getID():String;
		function setText(sText:String):void;
		function setLabel(sText:String):void;
		function initBlocker(nW:uint, nH:uint):void;
		function positionPopup():void;
		function show():void;
		function hide():void;
		
		
	}
}