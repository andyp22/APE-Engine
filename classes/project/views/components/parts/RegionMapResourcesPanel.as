﻿/**
 * classes.project.views.components.parts.RegionMapResourcesPanel
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components.parts  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.model.ContainerPanel;
	import classes.project.model.Tooltips;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class RegionMapResourcesPanel extends ContainerPanel  {
		
		private var _fixedWidth:Number;
		
		public function RegionMapResourcesPanel(sName:String, mc:MovieClip, nW:Number)  {
			trace("Creating new RegionMapResourcesPanel -- " + this + " : " + sName);
			super(sName, mc);
			this._fixedWidth = nW;
			this.init();
		}
		
		private function init():void  {
			trace("RegionMapResourcesPanel initializing...");
			addChild(this.mcContent);
			
			this.createContentContainer(new MovieClip());
			this.sizeToContents();
			this.hideCloseBtn();
			this.show();
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			var nPadding:int = 2.5;
			this.mcContent = MovieClip(mc);
			this.mcContent.x = 0;
			this.mcContent.y = nPadding;
			
			this.mcHeader.width = this.mcHeader.height = 0;
			this.mcHeader.visible = false;
			
			var aOrder:Array = new Array();
			[Inject] var configs:Array = Configs.getConfigGroup("RegionResourceList");
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				
				var mcResource:MovieClip = LibFactory.createMovieClip("ResourcesPanel_Resource_MC");
				mcResource.mcIcon.gotoAndStop(aConfigs["sId"]);
				mcResource.sID = aConfigs["sId"];
				
				if(aConfigs["nOrder"] != null)  {
					aOrder[aConfigs["nOrder"]] = mcResource;
				} else {
					aOrder.push(mcResource);
				}
				
				if(aConfigs["nQuantity"] != null)  {
					mcResource.tf.text = aConfigs["nQuantity"];
				} else {
					mcResource.tf.text = "0";
				}
				
				mcResource.mouseChildren = false;
				mcResource.buttonMode = true;
				mcResource.useHandCursor = false;
				
				mcResource.getTooltipText = function()  {
					return this.sID;
				}
				
				mcResource.addEventListener(MouseEvent.ROLL_OVER, onResourceRollOver);
				mcResource.addEventListener(MouseEvent.ROLL_OUT, onResourceRollOut);
				
			}
			
			//display in the correct order
			nPadding = 10;
			var nX:Number = this._fixedWidth;
			var nY:Number = 0;
			for(var i:int = 0; i < aOrder.length; i++)  {
				nX -= (aOrder[i].width + nPadding);
				aOrder[i].x = nX;
				aOrder[i].y = nY;
				
				this.mcContent.addChild(aOrder[i]);
			}
			
			var mcDate:MovieClip = LibFactory.createMovieClip("ResourcesPanel_Date_MC");
			mcDate.tf.htmlText = "<b>February 1594</b>";
			mcDate.x = 5;
			mcDate.y = 0;
			this.mcContent.addChild(mcDate);
			
			addChild(this.mcContent);
		}
		override public function sizeToContents():void  {
			var nPadding:int = this.mcContent.y;
			var newHeight:int = this.mcContent.height + nPadding*2;
			
			this.mcPanel.mcBg.width = this._fixedWidth;
			this.mcPanel.mcBg.height = newHeight;
		}
		private function onResourceRollOver(e:MouseEvent):void  {
			[Inject] Tooltips.create(e, "ResourceTooltips");
		}
		private function onResourceRollOut(e:MouseEvent):void  {
			[Inject] Tooltips.destroy();
		}
		
	}
}