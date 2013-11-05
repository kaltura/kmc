package com.kaltura.edw.business
{
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaLiveStreamAdminEntry;
	import com.kaltura.vo.KalturaLiveStreamEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlayableEntry;
	import com.kaltura.vo.KalturaPlaylist;
	
	public class Cloner
	{
		public function Cloner()
		{
		}
		
		/**
		 * clone according to entry type
		 * */
		public static function cloneByEntryType(entry:KalturaBaseEntry):KalturaBaseEntry {
			var copy:KalturaBaseEntry;
			
			if (entry is KalturaPlaylist) {
				copy = cloneKalturaPlaylist(entry as KalturaPlaylist);
			}
			else if (entry is KalturaMixEntry) {
				copy = cloneKalturaMixEntry(entry as KalturaMixEntry);
			}
			else if (entry is KalturaLiveStreamEntry) {
				copy = cloneKalturaStreamAdminEntry(entry as KalturaLiveStreamEntry);
			}
			else if (entry is KalturaMediaEntry) {
				copy = cloneKalturaMediaEntry(entry as KalturaMediaEntry);
			}
			return copy;
		}
		
		
		/**
		 * Return a new KalturaBaseEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaBaseEntry(source:KalturaBaseEntry):KalturaBaseEntry
		{
			var be:KalturaBaseEntry = new KalturaBaseEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				be[atts[i]] = source[atts[i]];
			} 
			
			return be;
		}
		
		/**
		 * Return a new KalturaPlayableEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaPlayableEntry(source:KalturaPlayableEntry):KalturaPlayableEntry
		{
			var kpe:KalturaPlayableEntry = new KalturaPlayableEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				kpe[atts[i]] = source[atts[i]];
			} 
			return kpe;
		}
		
		
		/**
		 * Return a new KalturaMediaEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaMediaEntry(source:KalturaMediaEntry):KalturaMediaEntry
		{
			var me:KalturaMediaEntry = new KalturaMediaEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				me[atts[i]] = source[atts[i]];
			} 
			return me;
		}

		/**
		 * Return a new KalturaPlaylist object with same attributes as source attributes
		 */
		public static function cloneKalturaPlaylist(source:KalturaPlaylist):KalturaPlaylist
		{
			var pl:KalturaPlaylist = new KalturaPlaylist();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				pl[atts[i]] = source[atts[i]];
			} 
			return pl;
		}
		/**
		 * Return a new KalturaMixEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaMixEntry(source:KalturaMixEntry):KalturaMixEntry
		{
			var mix:KalturaMixEntry = new KalturaMixEntry();
			
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				mix[atts[i]] = source[atts[i]];
			} 
			
			return mix;
		}
		
		public static function cloneKalturaStreamAdminEntry(source:KalturaLiveStreamEntry):KalturaLiveStreamEntry
		{
			var klsae:KalturaLiveStreamEntry = new KalturaLiveStreamEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				klsae[atts[i]] = source[atts[i]];
			} 
			
			return klsae
		}
	}
}