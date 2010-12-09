package com.kaltura.commands.documents
{
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import com.kaltura.delegates.documents.DocumentsUploadDelegate;

	public class DocumentsUpload extends KalturaFileCall
	{
		public var fileData:FileReference;
		public function DocumentsUpload( fileData : FileReference )
		{
			service= 'document_documents';
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
			delegate = new DocumentsUploadDelegate( this , config );
		}
	}
}
