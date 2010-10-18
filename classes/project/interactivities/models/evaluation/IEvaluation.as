/**
 * classes.project.interactivities.models.evaluation.IEvaluation
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.models.evaluation  {
	
	public interface IEvaluation  {
		
		function setupEvaluator(oArgs:Object):void;
		function doEvaluation():void;
		function getCorrectDraggers():Array;
		function getIncorrectDraggers():Array;
		function allCorrect():Boolean;
		
		
	}
}