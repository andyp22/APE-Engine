/**
 * classes.project.model.grid.HexStructure
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.core.Labels;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.ConstructionPanelEvent;
	import classes.project.model.grid.HexPiece;
	import classes.project.model.grid.ITile;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class HexStructure extends HexPiece {
		private var _clipID:String;
		
		/**
		 * Constructor
		 */
		public function HexStructure(id:Number, sName:String, sMCid:String)  {
			//trace("Creating a new HexStructure..." + id);
			super(id, sName, LibFactory.createMovieClip(sMCid));
			this._clipID = sMCid;
			
			this.init();
		}
		
		private function init():void  {
			this.buttonMode = true;
			this.mouseChildren = false;
		}
		public function targetTileValid(tile:ITile):Boolean  {
			if(tile.isWalkable() && !tile.isWater())  {
				return true;
			}
			return false;
		}
		public function get clipID():String  {
			return this._clipID;
		}
		override public function handleMousePress(e:MouseEvent):void  {
			//used to destroy buildings for now
			//will eventually be handled from building SatelliteView
			[Inject] Server.dispatch(new ConstructionPanelEvent(ConstructionPanelEvent.BUILDING_DESTROYED, this));
		}
		override public function getTooltipText():String  {
			return Labels.getLabel(this._sName + "_tooltip_txt");
		}
		override public function destroy():void  {
			super.destroy();
		}
		
	}
}