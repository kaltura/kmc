package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.baseEntry.BaseEntryList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaBaseEntryFilter;
	import com.kaltura.vo.KalturaBaseEntryListResponse;
	import com.kaltura.vo.KalturaDocumentEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMixEntry;

	public class ListEntriesByRefidCommand extends KalturaCommand {
		
		/**
		 * @inheritDoc
		 */		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
//			var refid:String = (event as EntryEvent).entryVo.referenceId;
//			if (refid == KalturaClient.NULL_STRING) { 
//				refid = '';
//			}
			var f:KalturaBaseEntryFilter = new KalturaBaseEntryFilter();
			f.referenceIdEqual = (event as EntryEvent).entryVo.referenceId;
			var getMediaList:BaseEntryList = new BaseEntryList(f);
			getMediaList.addEventListener(KalturaEvent.COMPLETE, result);
			getMediaList.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getMediaList);	  
		}
		
		/**
		 * @inheritDoc
		 */
		override public function result(data:Object):void
		{
			super.result(data);
			var recivedData:KalturaBaseEntryListResponse = KalturaBaseEntryListResponse(data.data);
			_model.entryDetailsModel.entriesWSameRefidAsSelected = recivedData.objects;
			_model.decreaseLoadCounter();
		}
	}
}