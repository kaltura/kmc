package com.kaltura.validators
{
	import mx.resources.ResourceManager;
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	/**
	 * validates that a tested value doesn't match a predefined value. 
	 * @author Atar
	 */	
	public class IllegalValueValidator extends Validator {
		
		/**
		 * value to use for matching 
		 */		
		public var illegalValue:String;
		
		public function IllegalValueValidator()
		{
			super();
		}
		
		override protected function doValidation(value:Object):Array 
		{
			var results:Array = [];
			var checkedValue:String = value as String;
			
			// Call base class doValidation().
			results = super.doValidation(value);        
			
			// Return if there are errors.
			if (results.length > 0)
				return results;
			
			
			// Check first name field. 
			if (checkedValue == illegalValue) {
				results.push( new ValidationResult(true, "text", "illegalValue", 
					ResourceManager.getInstance().getString('windows', "illegalValueValidatorError")));
			}
						
			return results;
		}
	}
}