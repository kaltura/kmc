package com.kaltura.kmc.modules.content.commands.bulk
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.bulkUpload.BulkUploadAdd;
	import com.kaltura.commands.category.CategoryAddFromBulkUpload;
	import com.kaltura.commands.categoryUser.CategoryUserAddFromBulkUpload;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.business.FileManager;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.BulkEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaBulkUpload;
	import com.kaltura.vo.KalturaBulkUploadCategoryData;
	import com.kaltura.vo.KalturaBulkUploadCategoryUserData;
	import com.kaltura.vo.KalturaBulkUploadCsvJobData;
	
	import flash.events.Event;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	import mx.core.mx_internal;
	import mx.resources.ResourceManager;

	public class AddBulkUploadCommand extends KalturaCommand implements ICommand
	{
		override public function execute(event:CairngormEvent):void
		{
			var fr:FileReference = event.data;
			if(fr) {
				var call:KalturaCall;
				switch (event.type) {
					case BulkEvent.BULK_UPLOAD_CATEGORIES:
						call = new CategoryAddFromBulkUpload(fr, new KalturaBulkUploadCsvJobData(), new KalturaBulkUploadCategoryData());
						break;
					case BulkEvent.BULK_UPLOAD_CATEGORY_USERS:
						call = new CategoryUserAddFromBulkUpload(fr, new KalturaBulkUploadCsvJobData(), new KalturaBulkUploadCategoryUserData());
						break;
				}
				call.addEventListener(KalturaEvent.COMPLETE, result);
				call.addEventListener(KalturaEvent.FAILED, fault);
				call.queued = false;
				_model.context.kc.post(call);
			}
		}

		override public function result( data : Object ) : void
		{
			super.result(data);
			var string:String = ResourceManager.getInstance().getString('cms', 'bulk_submitted');
			var alert:Alert = Alert.show(string);
			alert.mx_internal::alertForm.mx_internal::textField.htmlText = string;
		}
	}
}