package com.kaltura.kmc.modules.content.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.PlaylistModel;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.edw.vo.ListableVo;
	import com.kaltura.kmvc.model.KMvCModel;
	import com.kaltura.types.KalturaTubeMogulSyndicationFeedOrderBy;
	import com.kaltura.vo.KalturaBaseSyndicationFeedFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.TitleWindow;
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
		public var context:ContextDataPack;
		
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
		 * entry details model
		 * */
		public var entryDetailsModel:KMvCModel;
		
		
		/**
		 * list of opened popups 
		 */
		public var popups:Vector.<TitleWindow>;
		
		/**
		 * returns the last popup added to the app 
		 */
		public function get topPopup():TitleWindow {
			if (popups.length > 0) {
				return popups[popups.length-1];
			}
			return null;
		}
		
		/**
		 * returns the one before last popup added to the app 
		 */
		public function get prevPopup():TitleWindow {
			if (popups.length > 1) {
				return popups[popups.length-2];
			}
			return null;
		}
		
		/**
		 * entries list should be re-loaded after closing drilldown (some entry was updated).
		 * */
		public var refreshEntriesRequired:Boolean = false;
		
		/**
		 * data that is used by the playlist windows  
		 */		
		public var playlistModel:PlaylistModel;
		
		/**
		 * data that is used by the playlist windows  
		 */		
		public var dropFolderModel:DropFolderModel;
		
		/**
		 * data that is used by the categories screen  
		 */		
		public var categoriesModel:CategoriesModel;
		
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
		 * the total number of entries returned from the last (entries) list action 
		 */
		public var totalEntriesCount:int = 0;

		/**
		 * reference to application 
		 */		
		public var app:IFlexDisplayObject;

		/**
		 * check how many popups are opened.
		 * */
		public var has2OpenedPopups:Boolean = false;

		/**
		 * the selected entries of the list 
		 * (used for all windows except admin tags)
		 */
		public var selectedEntries:Array = new Array();
		
		
		/**
		 * all the categories to which the selected entries are assigned (||, not &&) 
		 */
		public var selectedEntriesCategories:ArrayCollection;

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
//				for each (var edm:EntryDetailsModel in entryDetailsModelsArray) {
//					edm.loadingFlag = true;
//				}
				dispatchEvent(new Event(CmsModelLocator.LOADING_FLAG_CHANGED));
			}
		}
		
		
		/**
		 * decrease the counter of loading items 
		 */
		public function decreaseLoadCounter():void {
			--_loadingCounter;
			if (_loadingCounter == 0) {
//				for each (var edm:EntryDetailsModel in entryDetailsModelsArray) {
//					edm.loadingFlag = false;
//				}
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
			attic = new Object();
			
			entryDetailsModel = KMvCModel.getInstance();
			
			context = entryDetailsModel.getDataPack(ContextDataPack) as ContextDataPack;
			
			filterModel = new FilterModel();
			var fdp:FilterDataPack = new FilterDataPack();
			fdp.filterModel = filterModel;
			entryDetailsModel.setDataPack(fdp);
			
			popups = new Vector.<TitleWindow>();
			
			playlistModel = new PlaylistModel();
			moderationModel = new ModerationModel();
			dropFolderModel = new DropFolderModel();
			
			categoriesModel = new CategoriesModel();
			BindingUtils.bindProperty(categoriesModel, "loadingFlag", this, "loadingFlag");
			
			bulkUploadModel = new BulkUploadModel();
			
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