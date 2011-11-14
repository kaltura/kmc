package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.thumb.*;
	import com.kaltura.edw.control.events.GenerateThumbAssetEvent;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.edw.control.events.UploadFromImageThumbAssetEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class ThumbTabController extends KMvCController {
		
		public function ThumbTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(ThumbnailAssetEvent.LIST, ListThumbnailAssetCommand);
			addCommand(UploadFromImageThumbAssetEvent.ADD_FROM_IMAGE, AddFromImageThumbnailAssetCommand);
			addCommand(ThumbnailAssetEvent.DELETE, DeleteThumbnailAssetCommand);
			addCommand(ThumbnailAssetEvent.SET_AS_DEFAULT, SetAsDefaultThumbnailAsset);
			addCommand(GenerateThumbAssetEvent.GENERATE, GenerateThumbAssetCommand);
			
		}
	}
}