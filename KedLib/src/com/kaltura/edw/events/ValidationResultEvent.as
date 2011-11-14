package com.kaltura.edw.events {

	/**
	 * results of a call to <code>IDrilldownPanel.validate()</code> dispatched by the panel.
	 * @author Atar
	 */
	public class ValidationResultEvent extends InternalKedEvent {

		/**
		 * defines the value of the type attribute for the <code>validationComplete</code> event  
		 */
		public static const VALIDATION_COMPLETE:String = "validationComplete";

		private var _success:Boolean;

		private var _errorMessage:String;
		
		private var _errorTitle:String;


		public function ValidationResultEvent(type:String, success:Boolean, errorMesage:String = null, errorTitle:String=null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_success = success;
			_errorMessage = errorMesage;
		}


		/**
		 * whether validation passed
		 */		
		public function get success():Boolean {
			return _success;
		}


		/**
		 * message to show the user in case success=false.
		 * @internal 
		 * Passed from the panel itself so value can be determined by loaded panels' locale file.
		 */
		public function get errorMessage():String {
			return _errorMessage;
		}

		/**
		 * title of message to show the user in case success=false.
		 * @internal 
		 * Passed from the panel itself so value can be determined by loaded panels' locale file.
		 */
		public function get errorTitle():String {
			return _errorTitle;
		}


	}
}