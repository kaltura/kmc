package com.kaltura.validators
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	//Class should extend mx.validators.Validator
	public class IPAddressValidator extends Validator 
	{
	
		public function IPAddressValidator() 
		{
			// Call base class constructor.
			super();
		}
		
		// Class should override the doValidation() method.
		// doValidation method should accept an Object type parameter
		override protected function doValidation(value:Object):Array {
		// create an array to return.
		var ValidatorResults:Array = new Array();
		// Call base class doValidation().
		
		ValidatorResults = super.doValidation(value);
		// Return if there are errors.
		if (ValidatorResults.length > 0)
		return ValidatorResults;
		if (String(value).length == 0)
		return ValidatorResults;
		var RegPattern:RegExp = /\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/;
		var a:Array = RegPattern.exec(String(value));
		
		if (a == null){
			ValidatorResults.push(new ValidationResult(true, null, "IPAddress Error","You must enter an IP Address"));
			return ValidatorResults;
		}
		return ValidatorResults;
		}
	}
}