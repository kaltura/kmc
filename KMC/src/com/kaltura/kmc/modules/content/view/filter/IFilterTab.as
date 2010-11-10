package com.kaltura.kmc.modules.content.view.filter
{
	/**
	 * a tab in the Filter component
	 * */
	public interface IFilterTab {
		
		/**
		 * a list of all buttons in this group, the 
		 * "all" button is in index 0 of the array
		 * */
		function get buttons():Array;
		
	}
}