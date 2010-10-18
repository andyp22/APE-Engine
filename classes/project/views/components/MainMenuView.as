/**
 * classes.project.views.components.MainMenuView
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.GuiControlEvent;
	import classes.project.model.*;
	import classes.project.views.*;
	import classes.project.views.components.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class MainMenuView extends ContainerPanel  {
		
		[Inject] private var testControl:GuiControl;
		[Inject] private var _save_btn:GuiControl;
		
		public function MainMenuView(sName:String, mc:MovieClip)  {
			trace("Creating new MainMenuView -- " + this + " : " + sName);
			super(sName, mc);
			this.init();
		}
		
		private function init():void  {
			trace("MainMenuView initializing...");
			addChild(this.mcContent);
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = this.mcHeader.height + nPadding;
			
			// add some controls
			var nX:int = 0;
			var nY:int = 0;
			var nCol:int = 0;
			var nCols:int = 2;
			var aOrder:Array = new Array();
			[Inject] var configs:Array = Configs.getConfigGroup("GuiControls");
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				[Inject] var control:GuiControl = new GuiControl(aConfigs["sId"], LibFactory.createMovieClip("MenuButton"));
				
				if(aConfigs["sEvent"] != null)  {
					control.setReleaseEvent(GuiControlEvent[aConfigs["sEvent"]]);
				}
				
				var sGroups:String = aConfigs["sGroups"];
				[Inject] Server.addControl(control, sGroups);
				
				if(aConfigs["bEnabled"] != null && aConfigs["bEnabled"] == "false")  {
					if(Server.hasControl(aConfigs["sId"]))  {
						Server.getControl(aConfigs["sId"]).disable();
					}
				}
				if(aConfigs["nOrder"] != null)  {
					aOrder[aConfigs["nOrder"]] = control;
				} else {
					aOrder.push(control);
				}
				
			}
			//display in the correct order
			for(var i:int = 0; i < aOrder.length; i++)  {
				aOrder[i].x = nX;
				aOrder[i].y = nY;
				nX += aOrder[i].width + nPadding;
				nCol++;
				if(nCol >= nCols)  {
					nCol = 0;
					nX = 0;
					nY += aOrder[i].height + nPadding;
				}
				
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
			this.mcHeader.tf.width
		}
		
		
	}
}