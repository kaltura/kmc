package com.kaltura.commands.documents
{
	import com.kaltura.vo.KalturaDocumentEntry;
	import com.kaltura.vo.KalturaResource;
	import com.kaltura.delegates.documents.DocumentsAddDelegate;
	import com.kaltura.net.KalturaCall;

	public class DocumentsAdd extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param entry KalturaDocumentEntry
		 * @param resource KalturaResource
		 **/
		public function DocumentsAdd( entry : KalturaDocumentEntry,resource : KalturaResource=null )
		{
			service= 'document_documents';
			action= 'add';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
 			keyValArr = kalturaObject2Arrays(entry, 'entry');
			keyArr = keyArr.concat(keyValArr[0]);
			valueArr = valueArr.concat(keyValArr[1]);
 			if (resource) { 
 			keyValArr = kalturaObject2Arrays(resource, 'resource');
			keyArr = keyArr.concat(keyValArr[0]);
			valueArr = valueArr.concat(keyValArr[1]);
 			} 
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new DocumentsAddDelegate( this , config );
		}
	}
}
