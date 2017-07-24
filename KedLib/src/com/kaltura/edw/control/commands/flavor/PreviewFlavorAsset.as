package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import flash.external.ExternalInterface;
	
	import mx.resources.ResourceManager;
	
	public class PreviewFlavorAsset extends KedCommand
	{
		override public function execute(event:KMvCEvent):void
		{		
			// { asset_id : "00_uyjv3dkxot", flavor_name : "Normal - big", format : "flv", codec : "vp6", bitrate : "768", dimensions : { height : 360 , width : 640 }, sizeKB : 1226, status : "OK" } 
			
			var obj:KalturaFlavorAssetWithParams = event.data as KalturaFlavorAssetWithParams;
			var flavorDetails:Object = new Object();
			flavorDetails.asset_id = obj.flavorAsset.id;
			flavorDetails.flavor_name = obj.flavorParams.name;
			flavorDetails.format = obj.flavorParams.format;
			flavorDetails.codec = obj.flavorAsset.videoCodecId;	// this is right
//			flavorDetails.codec = obj.flavorParams.videoCodec;  // this is wrong!!
			flavorDetails.bitrate = obj.flavorAsset.bitrate;
			
			var dimensions:Object = new Object();
			dimensions.height = obj.flavorAsset.height;
			dimensions.width = obj.flavorAsset.width;
			
			flavorDetails.dimensions = dimensions;
			flavorDetails.sizeKB = obj.flavorAsset.size;
			flavorDetails.status = ResourceManager.getInstance().getString('cms','readyStatus');
			
			ExternalInterface.call("kmc.preview_embed.doFlavorPreview", obj.entryId, escape((_model.getDataPack(EntryDataPack)as EntryDataPack).selectedEntry.name) , flavorDetails);
		}
	}
}