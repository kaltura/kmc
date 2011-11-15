package com.kaltura.edw.model.datapacks
{
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.kmvc.model.IDataPack;
	
	[Bindable]
	/**
	 * gateway to access the filter model of KMC
	 * */
	public class FilterDataPack implements IDataPack {
		
		public var shared:Boolean = true;
		
		public var filterModel:FilterModel;
	}
}