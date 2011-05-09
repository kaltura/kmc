package com.kaltura.commands.document
{
	import com.kaltura.vo.KalturaDocumentEntry;
	import com.kaltura.vo.KalturaResource;
	import com.kaltura.delegates.document.DocumentAddDelegate;
	import com.kaltura.net.KalturaCall;

	public class DocumentAdd extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param entry KalturaDocumentEntry
		 * @param resource KalturaResource
		 **/
		public function DocumentAdd( entry : KalturaDocumentEntry,resource : KalturaResource=null )
		{
			service= 'document';
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
			delegate = new DocumentAddDelegate( this , config );
		}
	}
}
