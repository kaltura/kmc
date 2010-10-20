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
package com.kaltura.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	/**
	 *	This class represents a custom metadata field 
	 * @author Michal
	 * 
	 */
	[Bindable]
	public class MetadataFieldVO implements IValueObject
	{
		public var id:String;
		public var name:String = "";
		public var type:int;
		public var optionalValues:Array = new Array();
		public var maxNumberOfValues:int;
		public var appearInSearch:Boolean;
		public var defaultLabel:String = "";
		public var displayedLabel:String = "";
		public var fullDescription:String = "";
		public var description:String = "";
		public var xpath:String = "";
		
		/**
		 * Constructs a new MetadataFieldVO 
		 * @param id the field's unique ID
		 * 
		 */		
		public function MetadataFieldVO (id:String):void
		{
			this.id = id;
		}
		
		public function Clone():MetadataFieldVO {
			var newField:MetadataFieldVO = new MetadataFieldVO(this.id);
			newField.name = this.name;
			newField.type = this.type;
			newField.maxNumberOfValues = this.maxNumberOfValues;
			newField.appearInSearch = this.appearInSearch ? true : false;
			newField.defaultLabel = this.defaultLabel;
			newField.displayedLabel = this.displayedLabel;
			newField.fullDescription = this.fullDescription;
			newField.description = this.description;
			newField.xpath = this.xpath;

			var newValues:Array = new Array();
			for each (var value:String in this.optionalValues) {
				newValues.push(value);
			}
			newField.optionalValues = newValues;

			return newField;
		}

	}
}