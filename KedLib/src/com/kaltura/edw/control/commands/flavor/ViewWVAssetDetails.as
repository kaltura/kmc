package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	import com.kaltura.vo.KalturaWidevineFlavorAsset;
	import com.kaltura.edw.view.window.flavors.DRMDetails;
	import mx.managers.PopUpManager;
	import mx.core.Application;
	import flash.display.DisplayObject;

	public class ViewWVAssetDetails extends KedCommand
	{
		override public function execute(event:KMvCEvent):void
		{		
			var wvAsset:KalturaWidevineFlavorAsset = (event.data as KalturaFlavorAssetWithParams).flavorAsset as KalturaWidevineFlavorAsset;
			var win:DRMDetails = new DRMDetails();
			win.flavorAsset = wvAsset;
			PopUpManager.addPopUp(win, (Application.application as DisplayObject), true);
		}
	}
}