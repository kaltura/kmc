package com.kaltura.kmc.modules.content.business
{
	import com.kaltura.edw.business.base.FormBuilderBase;
	import com.kaltura.edw.model.MetadataDataObject;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaMetadata;
	
	import mx.collections.ArrayCollection;
	
	public class CategoryFormBuilder extends FormBuilderBase
	{
		
		
		public function CategoryFormBuilder(metadataProfile:KMCMetadataProfileVO)
		{
			super(metadataProfile);
		}
	}
}