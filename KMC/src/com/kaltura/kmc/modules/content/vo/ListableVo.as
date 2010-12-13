package com.kaltura.kmc.modules.content.vo
{
	import com.kaltura.controls.Paging;
	
	import mx.collections.ArrayCollection;
	
	public class ListableVo
	{
		[Bindable]
		/**
		 * data being listed 
		 */		
		public var arrayCollection:ArrayCollection;
		
		/**
		 * any filters used to achieve data 
		 */		
		public var filterVo:Object;
		
		/**
		 * paging for current data 
		 */		
		public var pagingComponent:Paging;
		
		/**
		 * @copy #parentCaller 
		 */		
		private var _parentCaller:Object;
		
		public function ListableVo(filter:Object,pagingComponent:Paging,arrayCollection:ArrayCollection, parentCaller:Object=null)
		{
			this.arrayCollection = arrayCollection;
			this.pagingComponent = pagingComponent;
			this.filterVo = filter;
			this._parentCaller = parentCaller;
		}
		
		/**
		 * the being that created this listable VO
		 */		
		public function get parentCaller():Object
		{
			return _parentCaller;
		}

	}
}