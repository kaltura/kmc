package com.kaltura.kmc.modules.studio.events
{
	import flash.events.Event;

	/**
	 * ApsFeatureEvent represents the event dispatched when a feature's properties change.<br>
	 * It also defines relevant constants used as event types.
	 */	
	public class ApsFeatureEvent extends Event
	{
		/**
		 * The constant defines the value of the type property of a featureSelected event object. 
		 */
		static public const FEATURE_SELECTED:String = "featureSelected";
		
		/**
		 * The constant defines the value of the type property of a featureDiselected event object. 
		 */		
		static public const FEATURE_DISELECTED:String = "featureDiselected";
		
		/**
		 * The constant defines the value of the type property of a featureOpenOptionScreen event object. 
		 */		
		static public const FEATURE_OPEN_OPTION_SCREEN:String = "featureOpenOptionScteen";
		
		
		public function ApsFeatureEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false) {
				super(type,bubbles,cancelable);
		}
		
		/**
		 * @inheritDoc 
		 */		
		override public function clone():Event {
			return super.clone();
		} 
		
	}
}