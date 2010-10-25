/**
 * classes.project.model.overlays.PlayerProfileOverlay
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.overlays  {
	
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.GameControlEvent;
	import classes.project.events.GuiControlEvent;
	import classes.project.model.BaseOverlay;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PlayerProfileOverlay extends BaseOverlay  {
		
		private var mcSelector:MovieClip;
		
		private var _players:Array = new Array();
		
		/**
		 * Constructor
		 */
		public function PlayerProfileOverlay(sName:String, mc:MovieClip)  {
			super(sName, mc);
			trace("Creating new PlayerProfileOverlay -- " + this + " : " + sName);
			
			this.init();
			
			//this.addPlayer("Andrew_old");
			//this.addPlayer("Andrew_new");
			//this.addPlayer("Andrew_current");
			//this.addPlayer("Cecil");
			//this.addPlayer("BuckaMuck");
		}
		
		private function init():void  {
			//trace("PlayerProfileOverlay initializing...");
			
			this.initPlayerSelectors();
			this.initOverlayControls();
			
			
		}
		
		private function initPlayerSelectors():void  {
			this.mcSelector = this._overlay.mcSelector;
			
			var i:Number = 0;
			while(this.mcSelector["mcText"+i] != null)  {
				var mcPlayer:MovieClip = this.mcSelector["mcText"+i];
				mcPlayer.mcSelected.visible = false;
				mcPlayer.tf.text = "";
				mcPlayer.buttonMode = true;
				mcPlayer.mouseChildren = false;
				
				mcPlayer.addEventListener(MouseEvent.CLICK, onPlayerClick);
				mcPlayer.addEventListener(MouseEvent.MOUSE_OVER, onPlayerRollOver);
				
				this._players.push(mcPlayer);
				i++;
			}
		}
		private function initOverlayControls():void  {
			var nPadding:Number = 20;
			var nX:Number = this.mcSelector.x + 10;
			var nY:Number = this.mcSelector.y + this.mcSelector.height + nPadding*2;
			
			[Inject] var createPlayerControl:GuiControl = new GuiControl("createPlayerBtn", LibFactory.createMovieClip("GameMenuButton"));
			createPlayerControl.setReleaseEvent(GuiControlEvent.CREATE_PLAYER_BTN_PRESSED);
			[Inject] Server.addControl(createPlayerControl, "profile_menu_player_btns");
			createPlayerControl.x = nX;
			createPlayerControl.y = nY;
			createPlayerControl.disableTooltip();
			this._overlay.addChild(createPlayerControl);
			
			nY += createPlayerControl.height + nPadding;
			
			[Inject] var loadPlayerControl:GuiControl = new GuiControl("loadPlayerBtn", LibFactory.createMovieClip("GameMenuButton"));
			loadPlayerControl.setReleaseEvent(GuiControlEvent.LOAD_PLAYER_BTN_PRESSED);
			[Inject] Server.addControl(loadPlayerControl, "profile_menu_player_btns");
			loadPlayerControl.x = nX;
			loadPlayerControl.y = nY;
			loadPlayerControl.disableTooltip();
			this._overlay.addChild(loadPlayerControl);
			
			nY += loadPlayerControl.height + nPadding;
			
			[Inject] var deletePlayerControl:GuiControl = new GuiControl("deletePlayerBtn", LibFactory.createMovieClip("GameMenuButton"));
			deletePlayerControl.setReleaseEvent(GuiControlEvent.DELETE_PLAYER_BTN_PRESSED);
			[Inject] Server.addControl(deletePlayerControl, "profile_menu_player_btns");
			deletePlayerControl.x = nX;
			deletePlayerControl.y = nY;
			deletePlayerControl.disableTooltip();
			this._overlay.addChild(deletePlayerControl);
			
			nY += deletePlayerControl.height + nPadding;
			
			
			[Inject] var gameMenuControl:GameMenuControl = new GameMenuControl("gameMenu", LibFactory.createMovieClip("GameMenuButton"));
			gameMenuControl.setReleaseEvent(GameControlEvent.GAME_MENU_BTN_PRESSED);
			[Inject] Server.addControl(gameMenuControl, "profile_menu_player_btns");
			gameMenuControl.x = nX;
			gameMenuControl.y = nY;
			this._overlay.addChild(gameMenuControl);
			
		}
		
		private function onPlayerClick(e:MouseEvent):void  {
			if(e.target.tf.text != "")  {
				var bShow:Boolean = false;
				if(!e.target.mcSelected.visible)  {
					bShow = true;
				}
				this.deselectPlayers();
				e.target.mcSelected.visible = bShow;
			}
		}
		private function onPlayerRollOver(e:MouseEvent):void  {
			if(e.target.tf.text == "")  {
				e.target.buttonMode = false;
			} else  {
				e.target.buttonMode = true;
			}
		}
		
		private function deselectPlayers():void  {
			for(var i = 0; i < this._players.length; i++)  {
				this._players[i].mcSelected.visible = false;
			}
		}
		public function getPlayers():Array  {
			return this._players;
		}
		public function addPlayer(sName:String):void  {
			var nIndex:Number = 0;
			for(var i = 0; i < this._players.length; i++)  {
				if(this._players[i].tf.text != null && this._players[i].tf.text != "")  {
					nIndex++;
				}
			}
			this._players[nIndex].tf.text = sName;
		}
		public function isPlayerSelected():Boolean  {
			for(var i = 0; i < this._players.length; i++)  {
				if(this._players[i].mcSelected.visible)  {
					return true;
				}
			}
			return false;
		}
		public function getSelectedPlayer():String  {
			for(var i = 0; i < this._players.length; i++)  {
				if(this._players[i].mcSelected.visible)  {
					return this._players[i].tf.text;
				}
			}
			return null;
		}
		public function deletePlayer(sPlayer:String):void  {
			var newList:Array = new Array();
			for(var i = 0; i < this._players.length; i++)  {
				if(this._players[i].tf.text == sPlayer)  {
					//do some stuff to delete all the player info
					
					
					
					
				} else  {
					newList.push(this._players[i].tf.text);
				}
			}
			this._players = new Array();
			this.initPlayerSelectors();
			
			for(var j = 0; j < newList.length; j++)  {
				this.addPlayer(newList[j]);
			}
			
		}
		public function setProfileData(aData:Array):void  {
			for(var i = 0; i < aData.length; i++)  {
				this.addPlayer(aData[i]);
			}
			
			
		}
		
		
	}
}