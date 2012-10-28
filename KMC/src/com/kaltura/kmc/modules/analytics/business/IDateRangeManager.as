package com.kaltura.kmc.modules.analytics.business
{
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	
	import mx.events.ListEvent;

	/**
	 * manages date changes in KalturaReportView's Filter.
	 * supplies the list of values for the date range combo box, a handler function for its change
	 * and the reverse "date to range" function.
	 * @see com.kaltura.kmc.modules.analytics.view.Filter
	 *  
	 * @author atar.shadmi
	 * 
	 */
	public interface IDateRangeManager
	{
		/**
		 * values for the range dropdown list 
		 */		
		function get dateRange():Array;
		function set dateRange(value:Array):void;
		
		
		/**
		 * change filter values according to selected item 
		 * @param filterVo
		 * @return 
		 */
		function changeDateByRange(event:ListEvent, filterVo:FilterVo):void;
		
		/**
		 * return matching index in the dataProvider
		 * @param filterVo
		 */
		function changeRangeByDate(filterVo:FilterVo):int;
		
	}
}