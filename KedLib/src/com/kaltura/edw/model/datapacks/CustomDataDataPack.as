package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	import mx.collections.ArrayCollection;
	
	public class CustomDataDataPack implements IDataPack {
		
		/**
		 * array of EntryMetadataDataVO;
		 * */
		public var metadataInfoArray:ArrayCollection;
		
		/**
		 * uiconf id used with metadata
		 * */
		public var metadataDefaultUiconf:int;
		
		/**
		 * default metadata view uiconf xml
		 * */
		public var metadataDefaultUiconfXML:XML;
	}
}