package com.kaltura.kmvc.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	public class KMvCModel extends EventDispatcher implements IModelLocator {
		
		/**
		 * defines the value of the type property of the loadingFlagChanged event 
		 */		
		public static const LOADING_FLAG_CHANGED:String = "loadingFlagChanged";
		
		private static var __models:Array;
		
		private var _packMap:Object;
		
		public function KMvCModel(enforcer:Enforcer) {
			_packMap = new Object();
		}
		
		/**
		 * allows setting the values of entire datapack.
		 * overrides the values of previously stored datapack. 
		 * @param dataPack
		 */		
		public function setDataPack(dataPack:IDataPack):void {
			var className:String = getQualifiedClassName(dataPack);
			_packMap[className] = dataPack;
		}
		
		[Bindable("propertyChange")]
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
				
				// Storing the data pack in its maps, according to specific data pack's class name.
				_packMap[className] = dataPack;
			} 
			
			// Returning the class name from the method so any user of it could use the name to immediately
			// retrieve the data pack or holder without the need for another class name production.
			return className;
		}
		
		
		/**
		 * singleton means of retreiving an instance of the
		 * <code>EntryDetailsModel</code> class.
		 */
		public static function getInstance():KMvCModel {
			// create models list if doesn't exist
			if (__models == null) {
				__models = new Array();
			}
			// create a model if none exists
			if (__models.length == 0) {
				__models.push(new KMvCModel(new Enforcer()));
				
			}
			// return the top model
			return __models[__models.length-1];
		}
		
		/**
		 * create a new model and add it to the stack 
		 * @return the new model
		 * */
		public static function addModel():KMvCModel {
			var newmodel:KMvCModel = new KMvCModel(new Enforcer());
			if (__models.length) {
				// copy attributes from the last existing model
				var oldmodel:KMvCModel = getInstance();
				for each (var idp:IDataPack in oldmodel._packMap) {
					if (idp.shared) {
						newmodel.setDataPack(idp);
					}
				}
			}
			__models.push(newmodel);
			return newmodel;
		}
		
		/**
		 * remove the model at the top of the stack 
		 * @return the removed model
		 */		
		public static function removeModel():KMvCModel {
			return __models.pop() as KMvCModel;
		}
		
		
		/**
		 * number of items currently loading
		 * */
		private var _loadingCounter:int = 0;
		
		/**
		 * increase the counter of loading items 
		 */		
		public function increaseLoadCounter():void {
			++_loadingCounter;
			if (_loadingCounter == 1) {
//				for each (var edm:EntryDetailsModel in entryDetailsModelsArray) {
//					edm.loadingFlag = true;
//				}
				dispatchEvent(new Event(KMvCModel.LOADING_FLAG_CHANGED));
			}
		}
		
		
		/**
		 * decrease the counter of loading items 
		 */
		public function decreaseLoadCounter():void {
			--_loadingCounter;
			if (_loadingCounter == 0) {
//				for each (var edm:EntryDetailsModel in entryDetailsModelsArray) {
//					edm.loadingFlag = false;
//				}
				dispatchEvent(new Event(KMvCModel.LOADING_FLAG_CHANGED));
			}
		}
		
		
		[Bindable(event="loadingFlagChanged")]
		/**
		 * is anything currently loading
		 * */
		public function get loadingFlag():Boolean {
			return _loadingCounter > 0;
		}
	}
}

class Enforcer {
	
}