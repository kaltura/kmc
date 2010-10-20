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
package com.kaltura.vo.importees
{
	import com.kaltura.vo.MediaMetaDataVO;

	[Bindable]
	public class ImportURLVO extends BaseImportVO
	{
		//public var thumbURL:String;
		public var fileUrl:String;
		public var sourceLink:String;
		/**
		* This  entry unique id which is given by the search service to allow getting media info for this file.
		*/
		public var uniqueID:String;
		public var credit:String;
		public var license:String;
		public var flashPlaybackType:String

		public function ImportURLVO(metaData:MediaMetaDataVO = null, mediaProviderId:String = null, mediaTypeCode:int = -1):void
		{
			super(metaData, mediaProviderId, mediaTypeCode);
		}

		override public function mergeWith(importVO:BaseImportVO):void
		{
			var mergeFrom:ImportURLVO = importVO as ImportURLVO;
			//if (!this.thumbURL)
				//this.thumbURL = mergeFrom.thumbURL;

			if (!this.fileUrl)
				this.fileUrl = mergeFrom.fileUrl;

			if (!this.sourceLink)
				this.sourceLink = mergeFrom.sourceLink;

			if (!this.credit)
				this.credit = mergeFrom.credit;

			if (!this.license)
				this.license = mergeFrom.license;

			if (!this.flashPlaybackType)
				this.flashPlaybackType = mergeFrom.flashPlaybackType;

			super.mergeWith(mergeFrom);

		}
	}
}