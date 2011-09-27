package com.kaltura.edw.vo
{
	import com.kaltura.vo.KalturaConversionProfile;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * Couples <code>KalturaConversionProfile</code> with its 
	 * <code>KalturaConversionProfileAssetParams</code>.
	 * @author Atar
	 */
	public class ConversionProfileWithFlavorParamsVo {
		
		/**
		 * Conversion Profile 
		 */
		public var profile:KalturaConversionProfile;
		
		[ArrayElementType("com.kaltura.vo.KalturaConversionProfileAssetParams")]
		/**
		 * all flavor params objects whos ids are associated with this profile.
		 * <code>KalturaConversionProfileAssetParams</code> objects 
		 */		
		public var flavors:ArrayCollection;
		
		public function ConversionProfileWithFlavorParamsVo(){
			flavors = new ArrayCollection();
		}
		
	}
}