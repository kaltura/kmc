package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.UserVO;

	public class UserEvent extends CairngormEvent
	{
		public static const BAN_USER : String = "content_banUser";
		public var userVo : UserVO;
		
		public function UserEvent(type:String, userVo : UserVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.userVo = userVo;
		}
		
	}
}