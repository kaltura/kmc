package com.kaltura.kmc.modules.content.business
{
	/**
	 * This interface should be implemented by every panel that requires fetching data from the server in order to load.
	 * @author Michal
	 * 
	 */	
	public interface IDrilldownPanel
	{
		/**
		 * will dispatch the panel's necessary events in order to load required data.
		 * 
		 */		
		function initData() : void ;
		
		/**
		 * will be triggered before the window closes. 
		 * 
		 */
		function destroy():void;
	}
	
}