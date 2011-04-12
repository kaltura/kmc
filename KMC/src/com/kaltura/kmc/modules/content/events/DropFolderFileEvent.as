package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaAssetsParamsResourceContainers;
	import com.kaltura.vo.KalturaBaseEntry;

	public class DropFolderFileEvent extends CairngormEvent {

		public static const MATCH_SLUG:String = "match_slug";
		public static const LIST_ALL:String = "list_all";
		public static const LIST_BY_SELECTED_FOLDER:String = "list_by_selected_folder";

		private var _entry:KalturaBaseEntry;
		private var _slug:String;
		private var _resources:KalturaAssetsParamsResourceContainers;


		public function DropFolderFileEvent(type:String, entry:KalturaBaseEntry=null, slug:String=null, resources:KalturaAssetsParamsResourceContainers=null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_entry = entry;
			_slug = slug;
			_resources = resources;
		}


		public function get entry():KalturaBaseEntry {
			return _entry;
		}


		public function get slug():String {
			return _slug;
		}


		public function get resources():KalturaAssetsParamsResourceContainers {
			return _resources;
		}


	}
}