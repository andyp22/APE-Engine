/**
 * classes.project.model.loader.ILoader
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.loader  {
	
	import classes.project.model.loader.LoadData;
	
	import flash.events.IEventDispatcher;
	
	public interface ILoader  {
		
		function load(lData:LoadData):void;
		function kill():void;
		function getLoadData():LoadData;
		function setEventDispatcher(value:IEventDispatcher):void;
		
		
	}
}