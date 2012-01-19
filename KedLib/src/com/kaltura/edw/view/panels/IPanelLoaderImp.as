package com.kaltura.edw.view.panels
{
	public interface IPanelLoaderImp
	{
		function createPanel(panelId:String, successCallback:Function, passThrough:Object = null):void;
		function get panelData():PanelMetadataVO;
	}
}