package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.playlist.PlaylistExecute;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.KMCEntryEvent;
	import com.kaltura.vo.KalturaPlaylist;

	public class GetPlaylistCommand extends KalturaCommand {
		private var _currentPlaylist:KalturaPlaylist;


		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var e:KMCEntryEvent = event as KMCEntryEvent;
			_currentPlaylist = e.entryVo as KalturaPlaylist;
			var playlistGet:PlaylistExecute = new PlaylistExecute(_currentPlaylist.id);
			playlistGet.addEventListener(KalturaEvent.COMPLETE, result);
			playlistGet.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(playlistGet);
		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			if (data.data is Array) {
				//this is not a nice implementation :( todo - fix this
				_currentPlaylist.parts.source = data.data;
				_currentPlaylist.parts = null;
			}
		}
	}
}