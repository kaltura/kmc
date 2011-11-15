package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CustomDataDataPack implements IDataPack {
		
		public var shared:Boolean = false;
		
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