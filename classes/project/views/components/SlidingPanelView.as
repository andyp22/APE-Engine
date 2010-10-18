/**
 * classes.project.views.components.SlidingPanelView
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
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import fl.motion.easing.Linear;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;

	public class SlidingPanelView extends ContainerPanel  {
		
		private var mcHotspot:MovieClip;
		private var _hitArea:Sprite;
		private var sAlign:String;
		private var sDirection:String;
		
		private var nOrigX:int;
		private var nOrigY:int;
		private var nVisibleX:int;
		private var nVisibleY:int;
		
		private var bTweenEnabled:Boolean;
		
		public function SlidingPanelView(sName:String, mc:MovieClip)  {
			trace("Creating new SlidingPanelView -- " + this + " : " + sName);
			super(sName, mc);
			this.init();
		}
		
		private function init():void  {
			trace("SlidingPanelView initializing...");
			addChild(this.mcContent);
			this.visible = true;
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			var nPadding:int = 5;
			this.mcContent = MovieClip(mc);
			this.mcContent.x = nPadding;
			this.mcContent.y = nPadding;
			
			this.mcHeader.visible = false;
			this.hideCloseBtn();
			
			// add some controls
			var nX:int = 0;
			var nY:int = 0;
			var aOrder:Array = new Array();
			[Inject] var configs:Array = Configs.getConfigGroup("SlidingPanelControls");
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
						[Inject] Server.getControl(aConfigs["sId"]).disable();
					}
				}
				if(aConfigs["nOrder"] != null)  {
					aOrder[aConfigs["nOrder"]] = control;
				} else {
					aOrder.push(control);
				}
				[Inject] Server.getControl(aConfigs["sId"]).disableTooltip();
			}
			//display in the correct order
			for(var i:int = 0; i < aOrder.length; i++)  {
				aOrder[i].x = nX;
				aOrder[i].y = nY;
				nY += aOrder[i].height + nPadding;
				
				this.mcContent.addChild(aOrder[i]);
			}
			addChild(this.mcContent);
			this.alignToSide("default");
		}
		
		override public function sizeToContents():void  {
			this.sizeToStage();
			this.updatePosition();
			this.initHotspot();
		}
		public function alignToSide(sAlign:String):void  {
			this.sAlign = sAlign;
			switch(this.sAlign)  {
				case "left":
				case "right":
					this.sDirection = "vertical";
					break;
				case "top":
				case "bottom":
					this.sDirection = "horizontal";
					break;
				default:
					this.sDirection = "vertical";
					this.sAlign = "right";
			}
		}
		private function sizeToStage():void  {
			var nPadding:int = this.mcContent.x;
			var newHeight:int = 0;
			var newWidth:int = 0;
			switch(this.sDirection)  {
				case "horizontal":
					newWidth = stage.stageWidth;
					newHeight = this.mcContent.height + nPadding*2;
					break;
				case "vertical":
					newHeight = stage.stageHeight;
					newWidth = this.mcContent.width + nPadding*2;
					break;
			}
			this.mcPanel.mcBg.width = newWidth;
			this.mcPanel.mcBg.height = newHeight;
		}
		private function initHotspot():void  {
			this.mcHotspot = new MovieClip();
			this.mcHotspot.addChild(this.doDrawHotspot());
			
			var nX:int = 0;
			var nY:int = 0;
			
			switch(this.sAlign)  {
				case "right":
					nX = this.mcHotspot.width*(-1);
					break;
				case "left":
					nX = this.mcPanel.mcBg.width;
					break;
				case "top":
					nY = this.mcPanel.mcBg.height;
					break;
				case "bottom":
					nY = this.mcHotspot.height*(-1);
					break;
			}
			this.mcHotspot.x = nX;
			this.mcHotspot.y = nY;
			this.mcHotspot.enabled = false;
			addChild(this.mcHotspot);
			
			this.initHitArea();
		}
		private function initHitArea():void  {
			this._hitArea = new Sprite();
			
			var nW:uint = 0;
			var nH:uint = 0;
			var nX:int = 0;
			var nY:int = 0;
			
			// determine the height and width of the hitArea
			switch(this.sDirection)  {
				case "horizontal":
					nH = this.mcPanel.mcBg.height + this.mcHotspot.height;
					nW = this.mcPanel.mcBg.width;
					break;
				case "vertical":
					nW = this.mcPanel.mcBg.width + this.mcHotspot.width;
					nH = this.mcPanel.mcBg.height;
					break;
			}
			// determine the position of the hitArea
			switch(this.sAlign)  {
				case "left":
					nX = this.mcPanel.mcBg.x;
					break;
				case "right":
					nX = this.mcHotspot.x;
					break;
				case "top":
					nY = this.mcPanel.mcBg.y;
					break;
				case "bottom":
					nY = this.mcHotspot.y;
					break;
				default:
					nX = this.mcHotspot.x;
			}
			this._hitArea.graphics.beginFill(0xCCFF00);
			this._hitArea.graphics.drawRect(0, 0, nW, nH);
			this._hitArea.mouseEnabled = false;
			this._hitArea.useHandCursor = false;
			this._hitArea.visible = false;
			this._hitArea.x = nX;
			this._hitArea.y = nY;
			
			this.hitArea = this._hitArea;
			this.addEventListener(MouseEvent.ROLL_OVER, this.handleHotspotRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.handleHotspotRollOut);
			
			addChild(this._hitArea);
			this.bTweenEnabled = true;
		}
		private function doDrawHotspot():Shape {
            var child:Shape = new Shape();
			var nH:uint = 0;
			var nW:uint = 0;
			var bgColor:uint = 0xFFCC00;
			
			switch(this.sDirection)  {
				case "vertical":
					nH = this.mcPanel.mcBg.height;
					nW = 30;
					break;
				case "horizontal":
					nH = 20;
					nW = this.mcPanel.mcBg.width;
					break;
			}
			child.graphics.beginFill(bgColor);
            child.graphics.drawRect(0, 0, nW, nH);
            child.graphics.endFill();
			child.alpha = 0;
            return child;
        }
		private function updatePosition():void  {
			this.x = 0;
			this.y = 0;
			var newX:int = 0;
			var newY:int = 0;
			switch(this.sAlign)  {
				case "right":
					this.x = stage.stageWidth;
					newX = this.x - this.mcPanel.mcBg.width;
					break;
				case "left":
					this.x = this.mcPanel.mcBg.width*(-1);
					newX = this.x + this.mcPanel.mcBg.width;
					break;
				case "top":
					this.y = this.mcPanel.mcBg.height*(-1);
					newY = this.y + this.mcPanel.mcBg.height;
					break;
				case "bottom":
					this.y = stage.stageHeight;
					newY = this.y - this.mcPanel.mcBg.height;
					break;
			}
			this.nOrigX = this.x;
			this.nOrigY = this.y;
			this.nVisibleX = newX;
			this.nVisibleY = newY;
		}
		public function handleHotspotRollOver(e:MouseEvent):void  {
			trace("handleHotspotRollOver()");
			if(!this.bShowing)  {
				this.show();
			}
		}
		public function handleHotspotRollOut(e:MouseEvent):void  {
			trace("handleHotspotRollOut()");
			if(this.bShowing)  {
				this.hide();
			}
		}
		override public function show():void  {
			trace("Showing -- " + this.getName());
			this.bShowing = true;
			var panelTween:Tween;
			var nDuration:Number = .3;
			var nX:int;
			var newX:int;
			var nY:int;
			var newY:int;
			
			if(this.bTweenEnabled)  {
				switch(this.sDirection)  {
					case "vertical":
						nX = this.nOrigX;
						newX = this.nVisibleX;
						panelTween = new Tween(this, "x", Linear.easeOut, nX, newX, nDuration, true);
						break;
					case "horizontal":
						nY = this.nOrigY;
						newY = this.nVisibleY;
						panelTween = new Tween(this, "y", Linear.easeOut, nY, newY, nDuration, true);
						break;
				}
				this.bTweenEnabled = false;
				panelTween.addEventListener(TweenEvent.MOTION_FINISH, this.onTweenComplete);
			}
			
		}
		override public function hide():void  {
			trace("Hiding -- " + this.getName());
			this.bShowing = false;
			var panelTween:Tween;
			var nDuration:Number = .2;
			var nX:int;
			var newX:int;
			var nY:int;
			var newY:int;
			
			if(this.bTweenEnabled)  {
				switch(this.sDirection)  {
					case "vertical":
						nX = this.nVisibleX;
						newX = this.nOrigX;
						panelTween = new Tween(this, "x", Linear.easeOut, nX, newX, nDuration, true);
						break;
					case "horizontal":
						nY = this.nVisibleY;
						newY = this.nOrigY;
						panelTween = new Tween(this, "y", Linear.easeOut, nY, newY, nDuration, true);
						break;
				}
				this.bTweenEnabled = false;
				panelTween.addEventListener(TweenEvent.MOTION_FINISH, this.onTweenComplete);
			}
		}
		public function onTweenComplete(e:TweenEvent):void  {
			trace("onTweenComplete()");
			this.bTweenEnabled = true;
		}
	}
}