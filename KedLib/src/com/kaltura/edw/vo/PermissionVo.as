package com.kaltura.edw.vo
{
	public class PermissionVo
	{
		private var _path:String;
		private var _attributes:Object;
		
		public function PermissionVo(path:String , attributes:Object)
		{
			_path = path;
			_attributes = attributes;
		}

		public function get path():String
		{
			return _path;
		}

		public function get attributes():Object
		{
			return _attributes;
		}


	}
}