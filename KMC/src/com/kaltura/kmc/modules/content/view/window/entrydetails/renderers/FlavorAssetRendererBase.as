package com.kaltura.kmc.modules.content.view.window.entrydetails.renderers
{
	import com.kaltura.kmc.modules.content.vo.FlavorAssetWithParamsVO;
	import com.kaltura.managers.FileUploadManager;
	import com.kaltura.vo.FileUploadVO;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import mx.containers.HBox;

	public class FlavorAssetRendererBase extends HBox
	{
		public function FlavorAssetRendererBase()
		{
			super();
		}
		
		public function onCreatoinComplete():void
		{
			var obj:FlavorAssetWithParamsVO = data as FlavorAssetWithParamsVO;
			/* var bgColor:String = (obj.kalturaFlavorAssetWithParams.flavorAsset != null) ? '#FFFFFF' : '#DED2D2';
			
			this.setStyle("backgroundColor", bgColor); */
			
			this.horizontalScrollPolicy = "off";
			this.verticalScrollPolicy = "off";
		}
		
		/**
		 * checks if any files related to this flavor are currently uploading via upload manager
		 * @return true if files are handled by upload manager, false otherwise.
		 * */
		protected function isRelatedFlavorUploading():Boolean {
			var uploadingfiles:Vector.<FileUploadVO> = FileUploadManager.getInstance().getAllFiles();
			var _flavorWithParams:FlavorAssetWithParamsVO = data as FlavorAssetWithParamsVO;
			var result:Boolean;
			for each (var file:FileUploadVO in uploadingfiles) {
				if (_flavorWithParams.kalturaFlavorAssetWithParams.flavorAsset) { 
					if (file.flavorAssetId == _flavorWithParams.kalturaFlavorAssetWithParams.flavorAsset.id)
					{
						result = true;
						break;
					}
				}
				else if (file.flavorParamsId == _flavorWithParams.kalturaFlavorAssetWithParams.flavorParams.id) {
					result = true;
					break;
				}
			}
			return result;
		}
		
				
	}
}