package com.kaltura.kmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListCategoriesCommand implements ICommand, IResponder {

		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			var filter:KalturaCategoryFilter = new KalturaCategoryFilter();
			filter.privacyContextEqual = "*";	
			var list:CategoryList = new CategoryList(filter);
			list.addEventListener(KalturaEvent.COMPLETE, result);
			list.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(list);
		}


		public function result(data:Object):void {
			var listResult:KalturaCategoryListResponse = data.data as KalturaCategoryListResponse;
			if (!listResult.objects || listResult.objects.length == 0) {
				var n_a:String = ResourceManager.getInstance().getString('account', 'n_a');
				var dummy:KalturaCategory = new KalturaCategory();
				dummy.name = n_a;
				dummy.privacyContext = n_a;
				dummy.disabled = true;	// will later use this value to disable actions in IR
				_model.categoriesWithPrivacyContext = [dummy];
			} 
			else {
				_model.categoriesWithPrivacyContext = listResult.objects;
			}
		}


		/**
		 * This function handles errors from the server
		 * @param info the error from the server
		 *
		 */
		public function fault(info:Object):void {
			if (info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
				JSGate.expired();
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));

		}
	}
}
