package com.kaltura.edw.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.edw.vo.EntryMetadataDataVO;
	import com.kaltura.edw.vo.ListableVo;
	import com.kaltura.types.KalturaTubeMogulSyndicationFeedOrderBy;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaBaseSyndicationFeedFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.containers.TitleWindow;
	import mx.core.IFlexDisplayObject;
	import com.kaltura.edw.model.Context;
	import com.kaltura.edw.model.EntryDetailsModel;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.DropFolderModel;
	import com.kaltura.edw.model.PlaylistModel;

	[Bindable]
	public class DummyModelLocator extends EventDispatcher implements IModelLocator {
		
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
		
		private var _entryDetailsModel:EntryDetailsModel;
		
		/**
		 * array of entryDetailsModel
		 * */
		public var entryDetailsModelsArray:Array;
		
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
		 * if we did some kind of action in entry drilldown that requires to refresh entries
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
		 * active entry details data, always the last one in entryDetailsModelsArray 
		 */
		public function get entryDetailsModel():EntryDetailsModel
		{
			return entryDetailsModelsArray[entryDetailsModelsArray.length-1];
		}

		/**
		 * @private
		 */
		public function set entryDetailsModel(value:EntryDetailsModel):void
		{
			entryDetailsModelsArray[entryDetailsModelsArray.length-1] = value;
		}

		/**
		 * increase the counter of loading items 
		 */		
		public function increaseLoadCounter():void {
			++_loadingCounter;
			if (_loadingCounter == 1) {
				for each (var edm:EntryDetailsModel in entryDetailsModelsArray) {
					edm.loadingFlag = true;
				}
				dispatchEvent(new Event(DummyModelLocator.LOADING_FLAG_CHANGED));
			}
		}
		
		
		/**
		 * decrease the counter of loading items 
		 */
		public function decreaseLoadCounter():void {
			--_loadingCounter;
			if (_loadingCounter == 0) {
				for each (var edm:EntryDetailsModel in entryDetailsModelsArray) {
					edm.loadingFlag = false;
				}
				dispatchEvent(new Event(DummyModelLocator.LOADING_FLAG_CHANGED));
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
		private static var _instance:DummyModelLocator;


		/**
		 * singleton means of retreiving an instance of the 
		 * <code>CmsModelLocator</code> class.
		 */		
		public static function getInstance():DummyModelLocator {
			if (_instance == null) {
				_instance = new DummyModelLocator(new Enforcer());
			}
			return _instance;
		}


		/**
		 * initialize parameters and sub-models. 
		 * @param enforcer	singleton garantee
		 */		
		public function DummyModelLocator(enforcer:Enforcer) {
			context = new Context();
			attic = new Object();
			
			filterModel = new FilterModel();
			_entryDetailsModel = new EntryDetailsModel();
			entryDetailsModelsArray = new Array(_entryDetailsModel);
			popups = new Vector.<TitleWindow>();
			
			playlistModel = new PlaylistModel();
			dropFolderModel = new DropFolderModel();
			
		}


	}
}

class Enforcer {

}