package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class RelatedFileEvent extends CairngormEvent
	{
		public static const LIST_RELATED_FILES:String = "listRelatedFiles";
		
		public function RelatedFileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}