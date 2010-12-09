package com.kaltura.commands.metadata
{
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import com.kaltura.delegates.metadata.MetadataUpdateFromFileDelegate;

	public class MetadataUpdateFromFile extends KalturaFileCall
	{
		public var xmlFile:FileReference;
		public function MetadataUpdateFromFile( id : int,xmlFile : FileReference=null )
		{
			if(xmlFile== null)xmlFile= new FileReference();
			service= 'metadata_metadata';
			action= 'updateFromFile';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'id' );
			valueArr.push( id );
			this.xmlFile = xmlFile;
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new MetadataUpdateFromFileDelegate( this , config );
		}
	}
}
