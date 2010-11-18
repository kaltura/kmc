package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaFilterPager;
	
	public class SetSyndicationPagerEvent extends CairngormEvent {
		
		public static const SET_PAGER:String = "content_setPager";
		
		private var _pager:KalturaFilterPager;
		
		public function SetSyndicationPagerEvent(type:String, pager:KalturaFilterPager = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_pager = pager;
			super(type, bubbles, cancelable);
		}

		public function get pager():KalturaFilterPager
		{
			return _pager;
		}

	}
}