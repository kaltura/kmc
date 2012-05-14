package com.kaltura.kmc.modules.content.business {
	import com.kaltura.edw.business.permissions.PermissionManager;
	import com.kaltura.kmc.modules.content.events.ChangeModelEvent;
	
	import flash.events.Event;
	
	import mx.containers.VBox;
	import mx.events.FlexEvent;

	
	/**
	 * dispatched after the permission manager runs and permissions are processed
	 */
	[Event(name="permissionsSet", type="flash.events.Event")]
	
	/**
	 * This is a dummy panel used to update the content model without using one
	 * of the viewstack panels directly. </br>
	 * we can't trigger PermissionManager.applyAllPermissions directly from
	 * Content, because the inner panels are not ready yet, so we'll use this one.
	 * @author Atar
	 *
	 */
	public class GeneralPermissionsSetter extends VBox {

		
		public static const PERMISSIONS_SET:String = "permissionsSet";
		
		
		public function GeneralPermissionsSetter() {
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			dispatchEvent(new Event(GeneralPermissionsSetter.PERMISSIONS_SET, true));
		}


		protected function creationCompleteHandler(e:FlexEvent):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			PermissionManager.getInstance().applyAllAttributes(this, this.id);
		}



		/**
		 * allow roles and permissions to decide if user should
		 * see custom metadata related things.
		 */
		public function set enableCustomData(value:Boolean):void {
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_CUSTOM_METADATA, value);
			cge.dispatch();
		}


		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get enableCustomData():Boolean {
			return true;
		}


		/**
		 * allow roles and permissions to decide if can update custom data data
		 */
		public function set enableUpdateCustomData(value:Boolean):void {
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_UPDATE_CUSTOM_DATA, value);
			cge.dispatch();
		}


		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get enableUpdateCustomData():Boolean {
			return true;
		}


		/**
		 * allow roles and permissions to decide if user should
		 * see distribution related things.
		 */
		public function set enableDistribution(value:Boolean):void {
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_DISTRIBUTION, value);
			cge.dispatch();
		}


		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get enableDistribution():Boolean {
			return true;
		}


		/**
		 * allow roles and permissions to decide if user should
		 * see embed code.
		 */
		public function set showPlaylistEmbedCode(value:Boolean):void {
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_PLAYLIST_EMBED_STATUS, value);
			cge.dispatch();
		}


		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get showPlaylistEmbedCode():Boolean {
			return true;
		}




		public function set showSinglePlayerEmbedCode(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_SINGLE_ENTRY_EMBED_STATUS, value);
			cge.dispatch();
		}


		public function get showSinglePlayerEmbedCode():Boolean {
			return true;
		}


		public function set enableRemoteStorage(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_REMOTE_STORAGE, value);
			cge.dispatch();
		}


		public function get enableRemoteStorage():Boolean {
			return true;
		}


		public function set enableThumbResize(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_ENABLE_THUMB_RESIZE, value);
			cge.dispatch();
		}


		public function get enableThumbResize():Boolean {
			return true;
		}


		public function set lotsOfCategoriesFlag(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_LOTS_OF_CATEGORIES_FLAG, value);
			cge.dispatch();
		}


		public function get lotsOfCategoriesFlag():Boolean {
			return true;
		}
		
		
		public function set confirmModeration(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_CONFIRM_MODERATION	, value);
			cge.dispatch();
		}
		
		public function get confirmModeration():Boolean {
			return true;
		}
	}
}