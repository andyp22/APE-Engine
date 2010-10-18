/**
 * classes.project.model.ContainerPanel
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model  {
	
	import classes.project.core.Server;
	import classes.project.events.PanelEvent;
	import classes.project.model.IPanel;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ContainerPanel extends Sprite implements IPanel  {
		private var sName:String;
		private var sHeader:String;
		protected var bShowing:Boolean;
		
		protected var mcPanel:MovieClip;
		protected var mcHeader:MovieClip;
		protected var mcContent:MovieClip;
		protected var mcClose:MovieClip;
		/**
		 * Constructor
		 */
		public function ContainerPanel(sName:String, mc:MovieClip)  {
			super();
			//trace("Creating new ContainerPanel -- " + this + " : " + sName);
			
			this.sName = sName;
			
			this.mcPanel = mc;
			this.mcHeader = this.mcPanel.mcHeader;
			this.mcContent = new MovieClip();
			this.mcClose = this.mcPanel.mcExit;
			
			this.init();
			this.initClose();
			this.visible = false;
		}
		
		private function init():void  {
			//trace("ContainerPanel initializing...");
			addChild(this.mcPanel);
			
		}
		
		private function initClose():void  {
			this.mcClose.buttonMode = true;
			this.mcClose.mouseChildren = false;
			
			this.mcClose.addEventListener(MouseEvent.MOUSE_DOWN, this.handleClosePress);
			this.mcClose.addEventListener(MouseEvent.ROLL_OVER, this.handleCloseRollOver);
			this.mcClose.addEventListener(MouseEvent.ROLL_OUT, this.handleCloseRollOut);
			this.mcClose.addEventListener(MouseEvent.MOUSE_UP, this.handleCloseRelease);
			
			this.mcClose.gotoAndPlay("up");
		}
		
		public function getName():String  {
			return this.sName;
		}
		
		public function setHeader(sText:String):void  {
			this.sHeader = sText;
			this.mcHeader.tf.htmlText = this.sHeader;
		}
		
		private function handleClosePress(e:MouseEvent):void  {
			//trace("handleClosePress -- "+ e.target);
			this.mcClose.gotoAndPlay("down");
		}
		private function handleCloseRollOver(e:MouseEvent):void  {
			//trace("handleCloseRollOver -- "+ e.target);
			this.mcClose.gotoAndPlay("over");
		}
		private function handleCloseRollOut(e:MouseEvent):void  {
			//trace("handleCloseRollOut -- "+ e.target);
			this.mcClose.gotoAndPlay("out");
		}
		private function handleCloseRelease(e:MouseEvent):void  {
			trace("handleCloseRelease -- "+ e.target);
			this.mcClose.gotoAndPlay("overNoOut");
			this.hide();
		}
		
		public function show():void  {
			trace("Showing -- " + this.sName);
			this.bShowing = true;
			this.visible = true;
			[Inject] Server.dispatch(new PanelEvent(PanelEvent.PANEL_OPENED, this));
		}
		public function hide():void  {
			trace("Hiding -- " + this.sName);
			this.bShowing = false;
			this.visible = false;
			[Inject] Server.dispatch(new PanelEvent(PanelEvent.PANEL_CLOSED, this));
		}
		public function toggleView():void  {
			if(this.bShowing)  {
				this.hide();
			} else  {
				this.show();
			}
		}
		
		public function hideCloseBtn():void  {
			this.mcClose.gotoAndPlay("disabled");
			this.mcClose.enabled = false;
		}
		public function showCloseBtn():void  {
			this.mcClose.gotoAndPlay("up");
			this.mcClose.enabled = true;
		}
		
		public function isShowing():Boolean  {
			return this.bShowing;
		}
		public function setPos(nX:Number, nY:Number):void  {
			this.x = nX;
			this.y = nY;
		}
		
		public function createContentContainer(mc:DisplayObject):void  {}
		public function sizeToContents():void  {}
		public function enable():void  {}
		public function disable():void  {}
		
	}
}