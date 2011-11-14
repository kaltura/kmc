package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.vo.ListableVo;

	public class KMCSearchEvent extends CairngormEvent {

		/**
		 * start search sequence.
		 * event data is the ListableVo to use for search.
		 * */
		public static const DO_SEARCH_ENTRIES:String = "content_doSearchEntries";

		public static const SEARCH_PLAYLIST:String = "content_searchPlaylists";


		private var _listableVo:ListableVo;

		public function KMCSearchEvent(type:String, listableVo:ListableVo, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_listableVo = listableVo;
		}


		public function get listableVo():ListableVo {
			return _listableVo;
		}
	}
}