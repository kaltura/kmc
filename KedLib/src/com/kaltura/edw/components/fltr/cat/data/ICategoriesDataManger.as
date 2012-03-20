package com.kaltura.edw.components.fltr.cat.data
{
	import com.kaltura.edw.control.CategoriesTreeController;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.vo.CategoryVO;
	

	public interface ICategoriesDataManger {
		
		/**
		 * load the data that is intialy shown on the tree 
		 */
		function loadInitialData():void;
		
		/**
		 * handle click on a branch 
		 * @param cat the branch that was clicked
		 */		
		function branchClicked(cat:CategoryVO):void;
		
		/**
		 * get the data that is shown on the tree after
		 * a category is moved 
		 */
		function resetData():void;
		
		
		/**
		 * set the controller 
		 * @param value controller for API calls
		 */
		function get controller():CategoriesTreeController;
		
		function set controller(value:CategoriesTreeController):void;
	}
}