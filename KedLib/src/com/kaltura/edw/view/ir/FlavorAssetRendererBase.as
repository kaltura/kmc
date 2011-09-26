package com.kaltura.edw.view.ir
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
				
	}
}