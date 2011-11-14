package com.kaltura.edw.components.filter
{
	import com.kaltura.vo.KalturaMediaEntryFilter;

	/**
	 * a tab in the Filter component
	 * */
	public interface IFilterTab {
		
		/**
		 * selects buttons according to given filter data.
		 * @param filterVo	filter data.
		 * */
		function setFilter(filterVo:KalturaMediaEntryFilter):void;
			
			
		/**
		 * creates a string representing the required
		 * moderation string, based on selected buttons.
		 * @return moderation string
		 * */
		function getFilterString():String;
		
		
		/**
		 * a list of all buttons in this group, the 
		 * "all" button is in index 0 of the array
		 * */
		function get buttons():Array;
		
	}
}