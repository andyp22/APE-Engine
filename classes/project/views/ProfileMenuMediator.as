/**
 * classes.project.views.ProfileMenuMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	
	import classes.project.events.TabControlEvent;
	import classes.project.views.components.ProfileMenuView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ProfileMenuMediator extends Mediator  {
		
		[Inject] public var view:ProfileMenuView;
		
		public function ProfileMenuMediator()  {
			trace("Creating ProfileMenuMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("ProfileMenuMediator registered.");
			
			eventMap.mapListener(eventDispatcher, TabControlEvent.TAB_CONTROL_PRESSED, toggleTab);
		}
		
		private function toggleTab(e:TabControlEvent):void  {
			trace("toggleTab()"+ e._tab.getName());
			view.updateTabs(e._tab.getName());
			view.hideOverlays();
			view.showOverlay(e._tab.getName());
			
		}
		
		
	}
}