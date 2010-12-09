package com.kaltura.commands.metadataProfile
{
	import com.kaltura.vo.KalturaMetadataProfile;
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import com.kaltura.delegates.metadataProfile.MetadataProfileAddFromFileDelegate;

	public class MetadataProfileAddFromFile extends KalturaFileCall
	{
		public var viewsFile:FileReference;
		public function MetadataProfileAddFromFile( metadataProfile : KalturaMetadataProfile,xsdFile : FileReference,viewsFile : FileReference=null )
		{
			if(viewsFile== null)viewsFile= new FileReference();
			service= 'metadata_metadataprofile';
			action= 'addFromFile';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
 			keyValArr = kalturaObject2Arrays(metadataProfile,'metadataProfile');
			keyArr = keyArr.concat( keyValArr[0] );
			valueArr = valueArr.concat( keyValArr[1] );
			this.xsdFile = xsdFile;
			this.viewsFile = viewsFile;
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new MetadataProfileAddFromFileDelegate( this , config );
		}
	}
}
