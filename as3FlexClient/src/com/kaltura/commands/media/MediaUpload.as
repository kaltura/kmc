package com.kaltura.commands.media
{
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import com.kaltura.delegates.media.MediaUploadDelegate;

	public class MediaUpload extends KalturaFileCall
	{
		public var fileData:FileReference;
		public function MediaUpload( fileData : FileReference )
		{
			service= 'media';
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
			delegate = new MediaUploadDelegate( this , config );
		}
	}
}
