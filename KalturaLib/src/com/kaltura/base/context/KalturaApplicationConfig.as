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
package com.kaltura.base.context
{
	public class KalturaApplicationConfig
	{
		//============== debug =================
		//urls:
		/**
		 *internal
		 */
		public var debugFromIDE:Boolean = false;
		/**
		 *deprecated
		 */
		public var XMLsource:String;

		//default values:
		/**
		 *deprecated
		 */
		public var defaultKshowID:String = '-1';
		/**
		 *deprecated
		 */
		public var defaultEntryID:String = '-1';

		//url paths:
		[Deprecated]
		/**
		 *use URLProcessing.
		 */
		public var serverURL:String;
		[Deprecated]
		/**
		 *use URLProcessing.
		 */
		public var partnerServicesUrl:String;
		[Deprecated]
		/**
		 *use URLProcessing.
		 */
		public var keditorServicesUrl:String;

		/**
		 * the base directory the cvf plugins (effects/overlays/transitions) should be downloaded from.
		 */
		public var pluginsFolder:String = "swf/plugins/cvesdk";
		/**
		 *namd of the directory the transition plugin modules should be loaded from.
		 */
		public var transitionsFolder:String = "transitions";
		/**
		 *namd of the directory the overlay plugin modules should be loaded from.
		 */
		public var overlaysFolder:String = "overlays";
		/**
		 *namd of the directory the effect plugin modules should be loaded from.
		 */
		public var effectsFolder:String = "effects";
		/**
		 *time delay between each call to getentries to validate pending entries.
		 */
		public var checkEntriesStatusDelay:uint = 30000;
	}
}