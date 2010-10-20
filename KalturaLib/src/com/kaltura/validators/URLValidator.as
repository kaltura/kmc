package com.kaltura.validators
{
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	import mx.utils.URLUtil;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class URLValidator extends Validator
	{
        // Define Array for the return value of doValidation().
        private var results:Array;
		 
		public function URLValidator()
		{
			super();
		}
		
		override protected function doValidation(value:Object):Array 
		{
			var url:String = StringUtil.trim(value as String);
			 
        	// Clear results Array.
            results = [];
            
            // Call base class doValidation().
            results = super.doValidation(value);        
			
			// Return if there are errors.
            if (results.length > 0)
                return results;
                
           
			// Check first name field. 
            if ( ! URLUtil.isHttpURL( url ) &&  ! URLUtil.isHttpsURL( url ) ) 
            {
                results.push( new ValidationResult(true, "url", "vlaueIsNotURL", ResourceManager.getInstance().getString('windows', "urlValidatorError")));
            }
            else
            {
            	if((url == 'http://') || (url == 'https://') || (url.indexOf('.') == -1) || 
            	   (url.indexOf('..') != -1) || (url.indexOf(' ') != -1))
            	   {
            	   		results.push( new ValidationResult(true, "url", "vlaueIsNotURL", ResourceManager.getInstance().getString('windows', "urlValidatorError")));
            	   }
            }
            
            return results;
		}
	}
}