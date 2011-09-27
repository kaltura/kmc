package com.kaltura.edw.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.vo.ListableVo;

	public class SearchEvent extends CairngormEvent
	{
		public static const SEARCH_ENTRIES : String = "content_searchEntries";
		public static const SEARCH_PLAYLIST : String = "content_searchPlaylists";
		public static const SEARCH_BULK_LOG : String = "content_searchBulkLog";
		
		private var _listableVo : ListableVo;
		
		public function SearchEvent( type:String , 
									 listableVo:ListableVo,
									 bubbles:Boolean=false,
									 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_listableVo = listableVo;
		}

		public function get listableVo():ListableVo
		{
			return _listableVo;
		}

	}
}