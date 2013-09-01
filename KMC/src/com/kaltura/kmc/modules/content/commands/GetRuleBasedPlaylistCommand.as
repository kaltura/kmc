package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.RuleBasedTypeEvent;
	import com.kaltura.commands.playlist.PlaylistExecuteFromFilters;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.utils.KTimeUtil;
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.rpc.IResponder;
	import com.kaltura.kmc.modules.content.events.KMCEntryEvent;

	public class GetRuleBasedPlaylistCommand extends KalturaCommand implements ICommand, IResponder
	{
		private var _currentPlaylist : KalturaPlaylist;
		
		override public function execute(event:CairngormEvent):void
		{	
			_model.increaseLoadCounter();
 			var e : KMCEntryEvent = event as KMCEntryEvent;
			_currentPlaylist = e.entryVo as KalturaPlaylist;
			if(_currentPlaylist.totalResults == int.MIN_VALUE)
				_currentPlaylist.totalResults = 50; // Ariel definition - up to 50 per playlist 
			var playlistGet:PlaylistExecuteFromFilters = new PlaylistExecuteFromFilters(_currentPlaylist.filters,_currentPlaylist.totalResults);
			playlistGet.addEventListener(KalturaEvent.COMPLETE, result);
			playlistGet.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(playlistGet);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			//if this is a playlist - and not one rule - update duration and amount of entries
			if (_model.playlistModel.rulePlaylistType == RuleBasedTypeEvent.MULTY_RULES) {
				var totalDuration:Number = 0;
				var nEntries:uint;
				if (data.data is Array && (data.data as Array).length > 0) {
					var l:int = data.data.length; 
					for (nEntries=0; nEntries<l; nEntries++) {
						if(data.data[nEntries].hasOwnProperty("duration"))
							totalDuration += data.data[nEntries]["duration"];	
					}
				}
				_model.playlistModel.ruleBasedDuration = KTimeUtil.formatTime2(totalDuration);
				_model.playlistModel.ruleBasedEntriesAmount = nEntries;
			}
			
 			if(data.data is Array && _currentPlaylist.parts) {
				//TODO this is not a nice implementation :( 
				_currentPlaylist.parts.source = data.data;
				_currentPlaylist.parts = null;
				// sum all entries duration 
				_currentPlaylist = null;
			} 
		}
	}
}