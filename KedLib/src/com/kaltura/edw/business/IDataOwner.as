package com.kaltura.edw.business
{
	/**
	 * This interface allows loading data the filter needs only when it is needed.
	 * Any uicomponent which has a filter in it, should trigger filter data load using the 
	 * <Code>FilterEvent.LoadFilterData</code> event, passing itself as the caller.
	 * When data is loaded, the caller's <code>onFilterDataLoaded()</code> is triggered
	 * by <code>LoadFilterDataCommand</code> command.
	 * @author Atar
	 * 
	 */
	public interface IDataOwner {
		
		/**
		 * triggered when the filter data is done loading and the filter's
		 * <code>init()</code> method can (should) be triggered 
		 */		
		function onRequestedDataLoaded():void;
	}
}