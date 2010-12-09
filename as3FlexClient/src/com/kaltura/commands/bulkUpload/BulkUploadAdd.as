package com.kaltura.commands.bulkUpload
{
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import com.kaltura.delegates.bulkUpload.BulkUploadAddDelegate;

	public class BulkUploadAdd extends KalturaFileCall
	{
		public var csvFileData:FileReference;
		public function BulkUploadAdd( conversionProfileId : int,csvFileData : FileReference )
		{
			service= 'bulkupload';
			action= 'add';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'conversionProfileId' );
			valueArr.push( conversionProfileId );
			this.csvFileData = csvFileData;
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new BulkUploadAddDelegate( this , config );
		}
	}
}
