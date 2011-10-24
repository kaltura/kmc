package com.kaltura.kmvc.model
{
	import flash.utils.getQualifiedClassName;

	public class KMvCModel implements IModelLocator {
		
		private var _packMap:Object;
		
		public function KMvCModel(enforcer:Enforcer) {
			_packMap = new Object();
		}
		
		
		/**
		 * Returns the single Data Pack that was created from the specified class.
		 * Any DataPackBase extending class can be sent to this method, even if no 
		 * one has used it before, as the actual instantiation will be carried out 
		 * by discrete code, if neccessary.
		 * This method will check if it's the first time this data pack is refered to
		 * and will create it, and only after that, it will perform the afformentioned functionality. 
		 * @param dataPackClass The class of the requested Data Pack.
		 * @return The single instance of the specified data pack class.
		 */ 
		public function getDataPack(dataPackClass:Class):IDataPack {
			var className:String = validateDataPackExistence(dataPackClass); 
			return _packMap[className] as IDataPack;
		}
		
		
		/**
		 * Checks if a data pack from this class already exists, and creates it and stores it, if not.
		 * @param dataPackClass	reference to the class object of the desired dataPack
		 * @return qualified class name of the given dataPack
		 * */
		private function validateDataPackExistence(dataPackClass:Class): String {
			var className:String = getQualifiedClassName(dataPackClass);
			
			// Checking if it was created before.
			if (! _packMap.propertyIsEnumerable(className)){
				
				// Creating a Data Pack by using the class reference.
				var dataPack:IDataPack = new dataPackClass();
				
				// Storing the data pack and the data holder in their corresponding maps, according 
				// to specific data pack's class name.
				_packMap[className] = dataPack;
			} 
			
			// Returning the class name from the method so any user of it could use the name to immediately
			// retrieve the data pack or holder without the need for another class name production.
			return className;
		}
		
		/**
		 * singleton instance
		 */
		private static var _instance:KMvCModel;
		
		
		/**
		 * singleton means of retreiving an instance of the
		 * <code>EntryDetailsModel</code> class.
		 */
		public static function getInstance():KMvCModel {
			if (_instance == null) {
				_instance = new KMvCModel(new Enforcer());
				
			}
			return _instance;
		}
	}
}

class Enforcer {
	
}