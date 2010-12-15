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
		 * see livestream related issues.
		 */
		public function set enableLivestream(value:Boolean):void
		{
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_LIVESTREAM_ENABLED, value);
			cge.dispatch();
		}
		
		
		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get enableLivestream():Boolean
		{
			return true;
		}
		
		/**
		 * allow roles and permissions to decide if user should 
		 * see embed code.
		 */
		public function set showEmbedCode(value:Boolean):void
		{
			// raise a command to change the model
			var cge:ChangeModelEvent = new ChangeModelEvent(ChangeModelEvent.SET_EMBED_STATUS, value);
			cge.dispatch();
		}
		
		
		/**
		 * @private
		 * permission manager needs the getter to get the parameter type,
		 * NOTE: the value is never changed!!
		 * */
		public function get showEmbedCode():Boolean
		{
			return true;
			//TODO * return the real value from the model ?
		}
	}
}