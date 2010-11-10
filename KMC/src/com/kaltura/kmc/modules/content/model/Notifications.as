package com.kaltura.kmc.modules.content.model
{
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class Notifications
	{
		public static const notificationMap : Object = { "1" : {"name":ResourceManager.getInstance().getStringArray('cms','addEntry') , "clientEnabled":true }, 
														 "2" : {"name":ResourceManager.getInstance().getStringArray('cms','updateEntryPermissions') , "clientEnabled":false},  
														 "3" : {"name":ResourceManager.getInstance().getStringArray('cms','deleteEntry'), "clientEnabled":false},
														 "4" : {"name":ResourceManager.getInstance().getStringArray('cms','blockEntry'), "clientEnabled":false},
														 "5" : {"name":ResourceManager.getInstance().getStringArray('cms','updateEntry'), "clientEnabled":false},
														 "6" : {"name":ResourceManager.getInstance().getStringArray('cms','updateEntryThumbnail'), "clientEnabled":false},
														 "7" : {"name":ResourceManager.getInstance().getStringArray('cms','updateEntryModeration'), "clientEnabled":false},
														 "21": {"name":ResourceManager.getInstance().getStringArray('cms','addUser'), "clientEnabled":false},
														 "26": {"name":ResourceManager.getInstance().getStringArray('cms','bannedUser'), "clientEnabled":false}};
	}
}