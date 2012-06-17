package com.kaltura.edw.model {
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.components.fltr.cat.data.ICategoriesDataManger;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.vo.KMCMetadataProfileVO;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * data that is needed for all filter instances
	 * @author Atar
	 */
	public class FilterModel {

		// --------------------
		// categories
		// --------------------
		public var catTreeDataManager:ICategoriesDataManger;

		
		/**
		 * the root of a category hierarchy.
		 * */
		public var categoriesForEntries:ArrayCollection = null;

		/**
		 * categories listing
		 * */
		public var categoriesMapForEntries:HashMap = new HashMap();
		
		
		/**
		 * the root of a category hierarchy.
		 * */
		public var categoriesForCats:ArrayCollection = null;

		/**
		 * categories listing
		 * */
		public var categoriesMapForCats:HashMap = new HashMap();
		
		/**
		 * the root of a category hierarchy.
		 * */
		public var categoriesGeneral:ArrayCollection = null;

		/**
		 * categories listing
		 * */
		public var categoriesMapGeneral:HashMap = new HashMap();
		
		
		/**
		 * should categories data be loaded in chunks
		 */
		public var chunkedCategoriesLoad:Boolean = true;


		/**
		 * set the value of the flag indicating categories are locked
		 * @param value new flag value
		 */
		public function setCatLockFlag(value:Boolean):void {
			if (_categoriesLocked != value) {
				_categoriesLocked = value;
				dispatchEvent(new Event("categoriesFlagChanged"));
			}
		}

		private var _categoriesLocked:Boolean;


		[Bindable(event = "categoriesFlagChanged")]
		/**
		 * indicates categories are currently locked
		 * @see GetCategoriesStatusCommand
		 * */
		public function get categoriesLocked():Boolean {
			return _categoriesLocked;
		}


		/**
		 * set the value of the flag indicating categories are updating and categories data may be incorrect
		 * @param value new flag value
		 */
		public function setCatUpdateFlag(value:Boolean):void {
			if (_categoriesUpdatingCategories != value) {
				_categoriesUpdatingCategories = value;
				dispatchEvent(new Event("categoriesFlagChanged"));
			}
		}

		private var _categoriesUpdatingCategories:Boolean;


		[Bindable(event = "categoriesFlagChanged")]
		/**
		 * indicates categories are currently updating and data may be incorrect
		 * (users, full names, etc)
		 * @see GetCategoriesStatusCommand
		 * */
		public function get categoriesUpdating():Boolean {
			return _categoriesUpdatingCategories;
		}




		// --------------------
		// flavor params
		// --------------------


		/**
		 * list of <code>KalturaFlavorParams</code>
		 * */
		public var flavorParams:ArrayCollection = new ArrayCollection();

		// --------------------
		// custom data
		// --------------------


		/**
		 * this partner is allowed to see metadata related stuff.
		 * value is set via roles and permissions
		 * */
		public var enableCustomData:Boolean = true;


		/**
		 * list of KMCMetadataProfileVO of the categories
		 */
		public var categoryMetadataProfiles:ArrayCollection;

		/**
		 * list of FormBuilders, the indices should suit the categoryMetadataProfiles arrayCollection
		 */
		public var categoryFormBuilders:ArrayCollection;

		/**
		 * list of KMCMetadataProfileVO of the enries
		 * */
		public var metadataProfiles:ArrayCollection;

		/**
		 * list of FormBuilders, the indices should suit the metadataProfiles arrayCollection
		 * */
		public var formBuilders:ArrayCollection;

		// --------------------
		// access control
		// --------------------


		/**
		 * a list of access control profiles of the current partner,
		 * <Code>AccessControlProfileVO</code> objects
		 */
		public var accessControlProfiles:ArrayCollection = new ArrayCollection();

		/**
		 * load access control only once
		 */
		public var oneTimeLoadAccessControlLoadedFlag:Boolean = false;


		// --------------------
		// distribution
		// --------------------

		/**
		 * indicates if we have the distribution plugin
		 * */
		public var enableDistribution:Boolean = true;


		// --------------------
		// general
		// --------------------

		/**
		 * indicates if re-loading of filter data is required
		 * */
		public var loadingRequired:Boolean = true;

	}
}
