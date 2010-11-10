package com.kaltura.kmc.modules.content.model.types
{
	import mx.resources.ResourceManager;
	
	public class BulkTypes
	{
		public static const PENDING : uint = 0;
		public static const QUEUED : uint= 1;
		public static const PROCESSING : uint = 2;
		public static const PROCESSED : uint = 3;
		public static const MOVEFILE : uint = 4;
		public static const FINISHED : uint = 5;
		public static const FAILED : uint = 6;
		public static const ABORTED : uint = 7;


		public static function getTypeName(  bulkType : uint ) : String
		{
			switch(bulkType)
			{
				case PENDING: return ResourceManager.getInstance().getString( 'cms' , 'verifyingFile' ); break;
				case QUEUED: return   ResourceManager.getInstance().getString( 'cms' , 'verifyingQforI' ); break;
				case PROCESSING: return ResourceManager.getInstance().getString( 'cms' , 'processing' ); break;
				case FINISHED: return ResourceManager.getInstance().getString( 'cms' , 'finished' ); break; 
				case ABORTED: return ResourceManager.getInstance().getString( 'cms' , 'aborted' ); break; 
			}
			return "";
		}

	}
}