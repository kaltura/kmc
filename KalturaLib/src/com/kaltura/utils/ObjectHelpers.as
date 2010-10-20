/*
This file is part of the Kaltura Collaborative Media Suite which allows users
to do with audio, video, and animation what Wiki platfroms allow them to do with
text.

Copyright (C) 2006-2008  Kaltura Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

@ignore
*/
package com.kaltura.utils
{

	import com.hurlant.crypto.hash.MD5;
	import com.hurlant.util.Hex;
	
	import mx.utils.ObjectUtil;

	public class ObjectHelpers
	{
		public static function createDynamicStringGetter(target:Object, propertyName:String, getterFunction:Function):void
		{
			var outputObject:Object = new Object();
			outputObject.toString = getterFunction;
			target[propertyName] = outputObject;
		}

		public static function getMD5Checksum(obj:Object, excludedProperties:Array = null):String
		{
			var objCopy:Object = mx.utils.ObjectUtil.copy(obj);
			if (excludedProperties) removeProperties(objCopy, excludedProperties);

			var propertiesList:Array = getPropertiesList(objCopy);
			propertiesList.sort();
			var flattenedVars:String = propertiesList.join("");
			var md5:MD5 = new MD5();
			var checksum:String = Hex.fromArray(md5.hash(Hex.toArray(Hex.fromString(flattenedVars))));
			return checksum;
		}

		private static function getPropertiesList(obj:Object):Array
		{
			var sortableArray:Array = new Array();
			var i:int = 0;
			for (var key:String in obj)
			{
				if (obj[key] != null)
					sortableArray[i++] = key + obj[key];
			}
			return sortableArray;
		}

		private static function removeProperties(obj:Object, properties:Array):void
		{
			for each (var propertyName:String in properties)
			{
				delete obj[propertyName];
			}
		}

	  	public static function lowerNoUnderscore( params :Object ) : Object
    	{
    		var obj : Object = new Object
    		for ( var param : String in params )
    		{
    			obj[KStringUtil.camelize(param).toLowerCase()] = params[param];
    		}
    		return obj;
    	}
	}
}