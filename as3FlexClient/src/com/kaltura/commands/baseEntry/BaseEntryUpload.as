package com.kaltura.commands.baseEntry
{
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import com.kaltura.delegates.baseEntry.BaseEntryUploadDelegate;

	public class BaseEntryUpload extends KalturaFileCall
	{
		public var fileData:FileReference;
		public function BaseEntryUpload( fileData : FileReference )
		{
			service= 'baseentry';
			action= 'upload';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			this.fileData = fileData;
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new BaseEntryUploadDelegate( this , config );
		}
	}
}
