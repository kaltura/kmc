package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.SearchEvent;
	import com.kaltura.kmc.modules.content.view.window.ManualPlaylistWindow;
	import com.kaltura.kmc.modules.content.vo.ListableVo;
	import com.kaltura.commands.baseEntry.BaseEntryList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaBaseEntryListResponse;
	import com.kaltura.vo.KalturaDocumentEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	import com.kaltura.vo.KalturaMixEntry;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class ListEntriesCommand extends KalturaCommand implements ICommand,IResponder
	{
		private var _caller:ListableVo;
		
		/**
		 * @inheritDoc
		 */		
		override public function execute(event:CairngormEvent):void
		{
			 _model.increaseLoadCounter();
			 
			_caller = (event as SearchEvent).listableVo;
			var getMediaList:BaseEntryList = new BaseEntryList(_caller.filterVo as KalturaMediaEntryFilter ,_caller.pagingComponent.kalturaFilterPager );
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
			// the following variables are used to force  
			// their types to compile into the application
			var kme:KalturaMediaEntry; 
			var kbe:KalturaBaseEntry;
			var mix:KalturaMixEntry;
			var kde:KalturaDocumentEntry;
			var recivedData:KalturaBaseEntryListResponse = KalturaBaseEntryListResponse(data.data);
			
			if (!(_caller.parentCaller is ManualPlaylistWindow))
			{
				_model.selectedEntries = new Array();
			}
			_caller.arrayCollection = new ArrayCollection (recivedData.objects);
			_model.entryDetailsModel.totalEntriesCount = recivedData.totalCount;
			_caller.pagingComponent.totalCount = recivedData.totalCount;
			_model.refreshEntriesRequired = false;
			_model.decreaseLoadCounter();
		}
		
	}
}