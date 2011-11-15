package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 * information about files associated with the current entry
	 * */
	public class RelatedFilesDataPack implements IDataPack {
		
		public var shared:Boolean = false;
		
		/**
		 * ArrayCollection of RelatedFileVO  
		 */		
		public var relatedFilesAC:ArrayCollection;
	}
}