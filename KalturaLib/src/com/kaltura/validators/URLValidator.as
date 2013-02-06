package com.kaltura.validators {
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	import mx.utils.URLUtil;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class URLValidator extends Validator {

		
		private var _defaultError:String;
		
		public function URLValidator() {
			_defaultError = ResourceManager.getInstance().getString('windows', 'urlValidatorError');
			super();
			
		}


		override protected function doValidation(value:Object):Array {
			var url:String = StringUtil.trim(value as String);

			// Create results Array.
			var results:Array = [];

			// Call base class doValidation().
			results = super.doValidation(value);

			// Return if there are errors.
			if (results.length > 0)
				return results;

			// allow no value
			if (!required && !url) {
				return results;
			}
			
			// Check url. 
			if (!URLUtil.isHttpURL(url) && !URLUtil.isHttpsURL(url)) {
				results.push(new ValidationResult(true, "url", "invalidURL", _invalidURLError));
			}
			else {
				if ((url == 'http://') || (url == 'https://') || (url.indexOf('.') == -1) || (url.indexOf('..') != -1) || (url.indexOf(' ') != -1)) {
					results.push(new ValidationResult(true, "url", "invalidURL", _invalidURLError));
				}
			}

			return results;
		}
		
		
		/**
		 *  @private
		 *  Storage for the invalidURLError property.
		 */
		private var _invalidURLError:String;
		
		/**
		 *  @private
		 */
		private var invalidURLErrorOverride:String;
		
		
		[Inspectable(category = "Errors", defaultValue = "null")]
		
		/**
		 *  Error message when a value is not a valid URL.
		 *
		 *  @default ('windows', 'urlValidatorError')
		 */
		public function get invalidURLError():String {
			return _invalidURLError;
		}
		
		
		/**
		 *  @private
		 */
		public function set invalidURLError(value:String):void {
			invalidURLErrorOverride = value;
			
			_invalidURLError = value != null ? value : _defaultError;
		}
		
		
		override protected function resourcesChanged():void {
			super.resourcesChanged();
			invalidURLError = invalidURLErrorOverride;
		}
	}
}
