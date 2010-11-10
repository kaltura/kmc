package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.accessControl.AccessControlAdd;
	import com.kaltura.events.AccessControlProfileEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.AccessControlProfileVO;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class AddNewAccessControlProfileCommand extends KalturaCommand implements ICommand, IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			var accessControl:AccessControlProfileVO = event.data;
			var addNewAccessControl:AccessControlAdd = new AccessControlAdd(accessControl.profile);
		 	addNewAccessControl.addEventListener(KalturaEvent.COMPLETE, result);
			addNewAccessControl.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addNewAccessControl);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			if(data.success)
			{
				Alert.show(ResourceManager.getInstance().getString('cms', 'addNewAccessControlDoneMsg'));
				var getAllProfilesEvent:AccessControlProfileEvent = new AccessControlProfileEvent(AccessControlProfileEvent.LIST_ACCESS_CONTROLS_PROFILES);
				getAllProfilesEvent.dispatch();
			}
			else
			{
				Alert.show(data.error, ResourceManager.getInstance().getString('cms', 'error'));
			}
		}
		
//		override public function fault(event:Object):void
//		{
//			_model.decreaseLoadCounter();
//			Alert.show(event.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
//		}
		

	}
}