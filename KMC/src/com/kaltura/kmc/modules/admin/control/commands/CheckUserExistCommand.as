package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserAdd;
	import com.kaltura.commands.user.UserGetByLoginId;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.admin.control.events.UserEvent;
	import com.kaltura.vo.KalturaUser;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;

	/**
	 * before we add a user we should see if it already exists in the system, either with the  
	 * current partner or another one. this command handles this test, as well as its concequences. 
	 * it overrides the default fault handler and doesn't call super.result().
	 * @author Atar
	 */
	public class CheckUserExistCommand extends BaseCommand {
		
		private var user:KalturaUser;
		
		override public function execute(event:CairngormEvent):void {
			user = (event as UserEvent).user;
			var ua:UserGetByLoginId = new UserGetByLoginId(user.email);
			ua.addEventListener(KalturaEvent.COMPLETE, result);
			ua.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.kc.post(ua);
		}
		
		override protected function result(data:Object):void {
//			super.result(data);
			if (data.success) {
				/* Use case 4 - user already exist in the system and is associated with the current account. 
				When creating a new user with an email address of a user that is already existed (active or 
				blocked) in the system and is associated with the current KMC account a pop-up message should 
				be prompted upon clicking the "save changes" button notifying the administrator on the existing 
				user "user.name@domain.com is already listed in the system as an authorized user in your 
				account". a new user should not be created and existing user should not be updated. 
				new user window should stay open. */
				var str:String = ResourceManager.getInstance().getString('admin', 'user_already_exists', [user.email]);
				Alert.show(str, ResourceManager.getInstance().getString('admin', 'error'));
			}
			else {
				handleFault(data.error as KalturaError);
			}
			_model.decreaseLoadCounter();
		}
		
		// override fault to handle correctly
		override protected function fault(info:Object):void {
			handleFault(info.error as KalturaError);
			_model.decreaseLoadCounter();
		}
		
		
		/**
		 * respond to the error received 
		 * @param err error received from the server
		 */
		private function handleFault(err:KalturaError):void {
			switch (err.errorCode) {
				case APIErrorCode.LOGIN_DATA_NOT_FOUND:
					/* Use case 2 - user does not exist in the system. a new user should be created 
					in the system associated with the specific account. a "new user account for new 
					user in the system" email notification should go out to both the user and to all 
					accounts administrators that are granted with user management permission. */
					
					// dispatch add user event to intiate the add process
					var cge:UserEvent = new UserEvent(UserEvent.ADD_USER, user);
					cge.dispatch();
					
					break;
				case APIErrorCode.USER_NOT_FOUND:
					/* Use case 3 - user already exist in the system and is associated with another account.
					When creating a new user with an email address of a user that already exists in the system 
					and is associated with another KMC account, a confirmation message should be prompted upon 
					clicking the "save changes" button notifying the administrator on the existing user 
					"user.name@domain.com is already listed in the system and is associated with another KMC 
					account do you want to associate this user with you account as well?" Upon confirmation the 
					existing user should be associated with the current account with the specified role and 
					optionally with a different publisher user ID. His first/last name should not be overridden 
					in the system. a "new user account for an existing user" email notification should go out 
					to both the user and to all account’s users that are granted with user management permission. */ 
					
					var str:String = ResourceManager.getInstance().getString('admin', 'user_exists_other_partner', [user.email]);
					Alert.show(str, ResourceManager.getInstance().getString('admin', 'add_user_title'), Alert.YES|Alert.NO, null, closeHandler);
					break;
				default:
					// show the given error text:
					Alert.show(err.errorMsg, ResourceManager.getInstance().getString('admin', 'error'));
					break;
			}
		}
		
		protected function closeHandler(e:CloseEvent):void {
			switch (e.detail) {
				case Alert.YES:
					// dispatch add user event to intiate the add process
					var cge:UserEvent = new UserEvent(UserEvent.ADD_USER, user);
					cge.dispatch();
					break;
				case Alert.NO:
					// do nothing
					break;
			}
		}
	}
}