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
			//trace("Unit position has changed!!");
			//are we at the edge of the viewable area?
			if(!this.checkEdges())  {
				return;
			}
			trace("Need to update map!!");
			this.centerScreen(this._unit);
		}
		private function checkEdges():Boolean  {
			//what is the current position of the unit?
			var currentX:Number = this._unit.x;
			var currentY:Number = this._unit.y;
			
			var ansX:Number = (currentX - (-view.clip.x));
			var ansY:Number = (currentY - (-view.clip.y));
			
			if(ansX <= 0 || ansX >= MASK_WIDTH || ansY <= 0 || ansY >= MASK_HEIGHT)  {
				return true;
			}
			return false;
		}
		public function centerScreen(hUnit:HexUnit):void  {
			trace("centerMap()");
			var currentX:Number = hUnit.x;
			var currentY:Number = hUnit.y;
			
			var ansX:Number = (currentX - (-view.clip.x));
			var ansY:Number = (currentY - (-view.clip.y));
			
			var xDiff:Number = 0;
			var yDiff:Number = 0;
			
			if(ansY >= MASK_HEIGHT)  {
				yDiff = (MASK_HEIGHT/2) * (-1);
			} else if(ansY <= 0)  {
				yDiff = (MASK_HEIGHT/2);
			}
			if(ansX >= MASK_WIDTH)  {
				xDiff = (MASK_WIDTH/2) * (-1);
			} else if(ansX <= 0)  {
				xDiff = (MASK_WIDTH/2);
			}
			
			view.updatePosition(xDiff, yDiff);
		}
		
	}
}