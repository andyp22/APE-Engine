/**
 * classes.project.model.grid.IHexPiece
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid  {
	
	import classes.project.model.grid.ITile;
	
	public interface IHexPiece  {
		function getName():String;
		function getID():Number;
		function getCurrentTile():ITile;
		function getTooltipText():String;
		function setPosition(nX:Number, nY:Number):void;
		function getFactionID():Number;
		function setFactionID(n:Number):void;
		
	}
}