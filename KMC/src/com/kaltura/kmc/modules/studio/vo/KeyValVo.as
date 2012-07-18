package com.kaltura.kmc.modules.studio.vo
{
	import mx.resources.ResourceManager;

	/**
	 * The KeyValVo holds data relevant for additional player parameters. 
	 */	
	public class KeyValVo
	{
		public var key:String;
		public var val:String;
		public var overridable:Boolean;
		
		[Bindable]
		public var error:String;
		
		
		public function validate():Boolean
		{
			if (key && val) {
				try {
					XML('<var key="' + key + '" value="' + val + '" />');
				}
				catch(e:Error) {
					error = ResourceManager.getInstance().getString('aps', 'invalidKeyVal');
					return false;
				}
				error = null;
				return true;
			}
			error = ResourceManager.getInstance().getString('aps', 'invalidKeyVal');
			return false;
		}

	}
}