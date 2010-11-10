package com.kaltura.kmc.modules.content.vo
{
	import flexlib.controls.textClasses.StringBoundaries;
	
	import mx.collections.ArrayCollection;
	
	public class MetadataDataVO
	{
		public var values:ArrayCollection = new ArrayCollection();
		public var valueKey:String;
		
		public function MetadataDataVO(valueKey:String)
		{
			this.valueKey = valueKey;
		}

	}
}