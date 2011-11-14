package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.playlist.PlaylistList;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.edw.vo.ListableVo;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.KMCSearchEvent;
	import com.kaltura.types.KalturaPlaylistOrderBy;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMediaEntryFilterForPlaylist;
	import com.kaltura.vo.KalturaPlaylist;
	import com.kaltura.vo.KalturaPlaylistFilter;
	import com.kaltura.vo.KalturaPlaylistListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class ListPlaylistCommand extends KalturaCommand implements ICommand, IResponder {
		// Atar: I have no idea why we need this.
		KalturaMediaEntryFilterForPlaylist;

		/**
		 * External Syndication windows don't send a listableVO, playlist panel does. 
		 */		
		private var _caller:ListableVo;


		/**
		 * @inheritDoc
		 * */
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_caller = (event as KMCSearchEvent).listableVo;

			if (_caller == null) {
				var pf:KalturaPlaylistFilter = new KalturaPlaylistFilter();
				pf.orderBy = KalturaPlaylistOrderBy.CREATED_AT_DESC;
				var pg:KalturaFilterPager = new KalturaFilterPager();
				pg.pageSize = 500;
				var generalPlaylistList:PlaylistList = new PlaylistList(pf, pg);
				generalPlaylistList.addEventListener(KalturaEvent.COMPLETE, result);
				generalPlaylistList.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(generalPlaylistList);
			}
			else {
				var kpf:KalturaPlaylistFilter = KalturaPlaylistFilter(_caller.filterVo);
				var playlistList:PlaylistList = new PlaylistList(kpf as KalturaPlaylistFilter,
																 _caller.pagingComponent.kalturaFilterPager);
				playlistList.addEventListener(KalturaEvent.COMPLETE, result);
				playlistList.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(playlistList);
			}
		}


		/**
		 * @inheritDoc
		 * */
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			if (_caller == null) {
				// from ext.syn subtab
				var tempArr:ArrayCollection = new ArrayCollection();
				var playlistListResult:KalturaPlaylistListResponse = data.data as KalturaPlaylistListResponse;
				for each (var playList:KalturaPlaylist in playlistListResult.objects) {
					tempArr.addItem(playList);
				}
				_model.extSynModel.generalPlayListdata = tempArr;
			}
			else {
				// from playlists subtab
				_caller.arrayCollection = new ArrayCollection(data.data.objects);
				_caller.pagingComponent.totalCount = data.data.totalCount;

				_caller = null;
			}
		}
	}
}