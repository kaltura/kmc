package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	[Bindable]
	/**
	 * infornmation about the entries that make up the mix
	 * and the mixes in which the current entry appears
	 * */
	public class ContentDataPack implements IDataPack {
		
		public var shared:Boolean = false;
		
//		/**
//		 * whether to display "mixes" tab in entrydrilldown
//		 * (in KMC value is taken from content uiconf) 
//		 */		
//		public var showMixesTab:Boolean = true;
		
		/**
		 * for mix entries, all the entries that make up the mix.
		 * for other entries, all the mixes this entry appears in. 
		 */
		public var contentParts:Array;
	}
}