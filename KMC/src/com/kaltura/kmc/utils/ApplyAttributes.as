package com.kaltura.kmc.utils
{
	import flash.net.getClassByAlias;
	import flash.utils.describeType;

	/**
	 * This class is a util that allows to change a value of a component by it's path in the layout.  
	 * @author Eitan
	 * 
	 */
	public class ApplyAttributes
	{
		//singleton methods
		/**
		 * singleton instance 
		 */		
		private static var _instance:ApplyAttributes;
		
		/**
		 *  
		 * @param startComponent
		 * @param actions
		 * 
		 */
		public function applyAttributes(startComponent:Object , actions:Array):void
		{
			
		}
		/**
		 * This function recieves a path to a component IE myCompo1.myCompo2.myButton
		 * a starting target (instance of a uiComponent),a propery on the target to change
		 * and a new value.
		 * @param startComponent
		 * @param compoentPath
		 * @param componentProperty
		 * @param newValue
		 */
		public function apply(startComponent:Object ,compoentPath:String , componentProperty:String , newValue:*):void
		{
			var chain:Array = compoentPath.split(".");
			var o:Object = startComponent;
			for (var i:uint; i<chain.length;i++) {
				// next in chain
				o=o[chain[i]];
			}
			var dt:XML = describeType(o);
			if(dt.@isDynamic.toString() == "true") {
				// dynamic type, always assign.
				o[componentProperty] = newValue;
			} 
			else if (o.hasOwnProperty(componentProperty)) {
				// statics type, only assign if attribute exists
				o[componentProperty] = newValue;
			}
			else {
				trace("cannot push attribute " +  componentProperty + 
					"to component of type " + dt.@name.toString());
			}
		}
		

		

		
		
		/**
		 * singleton means of retreiving an instance of the 
		 * <code>ApplyAttribute</code> class.
		 */		
		public static function getInstance():ApplyAttributes {
			if (_instance == null) {
				_instance = new ApplyAttributes(new Enforcer());
			}
			return _instance;
		}
		
		
		/**
		 * @param enforcer	singleton garantee
		 */		
		public function ApplyAttributes(enforcer:Enforcer) 
		{
			
		}
		
		
	}
}
class Enforcer {
	
}



