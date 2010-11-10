package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class RuleBasedTypeEvent extends CairngormEvent
	{
		static public const ONE_RULE:String = "oneRule";
		static public const MULTY_RULES:String = "multyRules";
		
		public function RuleBasedTypeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}