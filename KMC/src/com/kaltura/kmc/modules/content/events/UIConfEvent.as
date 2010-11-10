package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaUiConfFilter;
	
	public class UIConfEvent extends CairngormEvent
	{
		public static const LIST_UI_CONFS : String = "listUIConfs";
		
		public var uiConfFilter:KalturaUiConfFilter;
		
		public function UIConfEvent(type:String, filterVo:KalturaUiConfFilter, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.uiConfFilter = filterVo;
		}

	}
}