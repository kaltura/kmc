package com.kaltura.events
{
	public class KClipEventTypes {
		
		/**
		 * dispatched whenever the playhead is updated 
		 */		
		public static const PLAYHEAD_UPDATED:String = "playheadUpdated";
		
		/**
		 * dispatched when save operation is complete 
		 */		
		public static const SAVED:String = "saved"; 
		
		public static const CLIP_START_CHANGED:String = "clipStartChanged";
		
		public static const CLIP_END_CHANGED:String = "clipEndChanged";
		
		public static const CUE_POINT_CHANGED:String = "cuePointChanged";
		
		public static const CLIP_ADDED:String = "clipAdded";
		
		public static const CUE_POINT_ADDED:String = "cuePointAdded";
		
		public static const ZOOM_CHANGED:String = "zoomChanged";
		
		public static const ENTRY_READY:String = "entryReady";
		
		/**
		 * dispatched when all assets have been removed 
		 */
		public static const ALL_ASSETS_REMOVED:String = "allAssetsRemoved";
		
		public static const SELECTED_ASSET_REMOVED:String = "selectedAssetRemoved";
		
		/**
		 * dispatched when replacing the selected asset 
		 */		
		public static const SELECTED_ASSET_CHANGED:String = "selectedAssetChanged";
		
		
		public static const TIME_BASED_ASSET_UPDATED:String = "timeBasedAssetUpdated";

	}
}