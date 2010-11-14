package com.kaltura.kmc.modules.studio.events
{
	import flash.events.Event;

	/**
	 * ApsNavigationEvent represents the event of navigation inside the application.
	 */	
	public class ApsNavigationEvent extends Event
	{
		/**
		 * @copy #data 
		 */		
		private var _data:Object; 
		
		/**
		 * The constant defines the value of the type property of a navigateToPlayersList event object. 
		 */		
		public static const NAVIGATE_TO_PLAYERS_LIST:String = "navigateToPlayersList";
		
		/**
		 * The constant defines the value of the type property of a newPlayer event object. 
		 */
		public static const NEW_PLAYER:String = "newPlayer";
		
		/**
		 * The constant defines the value of the type property of a editPlayer event object. 
		 */
		public static const EDIT_PLAYER:String = "editPlayer";
		
		/**
		 * The constant defines the value of the type property of a closeWizard event object. 
		 */
		public static const CLOSE_WIZARD:String = "closeWizard";
		
		
		
		public function ApsNavigationEvent(	type:String,
 											o:Object=null,
 											bubbles:Boolean = false ,
											cancelable : Boolean = false) {
				super(type,bubbles,cancelable);
				_data = o;
		}
		
		
		/**
		 * @inheritDoc 
		 */		
		override public function clone():Event {
			return new ApsNavigationEvent(this.type, this.data, this.bubbles,this.cancelable);
		}
		

		/**
		 * data object associated with this event 
		 */
		public function get data():Object
		{
			return _data;
		}

	}
}