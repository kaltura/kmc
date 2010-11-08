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

		public function get path():String
		{
			return _path;
		}

		public function set attribute(value:String):void
		{
			_attribute = value;
		}

		public function set value(value:Object):void
		{
			_value = value;
		}


	}
}