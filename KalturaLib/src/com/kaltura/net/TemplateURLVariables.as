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
package com.kaltura.net
{
	import com.kaltura.utils.ObjectHelpers;

	import flash.net.URLVariables;

	dynamic public class TemplateURLVariables extends URLVariables
	{
		public static var signatureKeyName:String = "kalsig";
		//public static var defaultValues:Object;

		public function TemplateURLVariables(defaultValues:Object, source:String=null)
		{
			super(source);

			ObjectHelpers.createDynamicStringGetter(this, signatureKeyName, getSignature);
			addDefaultValues(defaultValues);
		}

		private function getSignature():String
		{
			return ObjectHelpers.getMD5Checksum(this, [signatureKeyName]);
		}

		private function addDefaultValues(defaultValues:Object):void
		{
			for (var propertyName:String in defaultValues)
			{
				this[propertyName] = defaultValues[propertyName];
			}
		}

	}
}