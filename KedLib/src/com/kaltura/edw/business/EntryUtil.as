package com.kaltura.edw.business
{
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaPlayableEntry;
	
	import mx.collections.ArrayCollection;

	/**
	 * This class will hold functions related to kaltura entries 
	 * @author Michal
	 * 
	 */	
	public class EntryUtil
	{
		
		/**
		 * Update the given entry on the listableVO list, if it contains an entry with the same id 
		 * 
		 */		
		public static function updateSelectedEntryInList(entryToUpdate:KalturaBaseEntry, entries:ArrayCollection):void {
			for each (var entry:KalturaBaseEntry in entries) {
				if (entry.id==entryToUpdate.id) {
					var atts:Array = ObjectUtil.getObjectAllKeys(entryToUpdate);
					var oldVal:*;
					var att:String;
					for (var i:int = 0; i<atts.length; i++) {
						att = atts[i];
						if (entry[att] != entryToUpdate[att]){
							oldVal = entry[att]; 
							entry[att] = entryToUpdate[att];
						}
					}
					break;
				}
			}	
		}	
		
		/**
		 * In order not to override data that was inserted by the user, update only status & replacement fiedls that
		 * might have changed
		 * */
		public static function updateChangebleFieldsOnly(newEntry:KalturaBaseEntry, oldEntry:KalturaBaseEntry):void {
			oldEntry.status = newEntry.status;
			oldEntry.replacedEntryId = newEntry.replacedEntryId;
			oldEntry.replacingEntryId = newEntry.replacingEntryId;
			oldEntry.replacementStatus = newEntry.replacementStatus;
			(oldEntry as KalturaPlayableEntry).duration = (newEntry as KalturaPlayableEntry).duration;
		}
	}
}