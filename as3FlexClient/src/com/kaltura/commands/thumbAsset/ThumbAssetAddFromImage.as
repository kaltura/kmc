package com.kaltura.commands.thumbAsset
{
	import com.kaltura.vo.File;
	import com.kaltura.delegates.thumbAsset.ThumbAssetAddFromImageDelegate;
	import com.kaltura.net.KalturaCall;

	public class ThumbAssetAddFromImage extends KalturaCall
	{
		public var filterFields : String;
		public function ThumbAssetAddFromImage( entryId : String,fileData : file )
		{
			service= 'thumbasset';
			action= 'addFromImage';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'entryId' );
			valueArr.push( entryId );
 			keyValArr = kalturaObject2Arrays(fileData,'fileData');
			keyArr = keyArr.concat( keyValArr[0] );
			valueArr = valueArr.concat( keyValArr[1] );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new ThumbAssetAddFromImageDelegate( this , config );
		}
	}
}
