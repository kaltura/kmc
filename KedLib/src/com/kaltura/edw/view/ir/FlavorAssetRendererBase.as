package com.kaltura.edw.view.ir
{
	import com.kaltura.edw.vo.FlavorAssetWithParamsVO;
	import com.kaltura.managers.FileUploadManager;
	import com.kaltura.vo.FileUploadVO;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import mx.containers.HBox;
	import mx.events.FlexEvent;

	public class FlavorAssetRendererBase extends HBox
	{
		public function FlavorAssetRendererBase()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreatoinComplete);
		}
		
		protected function onCreatoinComplete(e:FlexEvent):void
		{
			/* var obj:FlavorAssetWithParamsVO = data as FlavorAssetWithParamsVO;
			var bgColor:String = (obj.kalturaFlavorAssetWithParams.flavorAsset != null) ? '#FFFFFF' : '#DED2D2';
			
			this.setStyle("backgroundColor", bgColor); */
			
			horizontalScrollPolicy = "off";
			verticalScrollPolicy = "off";
		}	
				
	}
}