/**
 * classes.project.views.ReportBugMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.ReportBugView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ReportBugMediator extends Mediator  {
		
		[Inject] public var view:ReportBugView;
		
		public function ReportBugMediator()  {
			trace("Creating ReportBugMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("ReportBugMediator registered.");
			
			
		}
		
		
	}
}