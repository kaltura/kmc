package com.kaltura.kmc.modules.content.view.content
{
	import com.kaltura.kmc.business.PermissionManager;
	import com.kaltura.kmc.modules.content.events.ChangeModelEvent;
	
	import mx.containers.VBox;
	import mx.events.FlexEvent;
	
	/**
	 * This is a dummy panel used to update the content model without using one 
	 * of the viewstack panels directly. </br>
	 * we can't trigger PermissionManager.applyAllPermissions directly from 
	 * Content, because the inner panels are not ready yet, so we'll use this one. 
	 * @author Atar
	 * 
	 */	
	public class GeneralPermissionsSetter extends VBox {
		
		public function GeneralPermissionsSetter()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		protected function creationCompleteHandler(e:FlexEvent):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			PermissionManager.getInstance().applyAllAttributes(this, this.id);
		}
		
		
		
		/**
		 * allow roles and permissions to decide if user should 
		 * see custom metadata related things.
		 */
		public function set enableCustomData(value:Boolean):void
		{
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_CUSTOM_METADATA, value);
			cge.dispatch();
		}
		
		/**
		 * allow roles and permissions to decide if user should 
		 * see distribution related things.
		 */
		public function set enableDistribution(value:Boolean):void
		{
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_DISTRIBUTION, value);
			cge.dispatch();
		}
		
		
		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get enableCustomData():Boolean
		{
			return true;
			//TODO * return the real value from the model ?
		}
		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get enableDistribution():Boolean
		{
			return true;
			//TODO * return the real value from the model ?
		}
		/**
		 * allow roles and permissions to decide if user should 
		 * see embed code.
		 */
		public function set showPlaylistEmbedCode(value:Boolean):void
		{
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_PLAYLIST_EMBED_STATUS, value);
			cge.dispatch();
		}
		
		
		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get showPlaylistEmbedCode():Boolean
		{
			return true;
			//TODO * return the real value from the model ?
		}
		/**
		 * allow roles and permissions to decide if can update custom data data
		 */
		public function set enableUpdateCustomData(value:Boolean):void
		{
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_UPDATE_CUSTOM_DATA, value);
			cge.dispatch();
		}
		
		
		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get enableUpdateCustomData():Boolean
		{
			return true;
			//TODO * return the real value from the model ?
		}
		
		public function set showSinglePlayerEmbedCode (value:Boolean) : void
		{
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_SINGLE_ENTRY_EMBED_STATUS, value);
			cge.dispatch();
		}
		
		public function get showSinglePlayerEmbedCode():Boolean
		{
			return true;
			//TODO * return the real value from the model ?
		}
		
		
		public function set enableRemoteStorage(value:Boolean):void {
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_REMOTE_STORAGE, value);
			cge.dispatch();
		}
		
		public function get enableRemoteStorage():Boolean {
			return true;
		}
	}
}