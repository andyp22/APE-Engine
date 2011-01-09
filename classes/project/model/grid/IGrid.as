/**
 * classes.project.model.grid.IGrid
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid  {
	
	import classes.project.model.grid.ITile;
	
	import flash.display.Sprite;
	
	public interface IGrid  {
		function getID():String;
		function xPos():Number;
		function yPos():Number;
		function updatePosition(nX:Number, nY:Number):void;
		function getMask():Sprite;
		function getTileByLocation(xPos:Number, yPos:Number):ITile;
		
	}
}