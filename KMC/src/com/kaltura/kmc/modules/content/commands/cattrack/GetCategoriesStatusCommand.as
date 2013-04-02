package com.kaltura.kmc.modules.content.commands.cattrack
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.partner.PartnerListFeatureStatus;
	import com.kaltura.edw.business.KedJSGate;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.types.KalturaFeatureStatusType;
	import com.kaltura.vo.KalturaFeatureStatus;
	import com.kaltura.vo.KalturaFeatureStatusListResponse;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class GetCategoriesStatusCommand extends KalturaCommand {
		
		
		override public function execute(event:CairngormEvent):void {
			var mr:PartnerListFeatureStatus = new PartnerListFeatureStatus();
			mr.useTimeout = false; // if a TO is encountered, it lowers the loadCounter below 0.
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
			
		}
		
		override public function result(data:Object):void {
			var isErr:Boolean = checkError(data);
			if (!isErr) {
				var dsp:EventDispatcher = new EventDispatcher();
				var kfslr:KalturaFeatureStatusListResponse = data.data as KalturaFeatureStatusListResponse;
				var lockFlagFound:Boolean;
				var updateFlagFound:Boolean;
				var updateEntsFlagFound:Boolean;
				for each (var kfs:KalturaFeatureStatus in kfslr.objects) {
					switch (kfs.type) {
						case KalturaFeatureStatusType.LOCK_CATEGORY:
							lockFlagFound = true;
							updateFlagFound = true;
							break;
						case KalturaFeatureStatusType.CATEGORY:
							updateFlagFound = true;
							break;
					}
				}
				
				// lock flag
				if (lockFlagFound) {
					_model.filterModel.setCatLockFlag(true);
				}
				else  {
					_model.filterModel.setCatLockFlag(false);
				}
				
				// update flag
				if (updateFlagFound) {
					_model.filterModel.setCatUpdateFlag(true);
				}
				else {
					_model.filterModel.setCatUpdateFlag(false);
				}
				
				
			}
		}
		
		override public function fault(info:Object):void {
			if (!info || !(info is KalturaEvent)) return;
			
			var er:KalturaError = (info as KalturaEvent).error;
			if (!er) return;
			
			trace("GetCategoriesStatusCommand.fault:", er.errorCode);
			if (er.errorCode == APIErrorCode.INVALID_KS) {
				KedJSGate.expired();
			}
			else if (er.errorCode == APIErrorCode.SERVICE_FORBIDDEN) {
				KedJSGate.expired();
			}
			else if (er.errorMsg) {
				// only show error messages if they are "real errors" 
				// (for some reason, sometimes this call fails, in this  
				// case we get a flash error which we don't want to show)
				if (er.errorMsg != 'Error #2032') {
					var alert:Alert = Alert.show(er.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
				}
			}
		}
	}
}