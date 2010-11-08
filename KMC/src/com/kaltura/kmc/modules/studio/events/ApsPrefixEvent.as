package com.kaltura.kmc.modules.studio.events
{
	import flash.events.Event;

	
	public class ApsPrefixEvent extends Event
	{

		/**
		 * @copy #data 
		 */		
		private var _data:Object; 
		
		/**
		 * The constant defines the value of the type property of a newPrefixToUpdate event object. 
		 */		
		public static const NEW_PREFIX_TO_UPDATE:String = "newPrefixToUpdate";
		
		public function ApsPrefixEvent(	type:String,
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
			return new ApsPrefixEvent(this.type, this._data, this.bubbles,this.cancelable);
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