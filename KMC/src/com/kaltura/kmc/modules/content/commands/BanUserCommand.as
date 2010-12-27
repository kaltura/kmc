package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserNotifyBan;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.UserEvent;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class BanUserCommand extends KalturaCommand implements ICommand, IResponder
	{

		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var e : UserEvent = event as UserEvent;
			var useerBanNotify:UserNotifyBan = new UserNotifyBan(e.userVo.puserId)
			useerBanNotify.addEventListener(KalturaEvent.COMPLETE, result);
			useerBanNotify.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(useerBanNotify);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			Alert.show( ResourceManager.getInstance().getString('cms','userBanned') );
		}
	}
}