package com.kaltura.edw.vo
{
	import com.kaltura.edw.model.MetadataDataObject;
	import com.kaltura.vo.KalturaMetadata;

	/**
	 * This value onject holds any information relevant to metadata data 
	 * @author Michal
	 * 
	 */	
	[Bindable]
	public class EntryMetadataDataVO
	{
		//dynamic object, represents metadata values
		public var metadataDataObject:MetadataDataObject = new MetadataDataObject();
		public var finalViewMxml:XML;
		public var metadata:KalturaMetadata;
		
		public function EntryMetadataDataVO()
		{
		}
	}
}