package com.kaltura.kmc.modules.content.vo
{
	import com.kaltura.vo.KalturaConversionProfile;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * Couples <code>KalturaConversionProfile</code> with its 
	 * <code>KalturaFlavorParams</code> (not <code>KalturaAssetParams</code>)
	 * @author Atar
	 */
	public class ConversionProfileWithFlavorParamsVo {
		
		/**
		 * Conversion Profile 
		 */
		public var profile:KalturaConversionProfile;
		
		[ArrayElementType("com.kaltura.vo.KalturaFlavorParams")]
		/**
		 * all flavor params objects whos ids are associated with this profile.
		 * <code>KalturaFlavorParams</code> objects 
		 */		
		public var flavors:ArrayCollection;
		
		public function ConversionProfileWithFlavorParamsVo(){
			flavors = new ArrayCollection();
		}
		
	}
}