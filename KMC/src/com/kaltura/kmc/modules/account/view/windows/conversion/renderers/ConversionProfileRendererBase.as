package com.kaltura.kmc.modules.account.view.windows.conversion.renderers
{
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	
	import mx.containers.HBox;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;

	public class ConversionProfileRendererBase extends HBox implements IDropInListItemRenderer
	{
		
		/**
		 * property required of IDropInListItemRenderer exposed thru a public getter & setter
		 * */
		protected var _listData:BaseListData;
		
		// getter & setter methods
		public function get listData():BaseListData {
			return _listData;
		}
		
		public function set listData(value:BaseListData):void {
			_listData = value;
		}
		
		
		public function ConversionProfileRendererBase()
		{
			super();
		}
		
		public function setDefaultContainer():void
		{
			if((data as ConversionProfileVO).profile.isDefault)
			{
				this.toolTip = resourceManager.getString('account', 'defualtProfileTooTip');
				this.setStyle("backgroundColor", "#FFFDEF");
			}
			else
			{
				this.toolTip = null;
				this.setStyle("backgroundColor", null);
			}
		}
		
		override public function validateNow():void
		{
			super.validateNow();
			setDefaultContainer();
		}
		
	}
}