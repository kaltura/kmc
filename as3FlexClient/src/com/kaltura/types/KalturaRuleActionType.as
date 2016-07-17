// ===================================================================================================
//                           _  __     _ _
//                          | |/ /__ _| | |_ _  _ _ _ __ _
//                          | ' </ _` | |  _| || | '_/ _` |
//                          |_|\_\__,_|_|\__|\_,_|_| \__,_|
//
// This file is part of the Kaltura Collaborative Media Suite which allows users
// to do with audio, video, and animation what Wiki platfroms allow them to do with
// text.
//
// Copyright (C) 2006-2016  Kaltura Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// @ignore
// ===================================================================================================
package com.kaltura.types
{
	public class KalturaRuleActionType
	{
		public static const DRM_POLICY : String = 'drm.DRM_POLICY';
		public static const BLOCK : String = '1';
		public static const PREVIEW : String = '2';
		public static const LIMIT_FLAVORS : String = '3';
		public static const ADD_TO_STORAGE : String = '4';
		public static const LIMIT_DELIVERY_PROFILES : String = '5';
		public static const SERVE_FROM_REMOTE_SERVER : String = '6';
		public static const REQUEST_HOST_REGEX : String = '7';
		public static const LIMIT_THUMBNAIL_CAPTURE : String = '8';
	}
}
