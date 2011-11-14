package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 * information regarding the current entry, its replacement, etc
	 * */
	public class EntryDataPack implements IDataPack {
		
		/**
		 * the max number of categories to which an entry may be assigned 
		 */		
		public var maxNumCategories:int;
		
		/**
		 * list of Object {label}	<br>
		 * used for entry details window > entry metadata
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
		 * when saving an entry we list all entries that have the same 
		 * referenceId as the entry being saved. this is the list.
		 */
		public var entriesWSameRefidAsSelected:Array;
	}
}