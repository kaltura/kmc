package com.kaltura.kmc.vo
{
	public class PermissionVo
	{
		private var _path:String;
		private var _attribute:String;
		private var _value:Object;
		
		
		public function PermissionVo(path:String,attribute:String,value:Object )
		{
			_path = path;
			_value = value ;
			_attribute = attribute;
		}

		/**
		 * Path for the UI component - IE 'content.manage.saveBtn' 
		 * @return 
		 * 
		 */
		public function get path():String
		{
			return _path;
		}
		/**
		 * The attribute to change - IE visible 
		 * @param value
		 * 
		 */
		public function get attribute():void
		{
			return _attribute;
		}
		/**
		 * The new value to apply - IE true 
		 * @param value
		 * 
		 */
		public function get value():void
		{
			return _value;
		}


	}
}