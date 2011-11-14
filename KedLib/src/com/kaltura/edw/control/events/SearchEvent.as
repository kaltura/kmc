package com.kaltura.edw.control.events
{
	import com.kaltura.edw.vo.ListableVo;
	import com.kaltura.kmvc.control.KMvCEvent;

	public class SearchEvent extends KMvCEvent
	{
		
		
		public static const SEARCH_ENTRIES : String = "content_searchEntries";
		
		
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