package com.kaltura.kmc.modules.analytics.model
{
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class Notifications
	{
		public static const notificationMap : Object = { "1" : {"name":ResourceManager.getInstance().getStringArray('kmc','addEntry') , "clientEnabled":true }, 
														 "2" : {"name":ResourceManager.getInstance().getStringArray('kmc','updateEntryPermissions') , "clientEnabled":false},  
														 "3" : {"name":ResourceManager.getInstance().getStringArray('kmc','deleteEntry'), "clientEnabled":false},
														 "4" : {"name":ResourceManager.getInstance().getStringArray('kmc','blockEntry'), "clientEnabled":false},
														 "5" : {"name":ResourceManager.getInstance().getStringArray('kmc','updateEntry'), "clientEnabled":false},
														 "6" : {"name":ResourceManager.getInstance().getStringArray('kmc','updateEntryThumbnail'), "clientEnabled":false},
														 "7" : {"name":ResourceManager.getInstance().getStringArray('kmc','updateEntryModeration'), "clientEnabled":false},
														 "21": {"name":ResourceManager.getInstance().getStringArray('kmc','addUser'), "clientEnabled":false},
														 "26": {"name":ResourceManager.getInstance().getStringArray('kmc','bannedUser'), "clientEnabled":false}};
	}
}