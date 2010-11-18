package com.kaltura.kmc.modules.account.model
{
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class Notifications
	{
		public static const notificationMap : Object = { "1" : {"name":ResourceManager.getInstance().getStringArray('account','addEntry') , "clientEnabled":true }, 
														 "2" : {"name":ResourceManager.getInstance().getStringArray('account','updateEntryPermissions') , "clientEnabled":false},  
														 "3" : {"name":ResourceManager.getInstance().getStringArray('account','deleteEntry'), "clientEnabled":false},
														 "4" : {"name":ResourceManager.getInstance().getStringArray('account','blockEntry'), "clientEnabled":false},
														 "5" : {"name":ResourceManager.getInstance().getStringArray('account','updateEntry'), "clientEnabled":false},
														 "6" : {"name":ResourceManager.getInstance().getStringArray('account','updateEntryThumbnail'), "clientEnabled":false},
														 "7" : {"name":ResourceManager.getInstance().getStringArray('account','updateEntryModeration'), "clientEnabled":false},
														 "21": {"name":ResourceManager.getInstance().getStringArray('account','addUser'), "clientEnabled":false},
														 "26": {"name":ResourceManager.getInstance().getStringArray('account','bannedUser'), "clientEnabled":false}};
	}
}