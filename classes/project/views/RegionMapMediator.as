/**
 * classes.project.views.RegionMapMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewManager;
	import classes.project.core.ViewState;
	import classes.project.events.UnitFocusEvent;
	import classes.project.model.grid.HexUnit;
	import classes.project.model.grid.IGrid;
	import classes.project.views.components.RegionMapView;
	
	import flash.geom.Point;
	import flash.display.Stage;
	
	
	import org.robotlegs.mvcs.Mediator;
	
	public class RegionMapMediator extends Mediator  {
		
		[Inject] public var view:RegionMapView;
		
		private var _unit:HexUnit = null;
		private var MASK_WIDTH:Number = 800;
		private var MASK_HEIGHT:Number = 600;
		
		public function RegionMapMediator()  {
			trace("Creating RegionMapMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("RegionMapMediator registered.");
			
			view.init(MASK_WIDTH, MASK_HEIGHT);
			
			//eventMap.mapListener(eventDispatcher, GameControlEvent.MAP_POSITION_UPDATED, onMapPositionChanged);
			eventMap.mapListener(eventDispatcher, UnitFocusEvent.DESTROY_UNIT_FOCUS, onUnitFocusDestroyed);
			eventMap.mapListener(eventDispatcher, UnitFocusEvent.NEW_UNIT_FOCUS, onNewUnitFocus);
			eventMap.mapListener(eventDispatcher, UnitFocusEvent.UNIT_POSITION_UPDATED, onUnitPositionChanged);
			
		}
		
		private function onUnitFocusDestroyed(e:UnitFocusEvent) : void  {
			trace("Unit focus destroyed!!");
			if(this._unit != null)  {
				this._unit.removeFocus();
			}
		}
		private function onNewUnitFocus(e:UnitFocusEvent) : void  {
			trace("New Unit focus!! " + e.unit);
			this._unit = e.unit;
		}
		private function onUnitPositionChanged(e:UnitFocusEvent) : void  {
			trace("Unit position has changed!!");
			//are we at the edge of the viewable area?
			if(!this.checkEdges())  {
				return;
			}
			//what is the current position of the unit?
			var currentX:Number = this._unit.x;
			var currentY:Number = this._unit.y;
			
			trace("currentX: "+currentX);
			trace("currentY: "+currentY);
			
			trace("view._units_lvl.x: "+view._units_lvl.x);
			trace("view._units_lvl.y: "+view._units_lvl.y);
			
			
			var ansX:Number = (currentX - (-view._units_lvl.x));
			var ansY:Number = (currentY - (-view._units_lvl.y));
			trace("answer X: "+ ansX);
			trace("answer Y: "+ ansY);
			
			//how far from the center is the unit?
			var nDiffX:Number = currentX - (MASK_WIDTH/2);
			var nDiffY:Number = currentY - (MASK_HEIGHT/2);
			
			trace("nDiffX: "+nDiffX);
			trace("nDiffY: "+nDiffY);
			
			//shift the layers by this difference
			
			this.centerMap(this._unit);
			//view.update(nDiffX, nDiffY);
		}
		private function checkEdges():Boolean  {
			//what is the current position of the unit?
			var currentX:Number = this._unit.x;
			var currentY:Number = this._unit.y;
			
			var ansX:Number = (currentX - (-view._units_lvl.x));
			var ansY:Number = (currentY - (-view._units_lvl.y));
			
			if(ansX <= 0 || ansX >= MASK_WIDTH || ansY <= 0 || ansY >= MASK_HEIGHT)  {
				trace("should update view position");
				return true;
			}
			/*if(ansY <= 0 || ansY >= MASK_HEIGHT)  {
				//return true;
			}*/
			
			return false;
		}
		public function centerMap(unit:HexUnit):void  {
			var sMapName:String = "sample_map";
			[Inject] var grid:IGrid = view.grid;
			
			var mapH:Number = grid.getHeight();
			var mapW:Number = grid.getWidth();
			var maskH:Number = grid.getMask().height;
			var maskW:Number = grid.getMask().width;
			
			if(unit.x != maskW/2 || unit.y != maskH/2)  {
				var xDiff:Number = (maskW/2 - unit.x);
				var yDiff:Number = (maskH/2 - unit.y);
				
				if(unit.getCurrentTile().xPos() < (maskW/2 - unit.getCurrentTile().getWidth()*(1/4)))  {
					//trace("less than halfway to the left side");
					xDiff = 0;
				}
				if(unit.getCurrentTile().xPos() > (mapW - (maskW/2 - unit.getCurrentTile().getWidth()*(1/4))))  {
					//trace("less than halfway to the right side");
					xDiff = 0;
				}
				if(unit.getCurrentTile().yPos() < (maskH/2 - unit.getCurrentTile().getHeight()*(3/4)))  {
					//trace("less than halfway to the top");
					yDiff = 0;
				}
				if(unit.getCurrentTile().yPos() > (mapH - (maskH/2 - unit.getCurrentTile().getHeight()*(3/4))))  {
					//trace("less than halfway to the bottom");
					yDiff = 0;
				}
				
				grid.updatePosition(xDiff, yDiff);
				view.update(xDiff, yDiff);
				//[Inject] Server.dispatch(new GameControlEvent("MAP_POSITION_UPDATED"));
			}
		}
		
	}
}