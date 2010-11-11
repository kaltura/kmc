package com.kaltura.kmc.modules.content.model
{
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	/**
	 * Defines the second level navigation in <code>Content.secTln</code> 
	 */	
	public class TabsData
	{						
		[Bindable]
		public var contentTabs : ArrayCollection = new ArrayCollection([ ResourceManager.getInstance().getString('cms','entriesTitle'),
																	     ResourceManager.getInstance().getString('cms','moderation'),
																	     ResourceManager.getInstance().getString('cms','playlistTitle'),
																	     ResourceManager.getInstance().getString('cms','externalSyndication'),
																	     ResourceManager.getInstance().getString('cms','bulkUpload')]);
																	
		public var selectedTlnTabIndexArr : Array = [0,0,0,0,0,0,0];
		
	}
}