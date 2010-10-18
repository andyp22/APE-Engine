/**
 * classes.project.views.components.IView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	public interface IView  {
		
		function show() : void;
		function hide() : void;
		function toggleView() : void;
		function isShowing() : Boolean;
		function get id() : String;
		function endContent() : void;
		
		
	}
 }