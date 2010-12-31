/**
 * classes.project.model.Tooltips
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model  {
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.model.BaseProfile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	
	public class Tooltips  {
		private static var instance:Tooltips;
		[Inject] private static var _profile:BaseProfile;
		
		private static var _mcHolder:Sprite;
		private static var _mcTip:MovieClip;
		private static var _showing:Boolean = false;
		
		private static var _sOrient:String = "top";
		
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Tooltips  {
			if(instance == null)  {
				instance = new Tooltips();			}
			return instance;
		}
		public function Tooltips():void  {
			this.init();
		}
		private function init():void  {
			trace("Tooltips initializing...");
			
			[Inject] _profile = BaseProfile(Configs.profiles.getProfile("Tooltips"));
			
			_mcHolder = new Sprite();
			_mcHolder.x = 0;
			_mcHolder.y = 0;
			
			if(_profile.config["sOrient"] != undefined)  {
				_sOrient = _profile.config["sOrient"];
			}
		}
		public static function getHolder():Sprite  {
			return _mcHolder;
		}
		
		public static function create(e:MouseEvent, profile:String = "") {
			if(profile != "")  {
				[Inject] _profile = BaseProfile(Configs.profiles.getProfile(profile));
				if(_profile.config["sOrient"] != undefined)  {
					_sOrient = _profile.config["sOrient"];
				}
			}
			
			var sSkin:String = _profile.config["sSkin"];
			
			var xPos:Number = e.stageX - e.localX;
			var yPos:Number = e.stageY - e.localY;
			
			_mcTip = LibFactory.createMovieClip(sSkin);
			
			initText(e.currentTarget.getTooltipText());
			initPosition(xPos, yPos, e.currentTarget);
			
			_showing = true;
			_mcHolder.addChild(_mcTip);
		}
		private static function initText(sText:String):void  {
			_mcTip.mcText.tf.autoSize = TextFieldAutoSize.CENTER;
			_mcTip.mcText.tf.htmlText = sText;
			
			var newWidth:Number = _mcTip.mcText.tf.textWidth + 10;
			var newHeight:Number = _mcTip.mcText.tf.textHeight + 5;
			_mcTip.mcText.width = newWidth;
			_mcTip.mcBg.width = newWidth + 5;
			_mcTip.mcBg.height = newHeight;
		}
		private static function initPosition(nX:Number, nY:Number, target:Object):void  {
			switch(_sOrient)  {
				case "top":
					_mcTip.x = nX + (target.width/2 - _mcTip.width/2);
					_mcTip.y = nY - (_mcTip.height + 2);
					break;
				case "bottom":
					_mcTip.x = nX + (target.width/2 - _mcTip.width/2);
					_mcTip.y = nY + (target.height + 2);
					break;
				case "left":
					_mcTip.x = nX - (_mcTip.width + 2);
					_mcTip.y = nY + (target.height/2 - _mcTip.height/2);
					break;
				case "right":
					_mcTip.x = nX + (target.width + 2);
					_mcTip.y = nY + (target.height/2 - _mcTip.height/2);
					break;
			}
		}
		public static function destroy() {
			if(_showing)  {
				_mcHolder.removeChild(_mcTip);
				_showing = false;
			}
			[Inject] _profile = BaseProfile(Configs.profiles.getProfile("Tooltips"));
			if(_profile.config["sOrient"] != undefined)  {
				_sOrient = _profile.config["sOrient"];
			}
		}
		
		
	}
}