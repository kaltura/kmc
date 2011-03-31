package com.kaltura.commands.conversionProfile
{
	import com.kaltura.delegates.conversionProfile.ConversionProfileListAssetParamsDelegate;
	import com.kaltura.net.KalturaCall;

	public class ConversionProfileListAssetParams extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param conversionProfileId int
		 **/
		public function ConversionProfileListAssetParams( conversionProfileId : int )
		{
			service= 'conversionprofile';
			action= 'listAssetParams';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('conversionProfileId');
			valueArr.push(conversionProfileId);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new ConversionProfileListAssetParamsDelegate( this , config );
		}
	}
}
