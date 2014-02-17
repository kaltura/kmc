package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 * information about general flavors, conversion profiles 
	 * and the flavors available for the current entry
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
		 * a flag indicating conversion profiles / flavor params data is up to date (only loaded once)
		 * */
		public var conversionProfileLoaded:Boolean;
		
		/**
		 * media conversion profiles 
		 */
		public var conversionProfiles:Array;
		
		/**
		 * media (non live) flavor params  
		 */
		public var flavorParams:Array;
		
		/**
		 * a list of KalturaConversionProfile where type = live 
		 */
		public var liveConversionProfiles:ArrayCollection;
		
		/**
		 * a list of media types and file extension associated with them,
		 * i.e. <filter name="image_files" ext="*.jpg;*.jpeg;*.gif;*.png"/> 
		 */
		public var fileFilters:XMLList;
	}
}