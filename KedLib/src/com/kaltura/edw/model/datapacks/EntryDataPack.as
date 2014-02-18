package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaUser;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 * information regarding the current entry, its replacement, etc
	 * */
	public class EntryDataPack implements IDataPack {
		
		/**
		 * max number of categories an entry may be associated with by default
		 * */
		public static const DEFAULT_CATEGORIES_NUM:int = 32;
		
		/**
		 * max number of categories an entry may be associated with if FEATURE_DISABLE_CATEGORY_LIMIT is on
		 * */
		public static const MANY_CATEGORIES_NUM:int = 200;
		
		
		public var shared:Boolean = false;
		
		/**
		 * the max number of categories to which an entry may be assigned 
		 */		
		public var maxNumCategories:int = MANY_CATEGORIES_NUM;
		
		/**
		 * list of Object {label}	<br>
		 * used for entry details window > entry metadata (autocomplete DP)
		 * */
		public var categoriesFullNameList:ArrayCollection = new ArrayCollection();
		
		/**
		 * Current Viewed Entry
		 */
		public var selectedEntry:KalturaBaseEntry;
		
		/**
		 * index of Current Viewed Entry
		 */
		public var selectedIndex:int;
		
		/**
		 * replacement entry of the selected entry 
		 */		
		public var selectedReplacementEntry:KalturaBaseEntry;
		
		
		/**
		 * Name of the replaced entry for the replacement entry
		 * */
		public var replacedEntryName:String;
		
		/**
		 * if selected entry was refreshed
		 * */
		public var selectedEntryReloaded:Boolean;
		
		/**
		 * if selected entry is a kaltura livestream entry, is it currently boradcasting HDS?
		 * (use Nullable so we can set "no value" and binding will fire)
		 */
		public var selectedLiveEntryIsLive:int = KalturaNullableBoolean.NULL_VALUE;
		
		/**
		 * when saving an entry we list all entries that have the same 
		 * referenceId as the entry being saved. this is the list.
		 */
		public var entriesWSameRefidAsSelected:Array;
		
		public var loadRoughcuts:Boolean = true;
		
		
		/**
		 * list of categories the current entry is associated with
		 */
		public var entryCategories:ArrayCollection;
		
		
		/**
		 * the owner of the selected entry
		 */		
		public var selectedEntryOwner:KalturaUser;
		
		/**
		 * the creator of the selected entry
		 */		
		public var selectedEntryCreator:KalturaUser;
		
		/**
		 * the editors of the selected entry
		 * [KalturaUser]
		 */		
		public var entryEditors:Array;
		
		/**
		 * the publishers of the selected entry
		 * [KalturaUser]
		 */		
		public var entryPublishers:Array;
	}
}