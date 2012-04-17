package com.kaltura.kmc.modules.content.view.window.cdw
{
	import com.kaltura.kmc.modules.content.model.CategoriesModel;

	public interface ICategoryDrilldownPanel {
		
		
		/**
		 * the panel will see if the info it holds is valid for saving. When 
		 * validation process is complete, the panel will dispatch a validation 
		 * event with the result.
		 */
		function validate():void;
		
		/**
		 * the panel will save its data. When save is complete, panel informs the 
		 * main app by dispatching "saved" event. 
		 * panles that only manipulate data on selectedEntry don't need to save, 
		 * and should dispatch the "saved" event right away. 
		 */
		function save():void;
		
		/**
		 * will be triggered when the panel is no longer needed (window is 
		 * destroyed). The panel will kill all listeners and bindings. 
		 */
		function destroy():void;
		
		
		/**
		 * will be triggered before changing selected entry. 
		 * The panel will remove any listeners to the selectedEntry,  
		 * and perform any other required cleaning actions. 
		 */
		function clear():void;
		
		/**
		 * the panel will load any data it requires from the server. 
		 * Panel that does not require extra data (other than selectedEntry) 
		 * can leave the implementation empty. Will be triggered after 
		 * the new selectedEntry is set.
		 * 
		 * (currently: will dispatch the panel's necessary events in order to load required data)
		 */		
		function initData():void;
		
		/**
		 * one time initialization actions (the opposite of destoy()). 
		 * In this method the panel will create the attributes it requires on 
		 * the model (reachable as a singleton) and create the controller. 
		 */		
		function init():void;
		
		/**
		 * whether save action is required 
		 * @return 
		 */
		function isChanged():Boolean;
	}
}