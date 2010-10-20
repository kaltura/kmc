package com.kaltura.utils
{
	import flash.utils.describeType;
	
	public class Compare
	{
		public function Compare()
		{
		}
		/**
		 * compare variables and properties of 2 given objects 
		 * this function deliberately ignors the property uid. 
		 * @param object1
		 * @param object2
		 * @return 
		 * 
		 */		
		public static function compareObjects(object1:Object,object2:Object):Boolean
		{
			var ob1:Object = describeObject(object1);
			var ob2:Object = describeObject(object2);
			//run on obj1, check if the value exist in ob2 and check its value
			for (var o:Object in ob1)
			{
				if (ob2.hasOwnProperty(o))
				{
					if(ob1[o] != ob2[o] && o!="uid")
						return false;
					
				} else 
				{
					return false;
				}
			} 
			//run on obj2, check if the value exist in ob1 and check its value
			for (var p:Object in ob2)
			{
				if (ob1.hasOwnProperty(p))
				{
					if(ob2[p] != ob1[p] && p!="uid")
						return false;
					
				} else 
				{
					return false;
				}
			} 
			
			return true;
		}
		
        /**
         * Return an object that holds all variables and properties and their values 
         * @param obj
         * @return 
         * 
         */
        public static function describeObject(obj:Object):Object 
        { 
        	var ob:Object = new Object();
        	
            var classInfo:XML = describeType(obj);
            //map all variables
            for each (var v:XML in classInfo..variable) 
            {
                ob[v.@name] = obj[v.@name];
            }
            //map all properties
            for each (var a:XML in classInfo..accessor) 
            {
               	ob[a.@name] = obj[a.@name];
            } 
        	return ob;
        }

	}
}