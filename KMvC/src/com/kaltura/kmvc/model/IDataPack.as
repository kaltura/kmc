package com.kaltura.kmvc.model
{
	/**
	 * Marker interface used to mark custom DataPacks.
	 */
	public interface IDataPack {
		
		/**
		 * is this data pack shared across models
		 */		
		function get shared():Boolean;
		function set shared(value:Boolean):void;
		
	}
}