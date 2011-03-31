package com.kaltura.commands.conversionProfile
{
	import com.kaltura.vo.KalturaConversionProfileAssetParams;
	import com.kaltura.delegates.conversionProfile.ConversionProfileUpdateAssetParamsDelegate;
	import com.kaltura.net.KalturaCall;

	public class ConversionProfileUpdateAssetParams extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param conversionProfileId int
		 * @param assetParamsId int
		 * @param conversionProfileAssetParams KalturaConversionProfileAssetParams
		 **/
		public function ConversionProfileUpdateAssetParams( conversionProfileId : int,assetParamsId : int,conversionProfileAssetParams : KalturaConversionProfileAssetParams )
		{
			service= 'conversionprofile';
			action= 'updateAssetParams';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('conversionProfileId');
			valueArr.push(conversionProfileId);
			keyArr.push('assetParamsId');
			valueArr.push(assetParamsId);
 			keyValArr = kalturaObject2Arrays(conversionProfileAssetParams, 'conversionProfileAssetParams');
			keyArr = keyArr.concat(keyValArr[0]);
			valueArr = valueArr.concat(keyValArr[1]);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new ConversionProfileUpdateAssetParamsDelegate( this , config );
		}
	}
}
