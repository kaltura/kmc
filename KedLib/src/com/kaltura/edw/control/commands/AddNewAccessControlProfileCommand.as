package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.accessControl.AccessControlAdd;
	import com.kaltura.edw.control.events.AccessControlEvent;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.AccessControlProfileVO;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class AddNewAccessControlProfileCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void
		{
			_dispatcher = event.dispatcher;
			var accessControl:AccessControlProfileVO = event.data;
			var addNewAccessControl:AccessControlAdd = new AccessControlAdd(accessControl.profile);
		 	addNewAccessControl.addEventListener(KalturaEvent.COMPLETE, result);
			addNewAccessControl.addEventListener(KalturaEvent.FAILED, fault);
			var context:ContextDataPack = _model.getDataPack(ContextDataPack) as ContextDataPack;
			context.kc.post(addNewAccessControl);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			if(data.success)
			{
				Alert.show(ResourceManager.getInstance().getString('cms', 'addNewAccessControlDoneMsg'));
				var getAllProfilesEvent:AccessControlEvent = new AccessControlEvent(AccessControlEvent.LIST_ACCESS_CONTROLS_PROFILES);
				_dispatcher.dispatch(getAllProfilesEvent);
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