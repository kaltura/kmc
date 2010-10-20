package com.kaltura.validators
{
	import mx.resources.ResourceManager;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	public class ListValidator extends Validator
	{
		// Define Array for the return value of doValidation().
        private var results:Array;
		 
		public function ListValidator()
		{
			super();
		}
		
		override protected function doValidation(value:Object):Array 
		{
			var selectedItems:Array = value as Array;
			 
        	// Clear results Array.
            results = [];
            
            // Call base class doValidation().
            results = super.doValidation(value);        
			
			// Return if there are errors.
            if (results.length > 0)
                return results;
                
           
			
            if (selectedItems.length == 0) 
            {
                results.push( new ValidationResult(true, "selectedItems", "valueIsEmpty", ResourceManager.getInstance().getString('windows', "listValidatorError")));
            }
            
            return results;
		}

	}
}