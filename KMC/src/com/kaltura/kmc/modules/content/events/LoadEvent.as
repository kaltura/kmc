package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.business.IDataOwner;
	
	public class LoadEvent extends CairngormEvent {
		
		public static const LOAD_FILTER_DATA : String = "content_loadFilterData";
		public static const LOAD_ENTRY_DATA : String = "content_loadEntryData";
		
		private var _caller : IDataOwner;
		private var _entryId:String;
		
		public function LoadEvent(type:String, owner:IDataOwner, entryid:String = '', bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_caller = owner;
			_entryId = entryid;
		}
		
		/**
		 * the component who triggered this data load 
		 */
		public function get caller():IDataOwner
		{
			return _caller;
		}

		/**
		 * on entry data load, the id of the entry in question. 
		 */		
		public function get entryId():String
		{
			return _entryId;
		}

	}
}