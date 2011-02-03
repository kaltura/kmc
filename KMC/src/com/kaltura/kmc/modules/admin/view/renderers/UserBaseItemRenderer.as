package com.kaltura.kmc.modules.admin.view.renderers
{
	import com.kaltura.vo.KalturaUser;
	
	import mx.containers.HBox;

	public class UserBaseItemRenderer extends HBox
	{
		public function UserBaseItemRenderer()
		{
			super();
			this.setStyle("paddingLeft", "6");
			this.setStyle("verticalAlign", "middle");
		}
		
		public function setDefaultContainer():void
		{
			if(data && (data as KalturaUser).isAccountOwner)
			{
				this.setStyle("backgroundColor", "#FFFDEF");
			}
			else
			{
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