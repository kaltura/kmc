package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class RuleBasedTypeEvent extends CairngormEvent
	{
		/**
		 * dispatch this event to raise SetPreviewTypeCommand 
		 */		
		static public const ONE_RULE:String = "content_oneRule";
		
		/**
		 * dispatch this event to raise SetPreviewTypeCommand 
		 */		
		static public const MULTY_RULES:String = "content_multyRules";
		
		public function RuleBasedTypeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}