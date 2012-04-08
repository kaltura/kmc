package com.kaltura.edw.components.fltr.cat.data
{
	import com.kaltura.edw.control.CategoriesTreeController;
	import com.kaltura.edw.control.events.CategoriesTreeEvent;
	import com.kaltura.edw.vo.CategoryVO;

	public class CompleteDataManager implements ICategoriesDataManger {
		
		
		private var _controller:CategoriesTreeController;
		
		public function get controller():CategoriesTreeController
		{
			return _controller;
		}
		
		public function set controller(value:CategoriesTreeController):void
		{
			_controller = value;
		}
		
		public function CompleteDataManager() {	}
		
		
		/**
		 * load all categories list 
		 */
		public function loadInitialData():void {
			reloadAllCategories();
		}
		
		
		/**
		 * do nothing, this is the default tree behaviour
		 * @param cat
		 * 
		 */
		public function branchClicked(cat:CategoryVO):void {
			
		}
		
		
		/**
		 * load all categories list 
		 */
		public function resetData():void {
			reloadAllCategories();
		}
		
		
		private function reloadAllCategories():void {
			var cte:CategoriesTreeEvent = new CategoriesTreeEvent(CategoriesTreeEvent.FLUSH_CATEGORIES);
			_controller.dispatch(cte);
			cte = new CategoriesTreeEvent(CategoriesTreeEvent.CREATE_ROOT_CATEGORY);
			_controller.dispatch(cte);
			cte = new CategoriesTreeEvent(CategoriesTreeEvent.LIST_ALL_CATEGORIES);
			_controller.dispatch(cte);
		} 
	}
}