package com.kaltura.kmc.modules.account.vo {
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParams;
	
	import mx.utils.ObjectProxy;

	[Bindable]
	public class ConversionProfileVO implements IValueObject {

		/**
		 * used for marking selection in AdvancedConversionSettingsTable 
		 */
		public var tableSelected:Boolean;

		/**
		 * conversion profile
		 */
		public var profile:KalturaConversionProfile;
		
		/**
		 * id of the wrapped profile 
		 */		
		public var id:String;

		
		[ArrayElementType("com.kaltura.vo.KalturaConversionProfileAssetParams")]
		/**
		 * flavors associated with the conversion profile <br>
		 * <code>KalturaConversionProfileAssetParams</code> objects
		 * */
		public var flavors:Array;

		
		/**
		 * Constructor.
		 */
		public function ConversionProfileVO() {
			profile = new KalturaConversionProfile();
		}


		/**
		 * returns a clone of this vo
		 */
		public function clone():ConversionProfileVO {
			var ncp:ConversionProfileVO = new ConversionProfileVO();
			var ar:Array = ObjectUtil.getObjectAllKeys(this.profile);
			ncp.flavors = this.flavors;

			for (var i:int = 0; i < ar.length; i++) {
				ncp.profile[ar[i]] = profile[ar[i]];
			}

//			ncp.profile.createdAt = this.profile.createdAt;
//			ncp.profile.description = this.profile.description
//			ncp.profile.flavorParamsIds = this.profile.flavorParamsIds;
//			ncp.profile.id = this.profile.id;
//			ncp.profile.name = this.profile.name;
//			ncp.profile.partnerId = this.profile.partnerId;
//			ncp.profile.isDefault = this.profile.isDefault;
			return ncp;
		}

	}
}