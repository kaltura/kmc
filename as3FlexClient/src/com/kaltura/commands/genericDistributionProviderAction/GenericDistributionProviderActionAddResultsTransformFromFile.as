package com.kaltura.commands.genericDistributionProviderAction
{
	import flash.net.FileReference;
	import com.kaltura.net.KalturaFileCall;
	import com.kaltura.delegates.genericDistributionProviderAction.GenericDistributionProviderActionAddResultsTransformFromFileDelegate;

	public class GenericDistributionProviderActionAddResultsTransformFromFile extends KalturaFileCall
	{
		public var transformFile:FileReference;
		public function GenericDistributionProviderActionAddResultsTransformFromFile( id : int,transformFile : FileReference )
		{
			service= 'contentdistribution_genericdistributionprovideraction';
			action= 'addResultsTransformFromFile';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'id' );
			valueArr.push( id );
			this.transformFile = transformFile;
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new GenericDistributionProviderActionAddResultsTransformFromFileDelegate( this , config );
		}
	}
}
