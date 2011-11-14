package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.kmc.modules.content.control.KedController;
	import com.kaltura.kmc.modules.content.events.KMCSearchEvent;

	/**
	 * thsi commands adds some KMC specific actions around the list action 
	 * @author Atar
	 */	
	public class DoSearchSequenceCommand extends KalturaCommand {
		
		
		override public function execute(event:CairngormEvent):void {
			var e:KMCSearchEvent = event as KMCSearchEvent;
			// reset selected entries list
			_model.selectedEntries = new Array();
			// search for new entries
			var cgEvent:SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, e.listableVo);
			KedController.getInstance().dispatch(cgEvent);
			// reset the refresh required flag
			_model.refreshEntriesRequired = false;
		}
	}
}