package com.kaltura.edw.business
{
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;

	/**
	 * This class will hold functions related to kaltura entries 
	 * @author Michal
	 * 
	 */	
	public class EntryUtil
	{
//		private static var _model:CmsModelLocator = CmsModelLocator.getInstance();
		
		/**
		 * Update the given entry on the listableVO list, if it contains an entry with the same id 
		 * 
		 */		
		public static function updateSelectedEntryInList(entryToUpdate:KalturaBaseEntry, entries:ArrayCollection):void {
//			var entries:ArrayCollection = _model.listableVo.arrayCollection;
			for each (var entry:KalturaBaseEntry in entries) {
				if (entry.id==entryToUpdate.id) {
					var atts:Array = ObjectUtil.getObjectAllKeys(entryToUpdate);
					for (var i:int = 0; i<atts.length; i++) {
						entry[atts[i]] = entryToUpdate[atts[i]];
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
		}
	}
}