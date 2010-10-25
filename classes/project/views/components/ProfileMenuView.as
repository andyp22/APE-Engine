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
	import classes.project.core.UserData;
	import classes.project.events.GameControlEvent;
	import classes.project.model.GuiControl;
	import classes.project.model.TabContainer;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.model.controls.TabControl;
	import classes.project.model.overlays.*;
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	
	public class ProfileMenuView extends BaseView  {
		
		private var _assetId:String;
		
		private var _clip:MovieClip;
		private var _title:MovieClip;
		private var _tabs:Array = new Array();
		private var _overlays:Array = new Array();
		
		private var _tabPanel:TabContainer;
		
		
		private var _playerProfiles:Array = new Array();
		
		/**
		 * Constructor
		 */
		public function ProfileMenuView(sName:String, sAsset:String)  {
			super(sName, MovieClip(Server.getAsset(sAsset)));
			trace("Creating new ProfileMenuView() -- " + sName);
			
			this._assetId = sAsset;
			
			this.getPlayerProfileData();
			
			this.init();
			this.show();
			
			
		}
		private function init():void  {
			this._clip = LibFactory.createMovieClip("ProfileMenu_MC");
			this._title = this._clip.mcTitle;
			this.addChild(this._clip);
			
			this.setTitle();
			this.initTab();
			
			[Inject] trace("Player Profile One: "+UserData.getUData("user_profile0"));
			
		}
		private function setTitle():void  {
			this._title.tf.text = Labels.getLabel("profile_view_title");
		}
		private function initTab():void  {
			this._tabPanel = new TabContainer("profile_tabs", LibFactory.createMovieClip("TabPanel_MC"));
			this._tabPanel.x = 20;
			this._tabPanel.y = 70;
			this._tabPanel.setOverlayData("players_tab", _playerProfiles);
			this._clip.addChild(this._tabPanel);
		}
		public function update(sName:String):void  {
			this._tabPanel.updateTabs(sName);
			this._tabPanel.hideOverlays();
			this._tabPanel.showOverlay(sName);
		}
		public function getPlayerProfiles():Array  {
			return PlayerProfileOverlay(this._tabPanel.getOverlay("players_tab")).getPlayers();
		}
		public function addPlayer(sName:String):void  {
			this._playerProfiles.push(sName);
			PlayerProfileOverlay(this._tabPanel.getOverlay("players_tab")).addPlayer(sName);
		}
		public function getActivePlayer():String  {
			var overlay = PlayerProfileOverlay(this._tabPanel.getOverlay("players_tab"));
			if(overlay.isPlayerSelected())  {
				return overlay.getSelectedPlayer();
			}
			return null;
		}
		public function deletePlayer(sPlayer:String):void  {
			var overlay = PlayerProfileOverlay(this._tabPanel.getOverlay("players_tab"));
			overlay.deletePlayer(sPlayer);
			
			for(var i = 0; i < this._playerProfiles.length; i++)  {
				if(this._playerProfiles[i] == sPlayer)  {
					this._playerProfiles.splice(i,1);
				}
			}
		}
		/*
		 *	Overrides
		 *
		 */
		override public function show():void  {
			this._display = MovieClip(Server.getAsset(this._assetId));
			this.addChild(this._display);
			this._display.gotoAndPlay("profilesMenu");
			this.init();
			super.show();
			
		}
		/*
		 *	Data
		 *
		 */
		private function getPlayerProfileData():void  {
			var i:Number = 0;
			[Inject] while(UserData.getUData("user_profile" + i) != null)  {
				[Inject] this._playerProfiles.push(UserData.getUData("user_profile" + i));
				
				i++;
			}
		}
		
	}
}