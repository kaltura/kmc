package com.kaltura.kmc.modules.studio.business.playerlist
{
	import flash.events.Event;

	/**
	 * ApsConfirmDeleteEvent class represents the event dispatched when
	 * user asks to delete a player. <br>
	 * It also defines relevant constants for event types.
	 */	
	public class ApsConfirmDeleteEvent extends Event
	{
		/**
		 * The ApsConfirmDeleteEvent.APROVE_DELETE_PLAYER constant defines the value of 
		 * the type property of an approve-delete-player event object. 
		 */		
		public static const APROVE_DELETE_PLAYER:String = "approveDeletePlayer";
		
		/**
		 * The ApsConfirmDeleteEvent.CANCEL_DELETE_PLAYER constant defines the value of 
		 * the type property of an cancel-delete-player event object. 
		 */
		public static const CANCEL_DELETE_PLAYER:String = "cancelDeletePlayer";
		
		private var _data:Object; 
		
		/**
		 * Constructor. 
		 * @param type	event type
		 * @param o		event data
		 * @param bubbles	event bubbles
		 * @param cancelable	event cancelable
		 */		
		public function ApsConfirmDeleteEvent(type:String,
 												o:Object=null,
 												bubbles:Boolean = false ,
												cancelable : Boolean = false) {
				super(type,bubbles,cancelable);
				_data= o;
		}
		
		/**
		 * @inheritDoc 
		 */		
		override public function clone():Event {
			return new ApsConfirmDeleteEvent(this.type, this.data, this.bubbles,this.cancelable);
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
