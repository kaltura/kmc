package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.kmc.modules.content.vo.PlaylistWrapper;
	import com.kaltura.commands.playlist.PlaylistExecute;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class GetPlaylistCommand extends KalturaCommand implements ICommand, IResponder
	{
		private var _currentPlaylist : KalturaPlaylist;
		//private var _wrapper : PlaylistWrapper;
		override public function execute(event:CairngormEvent):void
		{	
			_model.increaseLoadCounter();
 			var e : EntryEvent = event as EntryEvent;
			_currentPlaylist = e.entryVo as KalturaPlaylist;
			var playlistGet:PlaylistExecute = new PlaylistExecute(_currentPlaylist.id);
			playlistGet.addEventListener(KalturaEvent.COMPLETE, result);
			playlistGet.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(playlistGet);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			if(data.data is Array)
			{
				//this is not a nice implementation :( todo - fix this
				_currentPlaylist.parts.source = data.data;
				//_wrapper = null;
				_currentPlaylist.parts = null;
				//_currentPlaylist.
/* 				_currentPlaylist.playlistEntriesNum = (data as PlaylistVO).playlistEntriesNum;
				_currentPlaylist.playlistWidth = (data as PlaylistVO).playlistWidth;
				_currentPlaylist.playlistHieght= (data as PlaylistVO).playlistHieght;
				_currentPlaylist.embedText = (data as PlaylistVO).embedText;
				_currentPlaylist.datacontent = (data as PlaylistVO).datacontent;
				_currentPlaylist.dynamicFilters = (data as PlaylistVO).dynamicFilters; */
			}
		}
	}
}