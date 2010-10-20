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
	
	import mx.collections.ArrayCollection;

	/**
	 *	This class represents a profile of metadata custom fields
	 * @author Michal
	 * 
	 */
	[Bindable]
	public class KMCMetadataProfileVO implements IValueObject
	{
		public var profile:KalturaMetadataProfile;
		public var metadataFieldVOArray:ArrayCollection = new ArrayCollection();
		//represents the xsd from the profile, in an XML representation
		public var xsd:XML;
		public var viewXML:XML;
		
		/**
		 *  Constructs a new KMCMetadataProfileVO class
		 * 
		 */			
		public function KMCMetadataProfileVO ():void
		{
		}

	}
}