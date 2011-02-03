package com.kaltura.kmc.modules.content.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.kmc.modules.content.model.states.WindowsStates;
	import com.kaltura.kmc.modules.content.vo.CategoryVO;
	import com.kaltura.kmc.modules.content.vo.EntryMetadataDataVO;
	import com.kaltura.kmc.modules.content.vo.ListableVo;
	import com.kaltura.types.KalturaTubeMogulSyndicationFeedOrderBy;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaBaseSyndicationFeedFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.IFlexDisplayObject;

	[Bindable]
	public class CmsModelLocator extends EventDispatcher implements IModelLocator {
		
		/**
		 * defines the value of the type property of the loadingFlagChanged event 
		 */		
		public static const LOADING_FLAG_CHANGED:String = "loadingFlagChanged";
		
		/**
		 * application context (ks, urls, etc)
		 * */
		public var context:Context = null;
		
		/**
		 * data that the filter requires 
		 */		
		public var filterModel:FilterModel;
		
		/**
		 * data that is used by bulk upload 
		 */		
		public var bulkUploadModel:BulkUploadModel;
		
		/**
		 * data that is used by external syndication 
		 */		
		public var extSynModel:ExtSynModel;
		
		/**
		 * data that is used by moderation tab
		 * */
		public var moderationModel:ModerationModel;
		
		/**
		 * entry details data 
		 */
		public var entryDetailsModel:EntryDetailsModel;
		
		/**
		 * data that is used by the playlist windows  
		 */		
		public var playlistModel:PlaylistModel;
		
		/**
		 * placeholder for data received via showSubtab().
		 * when putting things on this object one should make sure one doesn't override 
		 * irrelevant vars (i.e., don't change the object, add / remove attributes). 
		 * attributes of this object are lower camel cased with no underscores by convention.
		 * */
		public var attic:Object;
		
		// ------------------------------------------------------------
		// preview players opening
		// ------------------------------------------------------------

		/**
		 * call this JS function to open Playlist preview
		 */
		public var openPlaylist:String = "openPlaylist";

		/**
		 * call this JS function to open single player preview
		 */
		public var openPlayer:String = "openPlayer";
		
		/**
		 * on preview & embed, should single player embedcode be presented 
		 */		
		public var showSingleEntryEmbedCode:Boolean = true;
		/**
		 * on preview & embed, should playlist player embedcode be presented 
		 */	
		public var showPlaylistEmbedCode:Boolean = true;
		
		// ------------------------------------------------------------
		// current view
		// ------------------------------------------------------------
		
		
		/**
		 * the data being presented on the current screen,
		 * makes it easier to share data across screens 
		 * */
		public var listableVo:ListableVo;

		/**
		 * reference to application 
		 */		
		public var app:IFlexDisplayObject;

		/**
		 * check how many popups are opened.
		 * */
		public var has2OpenedPopups:Boolean = false;

		/**
		 * the selected checkboxed entries 
		 * (used in add / remove admin tags)
		 */
		public var checkedEntries:ArrayCollection = new ArrayCollection();

		/**
		 * the selected entries of the list 
		 * (used for all windows except admin tags)
		 */
		public var selectedEntries:Array = new Array();

		/**
		 * current open window (popup) 
		 */		
		public var windowState:String = WindowsStates.NONE;


		//Loading Mechanism Data
		///////////////////////////////////////////
		
		
		
		/**
		 * number of items currently loading
		 * */
		private var _loadingCounter:int = 0;
		
		
		/**
		 * increase the counter of loading items 
		 */		
		public function increaseLoadCounter():void {
			++_loadingCounter;
			if (_loadingCounter == 1) {
				entryDetailsModel.loadingFlag = true;
				dispatchEvent(new Event(CmsModelLocator.LOADING_FLAG_CHANGED));
			}
		}
		
		
		/**
		 * decrease the counter of loading items 
		 */
		public function decreaseLoadCounter():void {
			--_loadingCounter;
			if (_loadingCounter == 0) {
				entryDetailsModel.loadingFlag = false;
				dispatchEvent(new Event(CmsModelLocator.LOADING_FLAG_CHANGED));
			}
		}
		
		
		[Bindable(event="loadingFlagChanged")]
		/**
		 * is anything currently loading
		 * */
		public function get loadingFlag():Boolean {
			return _loadingCounter > 0;
		}
		///////////////////////////////////////////

		//singleton methods
		/**
		 * singleton instance 
		 */		
		private static var _instance:CmsModelLocator;


		/**
		 * singleton means of retreiving an instance of the 
		 * <code>CmsModelLocator</code> class.
		 */		
		public static function getInstance():CmsModelLocator {
			if (_instance == null) {
				_instance = new CmsModelLocator(new Enforcer());
			}
			return _instance;
		}


		/**
		 * initialize parameters and sub-models. 
		 * @param enforcer	singleton garantee
		 */		
		public function CmsModelLocator(enforcer:Enforcer) {
			context = new Context();
			attic = new Object();
			
			filterModel = new FilterModel();
			entryDetailsModel = new EntryDetailsModel();
			playlistModel = new PlaylistModel();
			moderationModel = new ModerationModel();
			
			bulkUploadModel = new BulkUploadModel();
			bulkUploadModel.bulkUploadFilterPager = new KalturaFilterPager();
			bulkUploadModel.bulkUploadFilterPager.pageSize = 10;
			
			extSynModel = new ExtSynModel();
			extSynModel.syndicationFeedsFilterPager = new KalturaFilterPager();
			extSynModel.syndicationFeedsFilterPager.pageSize = 10;
			extSynModel.syndicationFeedsFilter = new KalturaBaseSyndicationFeedFilter();
			extSynModel.syndicationFeedsFilter.orderBy = KalturaTubeMogulSyndicationFeedOrderBy.CREATED_AT_DESC;
		}


	}
}

class Enforcer {

}