package com.kaltura.kmc.modules.account.view.windows.conversionsettingswindow.renderers
{
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	
	import mx.containers.HBox;

	public class ConversionProfileRendererBase extends HBox
	{
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