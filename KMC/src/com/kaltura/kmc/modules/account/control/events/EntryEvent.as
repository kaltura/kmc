package com.kaltura.kmc.modules.account.control.events {
	import com.adobe.cairngorm.control.CairngormEvent;

	public class EntryEvent extends CairngormEvent {

		/**
		 * get the entry that is set as default for the current conversion profile.
		 * event.data should be entry id
		 */
		public static const GET_DEFAULT_ENTRY:String = "account_GET_DEFAULT_ENTRY";

		/**
		 * reset the default entry on the model (when switching bewtween profiles)
		 */
		public static const RESET_DEFAULT_ENTRY:String = "account_RESET_DEFAULT_ENTRY";


		public function EntryEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}