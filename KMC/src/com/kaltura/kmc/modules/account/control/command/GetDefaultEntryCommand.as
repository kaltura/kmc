package com.kaltura.kmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryGet;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetDefaultEntryCommand implements ICommand, IResponder {

		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var beg:BaseEntryGet = new BaseEntryGet(event.data);
			beg.addEventListener(KalturaEvent.COMPLETE, result);
			beg.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(beg);
		}


		public function result(data:Object):void {
			_model.loadingFlag = false;

			if (data.success) {
				// continue save process
				_model.defaultEntry = data.data as KalturaBaseEntry;
			}
			else {
				fault(data);
			}

		}


		public function fault(event:Object):void {
			_model.loadingFlag = false;
			Alert.show(ResourceManager.getInstance().getString('account', 'entryDontExist'),
				ResourceManager.getInstance().getString('account', 'error'));
		}

	}
}