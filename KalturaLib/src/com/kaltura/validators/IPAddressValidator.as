package com.kaltura.validators {
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	//Class should extend mx.validators.Validator
	public class IPAddressValidator extends Validator {

		private var _defaultError:String = "You must enter a valid IP Address";
		
		public function IPAddressValidator() {
			// Call base class constructor.
			super();
		}


		// Class should override the doValidation() method.
		// doValidation method should accept an Object type parameter
		override protected function doValidation(value:Object):Array {
			// create an array to return.
			var validatorResults:Array = new Array();
			// Call base class doValidation().
			validatorResults = super.doValidation(value);
			// Return if there are errors , i.e. required
			if (validatorResults.length > 0)
				return validatorResults;
			
			var RegPattern:RegExp = /\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/;
			var a:Array = RegPattern.exec(String(value));

			if (a == null) {
				validatorResults.push(new ValidationResult(true, null, "IPAddressError", _invalidIPError));
				return validatorResults;
			}
			return validatorResults;
		}


		/**
		 *  @private
		 *  Storage for the invalidIPError property.
		 */
		private var _invalidIPError:String;

		/**
		 *  @private
		 */
		private var invalidIPErrorOverride:String;


		[Inspectable(category = "Errors", defaultValue = "null")]

		/**
		 *  Error message when a value is not a valid IP address.
		 *
		 *  @default "You must enter a valid IP Address."
		 */
		public function get invalidIPError():String {
			return _invalidIPError;
		}


		/**
		 *  @private
		 */
		public function set invalidIPError(value:String):void {
			invalidIPErrorOverride = value;

			_invalidIPError = value != null ? value : _defaultError;
		}


		override protected function resourcesChanged():void {
			super.resourcesChanged();
			invalidIPError = invalidIPErrorOverride;
		}
	}
}
