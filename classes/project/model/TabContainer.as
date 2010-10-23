/**
 * classes.project.model.TabContainer
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model  {
	
	import classes.project.core.LibFactory;
	import classes.project.core.OverlayFactory;
	import classes.project.core.Server;
	import classes.project.model.BaseOverlay;
	import classes.project.model.controls.TabControl;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class TabContainer extends Sprite  {
		private var _sName:String;
		private var _tabPanel:MovieClip;
		private var _tabs:Array = new Array();
		private var _overlays:Array = new Array();
		
		
		private var aTabList:Array = new Array();
		
		
		/**
		 * Constructor
		 */
		public function TabContainer(sName:String, mc:MovieClip)  {
			super();
			trace("Creating new TabContainer -- " + this + " : " + sName);
			this._sName = sName;
			this._tabPanel = mc;
			
			this.aTabList.push("players_tab");
			this.aTabList.push("characters_tab");
			this.aTabList.push("history_tab");
			
			this.init();
		}
		
		private function init():void  {
			//trace("TabContainer initializing...");
			addChild(this._tabPanel);
			
			this.addTabs();
			this.initOverlays();
			
		}
		
		private function addTabs():void  {
			var nX:Number = 0;
			
			for(var i = 0; i < this.aTabList.length; i++)  {
				var mcTab:TabControl = new TabControl(this.aTabList[i], LibFactory.createMovieClip("TabControl_BTN"));
				mcTab.x = nX;
				nX += mcTab.width;
				this._tabPanel.addChild(mcTab);
				this._tabs.push(mcTab);
				if(this.aTabList[i] == "players_tab")  {
					mcTab.select();
				}
				
			}
		}
		private function initOverlays():void  {
			var nPadding:Number = 10;
			var nX:Number = this._tabPanel.mcBg.x + nPadding;
			var nY:Number = this._tabPanel.mcBg.y + nPadding;
			
			//classes.project.model.overlays.PlayerProfileOverlay
			
			for(var i = 0; i < this.aTabList.length; i++)  {
				var overlay:IOverlay = OverlayFactory.makeOverlay(this.aTabList[i]);
				Sprite(overlay).x = nX;
				Sprite(overlay).y = nY;
				overlay.hide();
				
				this._overlays[overlay.getName()] = overlay;
				this._tabPanel.addChild(Sprite(overlay));
			}
			this.showOverlay("players_tab");
			
		}
		public function showOverlay(sName:String):void  {
			this._overlays[sName].show();
		}
		public function hideOverlays():void  {
			for(var elm in this._overlays)  {
				this._overlays[elm].hide();
			}
		}
		public function updateTabs(sName:String):void  {
			for(var i = 0; i < this._tabs.length; i++)  {
				this._tabs[i].deselect();
				if(this._tabs[i].getName() == sName)  {
					this._tabs[i].select();
				}
			}
		}
		
		
	}
}