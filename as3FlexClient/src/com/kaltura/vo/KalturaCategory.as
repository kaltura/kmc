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
// Copyright (C) 2006-2011  Kaltura Inc.
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
package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaCategory extends BaseFlexVo
	{
		/** 
		* 		* */ 
		public var id : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var parentId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var depth : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var partnerId : int = int.MIN_VALUE;

		/** 
		* The name of the Category.		* */ 
		public var name : String = null;

		/** 
		* 		* */ 
		public var fullName : String = null;

		/** 
		* 		* */ 
		public var entriesCount : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var createdAt : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var updatedAt : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var description : String = null;

		/** 
		* 		* */ 
		public var tags : String = null;

		/** 
		* If category will be returned for list action.		* */ 
		public var appearInList : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var privacy : int = int.MIN_VALUE;

		/** 
		* If Category members are inherited from parent category or set manualy.		* */ 
		public var inheritanceType : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var userJoinPolicy : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var defaultPermissionLevel : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var owner : String = null;

		/** 
		* 		* */ 
		public var directEntriesCount : int = int.MIN_VALUE;

		/** 
		* Category external id, controlled and managed by the partner.		* */ 
		public var referenceId : String = null;

		/** 
		* 		* */ 
		public var contributionPolicy : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var membersCount : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var pendingMembersCount : int = int.MIN_VALUE;

		/** 
		* Set privacy context for search entries that assiged to private and public categories. the entries will be private if the search context is set with those categories.		* */ 
		public var privacyContext : String = null;

		/** 
		* 		* */ 
		public var privacyContexts : String = null;

		/** 
		* 		* */ 
		public var status : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var inheritedParentId : int = int.MIN_VALUE;

		/** 
		* a list of attributes which may be updated on this object 
		* */ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('parentId');
			arr.push('name');
			arr.push('description');
			arr.push('tags');
			arr.push('appearInList');
			arr.push('privacy');
			arr.push('inheritanceType');
			arr.push('userJoinPolicy');
			arr.push('defaultPermissionLevel');
			arr.push('owner');
			arr.push('referenceId');
			arr.push('contributionPolicy');
			arr.push('privacyContext');
			return arr;
		}

		/** 
		* a list of attributes which may only be inserted when initializing this object 
		* */ 
		public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

	}
}
