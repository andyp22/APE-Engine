/**
 * classes.project.interactivities.models.components.IDragger
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.components  {
	
	import classes.project.interactivities.models.components.IBay;
	
	public interface IDragger  {
		
		function getID():String;
		
		function getCorrectBay():IBay;
		function getCurrentBay():IBay;
		function getSourceBay():IBay;
		
		//function getXPos():Number;
		//function getYPos():Number;
		//function getStartX():Number;
		//function getStartY():Number;
		//function setPos(nX:Number, nY:Number):void;
		
		function resetPos():void;
	}
}