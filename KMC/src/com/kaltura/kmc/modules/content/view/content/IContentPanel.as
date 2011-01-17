package com.kaltura.kmc.modules.content.view.content
{
	import com.kaltura.vo.KalturaBaseEntryFilter;

	/**
	 * This interface declares methods that allow the Content module to comunicate with its subtabs.
	 * @author Atar
	 * 
	 */	
	public interface IContentPanel {
		
		/**
		 * initialize the panel, refresh data, etc.
		 * @param kbef	(optional) initial filtering data
		 */		
		function init(kbef:KalturaBaseEntryFilter = null):void;
		

	}
}