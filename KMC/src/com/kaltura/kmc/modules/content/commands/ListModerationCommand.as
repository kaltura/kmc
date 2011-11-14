package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.media.MediaListFlags;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaModerationFlag;
	import com.kaltura.vo.KalturaModerationFlagListResponse;
	
	import mx.rpc.IResponder;
	import com.kaltura.kmc.modules.content.events.KMCEntryEvent;

	public class ListModerationCommand extends KalturaCommand implements ICommand, IResponder
	{
		private var _currentEntry : KalturaBaseEntry;
		override public function execute(event:CairngormEvent):void
		{
			var e : KMCEntryEvent = event as KMCEntryEvent;
			_currentEntry = e.entryVo;
			var pg:KalturaFilterPager = new KalturaFilterPager();
			pg.pageSize = 500;
			pg.pageIndex = 0;
			var mlf:MediaListFlags= new MediaListFlags(_currentEntry.id,pg);
		 	mlf.addEventListener(KalturaEvent.COMPLETE, result);
			mlf.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mlf);
		}
		
		override public function result(data:Object):void
		{
			var kmflr:KalturaModerationFlagListResponse;
			var kmf:KalturaModerationFlag;
			_model.moderationModel.moderationsArray.source = data.data.objects as Array;
		}
	}
}