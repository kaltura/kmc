package com.kaltura.kmc.modules.account.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.events.IntegrationEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class UpdateCategoryCommand implements ICommand, IResponder {

		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var kCat:KalturaCategory = event.data as KalturaCategory;
			kCat.setUpdatedFieldsOnly(true);
			var update:CategoryUpdate = new CategoryUpdate(kCat.id, kCat);
			update.addEventListener(KalturaEvent.COMPLETE, result);
			update.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(update);
		}


		public function result(data:Object):void {
			var event:KalturaEvent = data as KalturaEvent;
			_model.loadingFlag = false;
			if (event.success) {
				// list categories with context again
				var list:IntegrationEvent = new IntegrationEvent(IntegrationEvent.LIST_CATEGORIES_WITH_PRIVACY_CONTEXT);
				list.dispatch();
			}
			else {
				Alert.show((data as KalturaEvent).error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			}

		}


		public function fault(info:Object):void {
			if (info && info.error && info.error.errorMsg) {
				
			 	if (info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
					JSGate.expired();
					return;
				}
				else {
					Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));	
				}
			}
			_model.loadingFlag = false;
		}

	}
}
