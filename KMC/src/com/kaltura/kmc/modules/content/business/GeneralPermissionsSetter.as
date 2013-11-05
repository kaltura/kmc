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
		}


		protected function creationCompleteHandler(e:FlexEvent):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			PermissionManager.getInstance().applyAllAttributes(this, this.id);
			dispatchEvent(new Event(GeneralPermissionsSetter.PERMISSIONS_SET));
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



		/**
		 * allow roles and permissions to decide if user should
		 * see embed code.
		 */
		public function set showSinglePlayerEmbedCode(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_SINGLE_ENTRY_EMBED_STATUS, value);
			cge.dispatch();
		}


		public function get showSinglePlayerEmbedCode():Boolean {
			return true;
		}


		/**
		 * does the partner have remote storage feature?
		 */
		public function set enableRemoteStorage(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_REMOTE_STORAGE, value);
			cge.dispatch();
		}


		public function get enableRemoteStorage():Boolean {
			return true;
		}


		/**
		 * should KMC try to resize thumbnail images (entry table)? 
		 */
		public function set enableThumbResize(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_ENABLE_THUMB_RESIZE, value);
			cge.dispatch();
		}


		public function get enableThumbResize():Boolean {
			return true;
		}


		/**
		 * if this flag is on, categories are laoded in chunks. 
		 * it is turned on automatically (serverside) if the partner has more than X categories.
		 */
		public function set lotsOfCategoriesFlag(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_LOTS_OF_CATEGORIES_FLAG, value);
			cge.dispatch();
		}


		public function get lotsOfCategoriesFlag():Boolean {
			return true;
		}
		
		
		/**
		 * if true, whenever a user is trying to approve/reject entries in moderation 
		 * screen, they get an alert asking to confirm they realy want to do this. 
		 */
		public function set confirmModeration(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_CONFIRM_MODERATION	, value);
			cge.dispatch();
		}
		
		public function get confirmModeration():Boolean {
			return true;
		}
		
		
		/**
		 * allow trimming entries
		 */
		public function set allowTrimming(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_ALLOW_TRIMMING	, value);
			cge.dispatch();
		}
		
		public function get allowTrimming():Boolean {
			return true;
		}
		
		
		/**
		 * allow creating clips from an entry
		 */
		public function set allowClipping(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_ALLOW_CLIPPING	, value);
			cge.dispatch();
		}
		
		public function get allowClipping():Boolean {
			return true;
		}
		
		
		/**
		 * enanble provisioning of akamai live streams  
		 */
		public function set enableAkamaiLive(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.ENABLE_AKAMAI_LIVE	, value);
			cge.dispatch();
		}
		
		public function get enableAkamaiLive():Boolean {
			return true;
		}
		
		
		/**
		 * enable provisioning of Kaltura live streams 
		 */
		public function set enableKalturaLive(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.ENABLE_KALTURA_LIVE, value);
			cge.dispatch();
		}
		
		public function get enableKalturaLive():Boolean {
			return true;
		}
	}
}