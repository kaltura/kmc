package com.kaltura.commands.contentDistributionBatch
{
	import com.kaltura.delegates.contentDistributionBatch.ContentDistributionBatchGetAssetUrlDelegate;
	import com.kaltura.net.KalturaCall;

	public class ContentDistributionBatchGetAssetUrl extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param assetId String
		 **/
		public function ContentDistributionBatchGetAssetUrl( assetId : String )
		{
			service= 'contentdistribution_contentdistributionbatch';
			action= 'getAssetUrl';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('assetId');
			valueArr.push(assetId);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new ContentDistributionBatchGetAssetUrlDelegate( this , config );
		}
	}
}
