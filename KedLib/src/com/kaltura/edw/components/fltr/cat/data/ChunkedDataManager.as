package com.kaltura.edw.components.fltr.cat.data
{
	import com.kaltura.edw.components.fltr.cat.events.CategoriesDataManagerEvent;
	import com.kaltura.edw.control.CategoriesTreeController;
	import com.kaltura.edw.control.events.CategoriesTreeEvent;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.vo.CategoryVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ChunkedDataManager extends EventDispatcher implements ICategoriesDataManger {
		
		
		private var _controller:CategoriesTreeController;

		public function get controller():CategoriesTreeController
		{
			return _controller;
		}

		public function set controller(value:CategoriesTreeController):void
		{
			_controller = value;
			var cte:CategoriesTreeEvent = new CategoriesTreeEvent(CategoriesTreeEvent.SET_CATEGORIES_DATA_MANAGER_TO_MODEL);
			cte.data = this;
			_controller.dispatch(cte);
		}
		
		
		public function ChunkedDataManager() {
		}
		
		
		/**
		 * load first level categories 
		 */
		public function loadInitialData():void {
			// initialy, flush old data
			var cte:CategoriesTreeEvent = new CategoriesTreeEvent(CategoriesTreeEvent.FLUSH_CATEGORIES);
			_controller.dispatch(cte);
			
			// then create the root
			cte = new CategoriesTreeEvent(CategoriesTreeEvent.CREATE_ROOT_CATEGORY);
			_controller.dispatch(cte);
			
			// then load root's children
			cte = new CategoriesTreeEvent(CategoriesTreeEvent.LIST_CATEGORIES_UNDER);
			_controller.dispatch(cte);
		}
		
		/**
		 * fetch children under this branch if needed
		 * */
		public function branchClicked(cat:CategoryVO):void {
			if (cat.children.length == 0) {
				// only list children if we don't yet have them
				var cte:CategoriesTreeEvent = new CategoriesTreeEvent(CategoriesTreeEvent.LIST_CATEGORIES_UNDER);
				cte.data = cat;
				cte.source = this;
				cte.onComplete = reopenBranch;
				_controller.dispatch(cte);
			}
		}
		
		
		/**
		 * flush exiting data and get root's children
		 * 
		 */
		public function resetData():void {
			loadInitialData();
		}
		
		
		
		private function reopenBranch(item:CategoryVO):void {
			dispatchEvent(new CategoriesDataManagerEvent(CategoriesDataManagerEvent.REOPEN_BRANCH, item));
		}
	}
}