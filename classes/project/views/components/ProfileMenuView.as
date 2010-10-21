/**
 * classes.project.views.components.ProfileMenuView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.Labels;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.GameControlEvent;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.model.controls.TabControl;
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	
	public class ProfileMenuView extends BaseView  {
		
		private var _assetId:String;
		
		private var _clip:MovieClip;
		private var _title:MovieClip;
		private var _tabs:Array = new Array();
		private var _overlays:Array = new Array();
		
		/**
		 * Constructor
		 */
		public function ProfileMenuView(sName:String, sAsset:String)  {
			super(sName, MovieClip(Server.getAsset(sAsset)));
			trace("Creating new ProfileMenuView() -- " + sName);
			
			this._assetId = sAsset;
			
			this.init();
			this.show();
		}
		private function init():void  {
			this._clip = LibFactory.createMovieClip("ProfileMenu_MC");
			this._title = this._clip.mcTitle;
			this.addChild(this._clip);
			
			this.setTitle();
			this.addTabs();
			this.initOverlays();
			
			
		}
		private function setTitle():void  {
			this._title.tf.text = Labels.getLabel("profile_view_title");
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
		
		private function addGameMenuBtn():void  {
			[Inject] var control:GameMenuControl = new GameMenuControl("gameMenu", LibFactory.createMovieClip("GameMenuButton"));
			control.setReleaseEvent(GameControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(control, "profile_menu_btns");
			control.x = 10;
			control.y = 10;
			this.addChild(control);
		}
		
		override public function show():void  {
			this._display = MovieClip(Server.getAsset(this._assetId));
			this.addChild(this._display);
			this._display.gotoAndPlay("profilesMenu");
			this.init();
			this.addGameMenuBtn();
			super.show();
			
		}
		public function showOverlay(sName:String):void  {
			this._overlays[sName].visible = true;
		}
		public function hideOverlays():void  {
			for(var elm in this._overlays)  {
				this._overlays[elm].visible = false;
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