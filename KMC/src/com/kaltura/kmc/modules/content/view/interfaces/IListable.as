package com.kaltura.kmc.modules.content.view.interfaces
{
	import com.kaltura.controls.Paging;
	
	public interface IListable
	{
		function get filterVo():Object;
		function get pagingComponent():Paging;
	}
}