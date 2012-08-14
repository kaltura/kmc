package com.kaltura.autocomplete.itemRenderers
{
	import com.kaltura.autocomplete.itemRenderers.selection.UserSelectedItem;
	
	public class UserFilterSelectedItem extends UserSelectedItem
	{
		override protected function getUnregisteredMsg(userId:String):String{
			return resourceManager.getString("autocomplete", "unregisteredUserForFilterMsg");
		}
	}
}