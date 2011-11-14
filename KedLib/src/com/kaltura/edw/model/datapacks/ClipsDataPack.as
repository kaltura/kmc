package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	[Bindable]
	/**
	 * information about clips created from the current entry
	 * */
	public class ClipsDataPack implements IDataPack {
		
		/**
		 * clips derived from the current entry, 
		 * <code>KalturaBaseEntry</code> objects
		 */		
		public var clips:Array;
	}
}