package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.view.window.flavors.DRMDetails;
	import com.kaltura.edw.vo.FlavorAssetWithParamsVO;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	import flash.display.DisplayObject;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;

	public class ViewWVAssetDetails extends KedCommand
	{
		override public function execute(event:KMvCEvent):void
		{		
			var win:DRMDetails = new DRMDetails();
			win.flavorAssetWithParams = event.data as FlavorAssetWithParamsVO;
			PopUpManager.addPopUp(win, (Application.application as DisplayObject), true);
			PopUpManager.centerPopUp(win);
		}
	}
}