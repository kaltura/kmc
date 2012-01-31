package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 * information about general flavors, conversion profiles 
	 * and the flavors available foir the current entry
	 * */
	public class FlavorsDataPack implements IDataPack {
		
		public var shared:Boolean = true;
		
		/**
		 * a list of <code>ConversionProfileWithFlavorParamsVo</code> objects
		 * for each conversion profile, lists the flavorparams matching objects. 
		 */		
		public var conversionProfsWFlavorParams:ArrayCollection;
		
		/**
		 * list of partner's storage profiles, 
		 * <code>KalturaStorageProfile</code> objects 
		 */
		public var storageProfiles:ArrayCollection;
		
		/**
		 * indicates if this is the first drilldown
		 * */
		public var conversionProfileLoaded:Boolean;
		
		public var conversionProfiles:Array;
		
		/**
		 * a list of media types and file extension associated with them,
		 * i.e. <filter name="image_files" ext="*.jpg;*.jpeg;*.gif;*.png"/> 
		 */
		public var fileFilters:XMLList;
	}
}