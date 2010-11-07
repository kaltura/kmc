package com.kaltura.kmc.modules.account.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	[Bindable]
	public class AdminVO implements IValueObject
	{
		public var oldEmail : String = "";
		public var newEmail : String = "";
		public var oldPassword : String = "";
		public var newPassword : String = "";
		public var confirmedPassword : String = "";
		
		public function clone() : AdminVO
		{
			var newAVo : AdminVO = new AdminVO();
			newAVo.newEmail = this.newEmail;
			newAVo.oldEmail = this.oldEmail;
			newAVo.oldPassword = this.oldPassword;
			newAVo.newPassword = this.newPassword;
			newAVo.confirmedPassword = this.confirmedPassword;
			return newAVo;
		}
		
		public function equals( newAVo : AdminVO) : Boolean
		{
			if(!newAVo)
				return false;
				
			var isIt : Boolean = true;
			if( newAVo.newEmail != this.newEmail) isIt = false;
			if( newAVo.oldEmail != this.oldEmail) isIt = false;
			if( newAVo.oldPassword != this.oldPassword) isIt = false;
			if( newAVo.newPassword != this.newPassword) isIt = false;
			if( newAVo.confirmedPassword != this.confirmedPassword) isIt = false;
			return isIt;
		}
	}
}