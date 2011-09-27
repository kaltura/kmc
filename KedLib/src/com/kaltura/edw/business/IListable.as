package com.kaltura.edw.business
{
	import com.kaltura.controls.Paging;
	
	public interface IListable
	{
		function get filterVo():Object;
		function get pagingComponent():Paging;
	}
}