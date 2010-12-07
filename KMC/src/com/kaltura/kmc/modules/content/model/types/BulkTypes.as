package com.kaltura.kmc.modules.content.model.types
{
	import com.kaltura.types.KalturaBatchJobStatus;
	
	import mx.resources.ResourceManager;
	
	public class BulkTypes
	{

		public static function getTypeName(  bulkType : uint ) : String
		{
			switch(bulkType)
			{
				case KalturaBatchJobStatus.PENDING: return ResourceManager.getInstance().getString( 'cms' , 'verifyingFile' ); break;
				case KalturaBatchJobStatus.QUEUED: return   ResourceManager.getInstance().getString( 'cms' , 'verifyingQforI' ); break;
				case KalturaBatchJobStatus.PROCESSING: return ResourceManager.getInstance().getString( 'cms' , 'processing' ); break;
				case KalturaBatchJobStatus.FINISHED: return ResourceManager.getInstance().getString( 'cms' , 'finished' ); break; 
				case KalturaBatchJobStatus.ABORTED: return ResourceManager.getInstance().getString( 'cms' , 'aborted' ); break; 
				case KalturaBatchJobStatus.FAILED: return ResourceManager.getInstance().getString( 'cms' , 'failed' ); break; 
				case KalturaBatchJobStatus.ALMOST_DONE: return ResourceManager.getInstance().getString( 'cms' , 'almostDone' ); break; 
				case KalturaBatchJobStatus.FATAL: return ResourceManager.getInstance().getString( 'cms' , 'fatal' ); break; 
				case KalturaBatchJobStatus.RETRY: return ResourceManager.getInstance().getString( 'cms' , 'retry' ); break; 
				case KalturaBatchJobStatus.DONT_PROCESS: return ResourceManager.getInstance().getString( 'cms' , 'dontProcess' ); break; 
			}
			return "";
		}

	}
}
