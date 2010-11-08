package com.kaltura.kmc.utils
{
	/**
	 * This class is a util that allows to change a value of a component by it's path in the layout.  
	 * @author Eitan
	 * 
	 */
	public class ApplyAttribute
	{
		//singleton methods
		/**
		 * singleton instance 
		 */		
		private static var _instance:ApplyAttribute;
		
		/**
		 * This function recieves a path to a component IE myCompo1.myCompo2.myButton
		 * a starting target (instance of a uiComponent),a propery on the target to change
		 * and a new value.
		 * @param startComponent
		 * @param compoentPath
		 * @param componentProperty
		 * @param newValue
		 */
		public function apply(startComponent:Object ,compoentPath:String , componentProperty:String , newValue:Object):void
		{
			var chain:Array = compoentPath.split(".");
			var o:Object = startComponent;
			for (var i:uint; i<chain.length;i++)
			{
				// next in chain
				o=o[chain[i]];
			}
			//TODO: consider try & catch  
			o[componentProperty] = newValue;
			
		}
		

		

		
		
		/**
		 * singleton means of retreiving an instance of the 
		 * <code>ApplyAttribute</code> class.
		 */		
		public static function getInstance():ApplyAttribute {
			if (_instance == null) {
				_instance = new ApplyAttribute(new Enforcer());
			}
			return _instance;
		}
		
		
		/**
		 * @param enforcer	singleton garantee
		 */		
		public function ApplyAttribute(enforcer:Enforcer) 
		{
			
		}
		
		
	}
}
class Enforcer {
	
}



