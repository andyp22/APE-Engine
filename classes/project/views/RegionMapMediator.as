/**
 * classes.project.views.RegionMapMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.core.GameController;
	import classes.project.core.LibFactory;
	import classes.project.core.State;
	import classes.project.core.ViewManager;
	import classes.project.core.ViewState;
	import classes.project.events.GuiControlEvent;
	import classes.project.events.ConstructionPanelEvent;
	import classes.project.events.PanelEvent;
	import classes.project.events.UnitFocusEvent;
	import classes.project.model.grid.HexStructure;
	import classes.project.model.grid.HexUnit;
	import classes.project.model.grid.IGrid;
	import classes.project.model.grid.ITile;
	import classes.project.views.components.RegionMapView;
	import classes.project.views.components.parts.RegionMapGUIPanel;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class RegionMapMediator extends Mediator  {
		
		[Inject] public var view:RegionMapView;
		
		private var _unit:HexUnit = null;
		private var MASK_WIDTH:Number = 800;
		private var MASK_HEIGHT:Number = 600;
		
		private var cursor:MovieClip;
		private var _selectedBuilding:HexStructure;
		
		
		public function RegionMapMediator()  {
			trace("Creating RegionMapMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("RegionMapMediator registered.");
			
			view.init(MASK_WIDTH, MASK_HEIGHT);
			
			eventMap.mapListener(eventDispatcher, ConstructionPanelEvent.SELECT_BUILDING_FOR_CONSTRUCTION, onBuildingSelected);
			eventMap.mapListener(eventDispatcher, GuiControlEvent.CONSTRUCTION_BTN_PRESSED, onConstructionBtnPressed);
			eventMap.mapListener(eventDispatcher, PanelEvent.MINI_MAP_UPDATED, onMiniMapUpdated);
			eventMap.mapListener(eventDispatcher, UnitFocusEvent.CENTER_FOCUSED_UNIT, onCenterFocusedUnit);
			eventMap.mapListener(eventDispatcher, UnitFocusEvent.DESTROY_UNIT_FOCUS, onUnitFocusDestroyed);
			eventMap.mapListener(eventDispatcher, UnitFocusEvent.NEW_UNIT_FOCUS, onNewUnitFocus);
			eventMap.mapListener(eventDispatcher, UnitFocusEvent.UNIT_POSITION_UPDATED, onUnitPositionChanged);
			
			this.cursor = new MovieClip();
			this._selectedBuilding = null;
		}
		private function onBuildingSelected(e:ConstructionPanelEvent) : void  {
			//trace("Building selected for construction: "+e.building.getName());
			this._selectedBuilding = e.building;
			//change the mouse to be building image
			Mouse.hide();
			this.cursor.visible = false;
			this.cursor = LibFactory.createMovieClip(this._selectedBuilding.clipID);
			this.cursor.x = e.stageX;
            this.cursor.y = e.stageY;
			view.addChild(this.cursor);
			
			view.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			this.cursor.addEventListener(MouseEvent.CLICK, mouseConstructionClickHandler);
			view.addEventListener(KeyboardEvent.KEY_UP, this.handleConstructionKeyRelease);
			
			
			//update the unit/structure info area
			
			
			
			this.mouseMoveHandler(new MouseEvent(MouseEvent.MOUSE_MOVE));
			
		}
		private function mouseMoveHandler(e:MouseEvent):void {
            //trace("mouseMoveHandler");
			var nX:Number = e.stageX;
            var nY:Number = e.stageY;
			
			if(nX < (0 + this.cursor.width/2))  {
				nX = (0 + this.cursor.width/2);
			} else if(nX > (MASK_WIDTH - this.cursor.width/2))  {
				nX = (MASK_WIDTH - this.cursor.width/2);
			}
			if(nY < (0 + this.cursor.height/2))  {
				nY = (0 + this.cursor.height/2);
			} else if(nY > (MASK_HEIGHT - this.cursor.height/2))  {
				nY = (MASK_HEIGHT - this.cursor.height/2);
			}
			
            this.cursor.x = nX;
            this.cursor.y = nY;
			this.cursor.visible = true;
            e.updateAfterEvent();
        }
		private function mouseConstructionClickHandler(e:MouseEvent):void {
            //trace("mouseConstructionClickHandler");
			var nX:Number = e.stageX;
            var nY:Number = e.stageY;
			
			//get the tile at the click location
			var currTile:ITile = view.grid.getTileByLocation((nX - view.clip.x), (nY - view.clip.y));
			//trace("currTile.getID(): "+currTile.getID());
			
			if(this._selectedBuilding.targetTileValid(currTile))  {
				//does the player have enough resources to build the structure?
				var bEnoughMouney:Boolean = true;
				if(bEnoughMouney)  {
					//remove the events
					view.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
					view.removeEventListener(KeyboardEvent.KEY_UP, handleConstructionKeyRelease);
					this.cursor.removeEventListener(MouseEvent.CLICK, mouseConstructionClickHandler);
					//show the mouse
					this.cursor.visible = false;
					view.removeChild(this.cursor);
					Mouse.show();
					//build the structure
					view.constructBuilding(this._selectedBuilding, currTile);
					//hide the unit/structure info area
					
					
					e.updateAfterEvent();
					this._selectedBuilding = null;
				}
			}
            
        }
		public function handleConstructionKeyRelease(e:KeyboardEvent):void  {
			//trace("handleConstructionKeyRelease() -- "+typeof(e.keyCode));
			
			var _ESC:Number = 27;		//escape key
			
			
			//trace("e.keyCode: "+e.keyCode);
			switch(e.keyCode)  {
				case _ESC:
					view.removeEventListener(KeyboardEvent.KEY_UP, handleConstructionKeyRelease);
					view.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
					this.cursor.removeEventListener(MouseEvent.CLICK, mouseConstructionClickHandler);
					this.cursor.visible = false;
					Mouse.show();
					return;
			}
			
		}
		private function onConstructionBtnPressed(e:GuiControlEvent) : void  {
			if(view.constructionPanelVisible())  {
				view.hideConstructionPanel();
			} else  {
				view.showConstructionPanel();
			}
		}
		private function onMiniMapUpdated(e:PanelEvent) : void  {
			var panel:RegionMapGUIPanel = RegionMapGUIPanel(e.panel);
			view.updateMap(-panel.mapCoords["x"], -panel.mapCoords["y"]);
		}
		private function onCenterFocusedUnit(e:UnitFocusEvent) : void  {
			this.centerScreen(this._unit);
		}
		private function onUnitFocusDestroyed(e:UnitFocusEvent) : void  {
			//trace("Unit focus destroyed!!");
			if(this._unit != null)  {
				this._unit.removeFocus();
			}
		}
		private function onNewUnitFocus(e:UnitFocusEvent) : void  {
			//trace("New Unit focus!! " + e.unit);
			this._unit = e.unit;
		}
		private function onUnitPositionChanged(e:UnitFocusEvent) : void  {
			//trace("Unit position has changed!!");
			//are we at the edge of the viewable area?
			if(!this.checkEdges())  {
				return;
			}
			//trace("Need to update map!!");
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
			//trace("centerScreen()");
			var currentX:Number = hUnit.x;
			var currentY:Number = hUnit.y;
			
			var ansX:Number = (currentX - (-view.clip.x));
			var ansY:Number = (currentY - (-view.clip.y));
			
			var xDiff:Number = 0;
			var yDiff:Number = 0;
			
			if(ansX >= MASK_WIDTH)  {
				xDiff = (MASK_WIDTH/2) * (-1);
			} else if(ansX <= 0)  {
				xDiff = (MASK_WIDTH/2);
			} else if(ansX > (MASK_WIDTH/2) && ansX < MASK_WIDTH)  {
				xDiff = (ansX - (MASK_WIDTH/2)) * (-1);
			} else if(ansX < (MASK_WIDTH/2) && ansX > 0)  {
				xDiff = ((MASK_WIDTH/2) - ansX);
			}
			if(ansY >= MASK_HEIGHT)  {
				yDiff = (MASK_HEIGHT/2) * (-1);
			} else if(ansY <= 0)  {
				yDiff = (MASK_HEIGHT/2);
			} else if(ansY > (MASK_HEIGHT/2) && ansY < MASK_HEIGHT)  {
				yDiff = (ansY - (MASK_HEIGHT/2)) * (-1);
			} else if(ansY < (MASK_HEIGHT/2) && ansY > 0)  {
				yDiff = ((MASK_HEIGHT/2) - ansY);
			}
			
			view.updateMapPosition(xDiff, yDiff);
		}
		
	}
}