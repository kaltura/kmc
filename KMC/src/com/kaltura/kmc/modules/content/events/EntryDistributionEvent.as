package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class EntryDistributionEvent extends CairngormEvent
	{
		public static const LIST:String = "content_listEntryDistribution";
		public static const UPDATE:String = "content_updateEntryDistribution";
		
		var entryDistributionArray:Array;
		
		public function EntryDistributionEvent( type:String, 
												entryDistributionArray:Array = null,
												bubbles:Boolean=false, 
												cancelable:Boolean=false)
		{
			this.entryDistributionArray = entryDistributionArray;
			super(type, bubbles, cancelable);
		}
	}
}