package com.kaltura.kmc.modules.studio.vo
{
	/**
	 * The KeyValVo holds data relevant for additional player parameters. 
	 */	
	public class KeyValVo
	{
		public var key:String;
		public var val:String;
		public var overridable:Boolean;
		
		public function KeyValVo()
		{
			
		}
		
		public function validate():Boolean
		{
			if (key && val)
				return true;
			return false;
		}

	}
}