/**
 * classes.project.model.TabContainer
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model  {
	
	import classes.project.core.Server;
	
	import classes.project.model.controls.TabControl;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class TabContainer extends Sprite  {
		private var _sName:String;
		private var _tabPanel:MovieClip;
		private var _tabs:Array = new Array();
		private var _overlays:Array = new Array();
		
		
		/**
		 * Constructor
		 */
		public function TabContainer(sName:String, mc:MovieClip)  {
			super();
			trace("Creating new TabContainer -- " + this + " : " + sName);
			this._sName = sName;
			this._tabPanel = mc;
			
			this.init();
		}
		
		private function init():void  {
			//trace("TabContainer initializing...");
			addChild(this._tabPanel);
			
			this.addTabs();
			this.initOverlays();
			
		}
		
		private function addTabs():void  {
			var aTabs:Array = new Array();
			aTabs.push("players_tab");
			aTabs.push("characters_tab");
			aTabs.push("history_tab");
			
			var nX:Number = 0;
			
			for(var i = 0; i < aTabs.length; i++)  {
				var mcTab:TabControl = new TabControl(aTabs[i], LibFactory.createMovieClip("TabControl_BTN"));
				mcTab.x = nX;
				nX += mcTab.width;
				this._clip.mcTabs.addChild(mcTab);
				this._tabs.push(mcTab);
				if(aTabs[i] == "players_tab")  {
					mcTab.select();
				}
				
			}
			//this._tabs[0].select();
		}
		private function initOverlays():void  {
			
			var nX:Number = this._clip.mcTabs.mcBg.x + 15;
			var nY:Number = this._clip.mcTabs.mcBg.y + 15;
			
			var oPlayers:MovieClip = LibFactory.createMovieClip("dummy1");
			this._overlays["players_tab"] = oPlayers;
			this._clip.mcTabs.addChild(oPlayers);
			
			
			var oCharacters:MovieClip = LibFactory.createMovieClip("dummy2");
			this._overlays["characters_tab"] = oCharacters;
			this._clip.mcTabs.addChild(oCharacters);
			oCharacters.visible = false;
			
			
			var oHistory:MovieClip = LibFactory.createMovieClip("dummy3");
			this._overlays["history_tab"] = oHistory;
			this._clip.mcTabs.addChild(oHistory);
			oHistory.visible = false;
			
			
			oPlayers.x = oCharacters.x = oHistory.x = nX;
			oPlayers.y = oCharacters.y = oHistory.y = nY;
			
		}
		
		
	}
}