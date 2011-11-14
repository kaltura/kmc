package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	[Bindable]
	/**
	 * information regarding captions of the current entry
	 * */
	public class CaptionsDataPack implements IDataPack {
		
		/**
		 * Array of captionEntryVO
		 * */
		public var captionsArray:Array;
	}
}