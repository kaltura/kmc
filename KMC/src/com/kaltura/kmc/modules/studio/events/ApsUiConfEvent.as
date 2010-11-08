package com.kaltura.kmc.modules.studio.events
{
	import com.kaltura.kmc.modules.studio.vo.PlayerUiConfVo;
	
	import flash.events.Event;

	/**
	 * ApsUiConfEvent represents the event used when a new player is created.
	 */	
	public class ApsUiConfEvent extends Event
	{
		/**
		 * data object associated with this event 
		 */
		private var _data:PlayerUiConfVo; 
		
		/**
		 * The constant defines the value of the type property of a newPlayerChosen event object. 
		 */		
		public static const NEW_PLAYER_CHOSEN:String = "newPlayerChosen";
		
		public function ApsUiConfEvent(	type:String,
 										o:PlayerUiConfVo=null,
 										bubbles:Boolean = false ,
										cancelable : Boolean = false) {
				super(type,bubbles,cancelable);
				_data= o;
		}
		
		
		/**
		 * @inheritDoc 
		 */		
		override public function clone():Event {
			return new ApsUiConfEvent(this.type, this._data, this.bubbles,this.cancelable);
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