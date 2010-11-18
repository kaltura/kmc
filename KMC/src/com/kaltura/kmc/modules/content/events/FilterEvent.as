package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaMediaEntryFilterForPlaylist;

	public class FilterEvent extends CairngormEvent
	{
		public static const SET_FILTER_TO_MODEL : String = "content_setFilterToModel";
		
		private var _filterVo : KalturaMediaEntryFilterForPlaylist;
		
		public function FilterEvent(type:String, filterVo : KalturaMediaEntryFilterForPlaylist, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_filterVo = filterVo;
		}

		public function get filterVo():KalturaMediaEntryFilterForPlaylist
		{
			return _filterVo;
		}

	}
}