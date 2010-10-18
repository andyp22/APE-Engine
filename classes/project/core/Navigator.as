/*
 * classes.project.core.Navigator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.core  {
	
	import classes.project.core.State;
	import classes.project.model.structure.*;
	import classes.project.views.ClipMediator;
	
	
	public class Navigator  {
		private static var instance:Navigator;
		private static var bInit:Boolean = true;
		
		private static var _mediator:ClipMediator;
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Navigator  {
			if(instance == null)  {
				instance = new Navigator();			}
			return instance;
		}
		public function Navigator():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				trace("Navigator initializing...");
				bInit = false;
				
			} else  {
				trace("Navigator has already been initialized.");
			}
		}
		
		public static function setClipController(m:ClipMediator):void  {
			_mediator = m;
		}
		
		public static function getStartIndex():Number  {
			// TODO: should get this from resumeData when implemented
			var nIndex:Number = 0;
			
			return nIndex;
		}
		
		public static function getNext():Number  {
			[Inject] var currentIndex:Number = State.nAbsoluteIndex;
			
			var nNextIndex:Number = currentIndex + 1;
			if(Structure.getSegmentByIndex(nNextIndex) != null)  {
				currentIndex = nNextIndex;
			}
			return currentIndex;
		}
		public static function getBack():Number  {
			[Inject] var currentIndex:Number = State.nAbsoluteIndex;
			if(currentIndex <= 0)  {
				return 0;
			}
			
			var nBackIndex:Number = currentIndex - 1;
			if(Structure.getSegmentByIndex(nBackIndex) != null)  {
				currentIndex = nBackIndex;
			}
			return currentIndex;
		}
		
		public static function updateClipView():void  {
			_mediator.updateView();
		}
		
		public static function onClipLoaded():void  {
			_mediator.startSegment();
		}
		
		
	}
}