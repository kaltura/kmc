package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class PreviewFlavorAsset extends KalturaCommand implements ICommand
	{
		override public function execute(event:CairngormEvent):void
		{		
			// { asset_id : "00_uyjv3dkxot", flavor_name : "Normal - big", format : "flv", codec : "vp6", bitrate : "768", dimensions : { height : 360 , width : 640 }, sizeKB : 1226, status : "OK" } 
			
			var obj:KalturaFlavorAssetWithParams = event.data as KalturaFlavorAssetWithParams;
			var flavorDetails:Object = new Object();
			flavorDetails.asset_id = obj.flavorAsset.id;
			flavorDetails.flavor_name = obj.flavorParams.name;
			flavorDetails.format = obj.flavorParams.format;
			flavorDetails.codec = obj.flavorParams.videoCodec;
			flavorDetails.bitrate = obj.flavorAsset.bitrate;
			
			var dimensions:Object = new Object();
			dimensions.height = obj.flavorAsset.height;
			dimensions.width = obj.flavorAsset.width;
			
			flavorDetails.dimensions = dimensions;
			flavorDetails.sizeKB = obj.flavorAsset.size;
			flavorDetails.status = ResourceManager.getInstance().getString('cms','readyStatus');
			
			ExternalInterface.call("kmc.preview_embed.doFlavorPreview", obj.entryId, _model.entryDetailsModel.selectedEntry.name , flavorDetails);
		}
	}
}