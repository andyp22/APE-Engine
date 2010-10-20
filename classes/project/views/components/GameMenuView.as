/**
 * classes.project.views.components.GameMenuView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.GameControlEvent;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	
	public class GameMenuView extends BaseView  {
		
		private var _assetId:String;
		private var mcMenuHolder:MovieClip;
		
		/**
		 * Constructor
		 */
		public function GameMenuView(sName:String, sAsset:String)  {
			super(sName, MovieClip(Server.getAsset(sAsset)));
			trace("Creating new GameMenuView() -- " + sName);
			
			this._assetId = sAsset;
			this.show();
		}
		
		private function initMenu():void  {
			mcMenuHolder = new MovieClip();
			this.addChild(mcMenuHolder);
			// add some controls
			var aOrder:Array = new Array();
			[Inject] var configs:Array = Configs.getConfigGroup("GameMenuControls");
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				[Inject] var control:GameMenuControl = new GameMenuControl(aConfigs["sId"], LibFactory.createMovieClip("GameMenuButton"));
				
				if(aConfigs["sEvent"] != null)  {
					control.setReleaseEvent(GameControlEvent[aConfigs["sEvent"]]);
				}
				
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
			var nPadding:Number = 5;
			for(var i:int = 0; i < aOrder.length; i++)  {
				aOrder[i].x = nX;
				aOrder[i].y = nY;
				
				nY += aOrder[i].height + nPadding;
				
				mcMenuHolder.addChild(aOrder[i]);
				
			}
			mcMenuHolder.x = 400 - aOrder[0].width/2;
			mcMenuHolder.y = 170;
			
			
		}
		
		override public function show():void  {
			this._display = MovieClip(Server.getAsset(this._assetId));
			this.addChild(this._display);
			this._display.gotoAndPlay("gameMenu");
			this.initMenu();
			super.show();
			
		}
		
	}
}