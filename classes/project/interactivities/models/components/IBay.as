/**
 * classes.project.interactivities.models.components.IBay
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.components  {
	
	import classes.project.interactivities.models.components.IDragger;
	
	public interface IBay  {
		
		function getID():String;
		
		function getXPos():Number;
		function getYPos():Number;
		function getWidth():Number;
		function getHeight():Number;
		function getType():String;
		function setType(sType:String):void;
		
		function removeDragger(sID:String):void;
		function getDragger(sID:String):IDragger;
		function hasDragger(sID:String):Boolean;
		function addDragger(dragger:IDragger):void;
		function updateDisplay():void;
		function draggerList():Array;
		function hasMaxDraggers():Boolean;
		function resetDisplay():void;
		
	}
}