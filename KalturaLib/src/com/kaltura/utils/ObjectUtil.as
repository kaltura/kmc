package com.kaltura.utils
{
	import flash.utils.describeType;
	
	/**
	 * ObjectUtil class holds different utilities for use with objects
	 */	
	public class ObjectUtil
	{
		/**
		 * retreives a list of all keys on the given object 
		 * @param obj	the object to operate on
		 * @return an array with all keys as strings
		 */		
		public static function getObjectAllKeys( obj : Object ) : Array
		{
			var arr : Array = new Array();
			arr = getObjectStaticKeys( obj );
			arr = arr.concat( getObjectDynamicKeys( obj ) );
			return arr;
		}
		
		/**
		 * retreives a list of all the keys defined at authoring time. 
		 * @param obj	the object to operate on
		 * @return an array with all keys as strings
		 */		
		public static function getObjectStaticKeys( obj : Object ) : Array
		{
			var arr : Array = new Array();
			var classInfo:XML = describeType(obj);

			for each (var v:XML in classInfo..accessor) 
				arr.push( v.@name.toString() );

			return arr;
		}
		
		/**
		 * retreives a list of all the keys defined at runtime (for dynamic objects). 
		 * @param obj	the object to operate on
		 * @return an array with all keys as strings
		 */
		public static function getObjectDynamicKeys( obj : Object ) : Array
		{
			var arr : Array = new Array();
			for( var str:String in obj )
				arr.push( str );

			return arr;
		}
		
		/**
		 * retreives a list of all the values on the given object. 
		 * @param obj	the object to operate on
		 * @return an array with all values
		 */
		public static function getObjectAllValues( obj : Object ) : Array
		{
			var arr : Array = new Array();
			arr = getObjectStaticValues( obj );
			arr = arr.concat( getObjectDynamicValues( obj ) );
			return arr;
		}
		
		/**
		 * retreives a list of all the values of keys defined at authoring time. 
		 * @param obj	the object to operate on
		 * @return an array with all values
		 */
		public static function getObjectStaticValues( obj : Object ) : Array
		{
			var arr : Array = new Array();
			var classInfo:XML = describeType(obj);
			for each (var v:XML in classInfo..variable) 
				arr.push( obj[v.@name] );
			
			return arr;
		}
		
		/**
		 * retreives a list of all the values of keys defined at runtime (for dynamic objects). 
		 * @param obj	the object to operate on
		 * @return an array with all values
		 */
		public static function getObjectDynamicValues( obj : Object ) : Array
		{
			var arr : Array = new Array();
			for( var str:String in obj )
				arr.push( obj[str] );
				
			return arr;
		}
	}
}