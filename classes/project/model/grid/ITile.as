/**
 * classes.project.model.grid.ITile
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid  {
	
	
	public interface ITile  {
		function getID():String;
		function getHeight():Number;
		function getWidth():Number;
		function xPos():Number;
		function yPos():Number;
		function isWalkable():Boolean;
		function isWater():Boolean;
		
	}
}