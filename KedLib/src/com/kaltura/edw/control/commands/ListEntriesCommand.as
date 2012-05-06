package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.baseEntry.BaseEntryList;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.edw.vo.ListableVo;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaBaseEntryFilter;
	import com.kaltura.vo.KalturaBaseEntryListResponse;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMixEntry;
	
	import mx.collections.ArrayCollection;

	public class ListEntriesCommand extends KedCommand
	{
		private var _caller:ListableVo;
		
		/**
		 * @inheritDoc
		 */		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			_caller = (event as SearchEvent).listableVo;
			var getMediaList:BaseEntryList = new BaseEntryList(_caller.filterVo as KalturaBaseEntryFilter ,_caller.pagingComponent.kalturaFilterPager );
		 	getMediaList.addEventListener(KalturaEvent.COMPLETE, result);
			getMediaList.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(getMediaList);	  
		}

		/**
		 * @inheritDoc
		 */
		override public function result(data:Object):void
		{
			super.result(data);
			// the following variables are used to force  
			// their types to compile into the application
			var kme:KalturaMediaEntry; 
			var kbe:KalturaBaseEntry;
			var mix:KalturaMixEntry;
			var recivedData:KalturaBaseEntryListResponse = KalturaBaseEntryListResponse(data.data);
			// only use object we can handle
			var tempAr:Array = [];
			for each (var o:Object in recivedData.objects) {
				if (o is KalturaBaseEntry) {
					tempAr.push(o);
				}
			}
			_caller.arrayCollection = new ArrayCollection (tempAr);
			_caller.pagingComponent.totalCount = recivedData.totalCount;
			_model.decreaseLoadCounter();
		}
		
	}
}