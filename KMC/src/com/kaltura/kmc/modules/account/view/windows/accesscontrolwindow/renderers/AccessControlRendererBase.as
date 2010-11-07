package com.kaltura.kmc.modules.account.view.windows.accesscontrolwindow.renderers
{
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.vo.AccessControlProfileVO;
	
	import mx.containers.HBox;

	public class AccessControlRendererBase extends HBox
	{
		public function AccessControlRendererBase()
		{
			super();
		}
		
		public function setDefaultContainer():void
		{
			if((data as AccessControlProfileVO).profile.isDefault == KalturaNullableBoolean.TRUE_VALUE)
			{
				this.toolTip = resourceManager.getString('kmc', 'defaultAccessContolProfileToolTip');
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