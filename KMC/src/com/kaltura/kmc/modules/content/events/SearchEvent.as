package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.ListableVo;

	public class SearchEvent extends CairngormEvent
	{
		public static const SEARCH_ENTRIES : String = "searchEntries";
		public static const SEARCH_PLAYLIST : String = "searchPlaylists";
		public static const SEARCH_BULK_LOG : String = "searchBulkLog";
		
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