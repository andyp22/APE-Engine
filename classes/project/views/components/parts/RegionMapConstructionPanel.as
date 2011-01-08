/**
 * classes.project.views.components.parts.RegionMapConstructionPanel
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components.parts  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.core.StructureFactory;
	import classes.project.events.GuiControlEvent;
	import classes.project.events.GameControlEvent;
	import classes.project.events.PanelEvent;
	import classes.project.model.ContainerPanel;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.ConstructionPanelControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.model.grid.HexStructure;
	import classes.project.views.components.parts.MiniMap;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class RegionMapConstructionPanel extends ContainerPanel  {
		
		private var _controls:Array;
		
		public function RegionMapConstructionPanel(sName:String, mc:MovieClip)  {
			trace("Creating new RegionMapConstructionPanel...");
			super(sName, mc);
			this.init();
		}
		
		private function init():void  {
			//trace("RegionMapConstructionPanel initializing...");
			addChild(this.mcContent);
			
			this._controls = new Array();
			
			this.setHeader("Construction");
			this.createContentContainer(new MovieClip());
			this.sizeToContents();
			
			[Inject] Server.disableControlGroup("region_construction_menu");
			[Inject] Server.getControl("main_town").enable();
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = this.mcHeader.height + nPadding;
			
			
			var aOrder:Array = new Array();
			[Inject] var configs:Array = Configs.getConfigGroup("RegionStructureList");
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				
				var bConfigs:Array = new Array();
				bConfigs["type"] = aConfigs["sId"];
				bConfigs["nId"] = -1;
				bConfigs["sMCid"] = aConfigs["mcID"];
				
				[Inject] var building:HexStructure = StructureFactory.makeStructure(bConfigs);
				
				[Inject] var control:ConstructionPanelControl = new ConstructionPanelControl(aConfigs["sId"], LibFactory.createMovieClip("ConstructionPanel_Btn_MC"), false, building);
				
				var sGroups:String = aConfigs["sGroups"];
				[Inject] Server.addControl(control, sGroups);
				
				if(aConfigs["nOrder"] != null)  {
					aOrder[aConfigs["nOrder"]] = control;
				} else {
					aOrder.push(control);
				}
				
			}
			
			//display in the correct order
			var nX:int = 0;
			var nY:int = 0;
			for(var i:int = 0; i < aOrder.length; i++)  {
				aOrder[i].x = nX;
				aOrder[i].y = nY;
				
				nX += control.width + nPadding;
				if((((i+1) % 4) == 0) && i > 0)  {
					nX = 0;
					nY += control.height + nPadding;
				}
				
				this._controls.push(aOrder[i]);
				this.mcContent.addChild(aOrder[i]);
				
			}
			
			addChild(this.mcContent);
		}
		override public function sizeToContents():void  {
			var nPadding:int = this.mcContent.x;
			var newWidth:int = this.mcContent.width + nPadding*2;
			var newHeight:int = this.mcHeader.height + this.mcContent.height + nPadding*2;
			var widthDiff:int = this.mcPanel.mcBg.width - newWidth;
			
			this.mcPanel.mcBg.width = this.mcHeader.mcBg.width = newWidth;
			this.mcPanel.mcBg.height = newHeight;
			this.mcClose.x -= widthDiff;
		}
		
		public function getWidth():Number  {
			return this.mcPanel.mcBg.width;
		}
		
	}
}