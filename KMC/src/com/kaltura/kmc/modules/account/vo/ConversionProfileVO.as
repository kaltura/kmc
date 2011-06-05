package com.kaltura.kmc.modules.account.vo {
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParams;

	[Bindable]
	public class ConversionProfileVO implements IValueObject {



		private var _selected:Boolean = false;

		/**
		 * conversion profile
		 */
		public var profile:KalturaConversionProfile;

		
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
		 * indicates this profile is selected
		 */
		public function get selected():Boolean {
			return _selected;
		}


		/**
		 * @private
		 */
		public function set selected(selected:Boolean):void {
			_selected = selected;
		}


		/**
		 * returns a clone of this vo
		 */
		public function clone():ConversionProfileVO {
			var ncp:ConversionProfileVO = new ConversionProfileVO();
			var ar:Array = ObjectUtil.getObjectAllKeys(this.profile);
			ncp.selected = this.selected;
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