package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ModerationsEvent extends CairngormEvent
	{
		public static const HANDLE_MODERATION : String = "handleModeration";
		public static const UPDATE_ENTRY_MODERATION : String = "updateEntryModeration";
		
		public static const APPROVE:int = 1;
		public static const REJECT:int = 2;
		
		private var _moderationType : uint;
		private var _entries : Array;
		
		public function ModerationsEvent(type:String, moderationType : uint ,entries:Array ,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_moderationType = moderationType;
			_entries = entries;
		}
		
		public function get moderationType():uint
		{
			return _moderationType;
		}

		public function get entries():Array
		{
			return _entries;
		}


	}
}