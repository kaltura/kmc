package com.kaltura.edw.control.commands.usrs
{
	import com.kaltura.commands.user.UserGet;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.UsersEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaUser;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class GetEntryUserCommand extends KedCommand {
		
		private var _type:String;
		private var _userId:String;
		
		override public function execute(event:KMvCEvent):void {
			
			if (event.type == UsersEvent.RESET_ENTRY_USERS) {
				var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
				edp.selectedEntryCreator = null;
				edp.selectedEntryOwner = null;
				edp.entryEditors = null;
				edp.entryPublishers = null;
				return;
			}
			
			// otherwise, get the required user
			_type = event.type;
			_userId = event.data;
			
			_model.increaseLoadCounter();
			
			var getUser:UserGet = new UserGet(event.data);
			
			getUser.addEventListener(KalturaEvent.COMPLETE, result);
			getUser.addEventListener(KalturaEvent.FAILED, result);	// intentionally so
			
			_client.post(getUser);
		}
		
		
		
		override public function result(data:Object):void {
			super.result(data);
			
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			if (data.data && data.data is KalturaUser) {
				switch (_type) {
					case UsersEvent.GET_ENTRY_CREATOR:
						edp.selectedEntryCreator = data.data as KalturaUser;
						break;
					
					case UsersEvent.GET_ENTRY_OWNER:
						edp.selectedEntryOwner = data.data as KalturaUser;
						break;
				}
			}
			else if (data.error) {
				var er:KalturaError = data.error;
				if (er.errorCode == "INVALID_USER_ID") {
					// the user is probably deleted, create a dummy user:
					var usr:KalturaUser = new KalturaUser();
					usr.id = _userId;
					usr.screenName = _userId;
					switch (_type) {
						case UsersEvent.GET_ENTRY_CREATOR:
							edp.selectedEntryCreator = usr;
							break;
						
						case UsersEvent.GET_ENTRY_OWNER:
							edp.selectedEntryOwner = usr;
							break;
					}
				}
				else {
					Alert.show(/*getErrorText(er)*/"pfff", ResourceManager.getInstance().getString('drilldown', 'error'));
				}
			}
			_model.decreaseLoadCounter();
		}
	}
}