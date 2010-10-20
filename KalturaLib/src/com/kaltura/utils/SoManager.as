package com.kaltura.utils
{
	import flash.net.SharedObject;
	
	/**
	 *	This class checks if a user had made a specific action or not, and by checking
	 * it saves a boolean data so it will be marked in the future. 
	 * It uses Shared Object (local flash cookie)   
	 * @author Eitan
	 * 
	 */
	public class SoManager
	{
		public var _myLocalData:SharedObject;
		
		/**
		 * This function checks for a local stored data of a specific application and a specific user
		 * @param moduleId
		 * @param userId
		 * @return the object stored  
		 * 
		 */
		public function getLocalData(moduleId:String,userId:String):Object
		{
			_myLocalData = SharedObject.getLocal(moduleId+userId);	
            if(_myLocalData.data.userId == null) {
            	//first time - create the section to this partner
                _myLocalData.data.userId = userId;
                _myLocalData.flush();
            } else
            {
            	//partner already exist 
            }
            return _myLocalData;
		}
		
		/**
		 * gets a value from the local data. if this local data exist
		 * it will return it. if not it will assing a 'true' to this value
		 * and flush   
		 */
		public function checkOrFlush(value:String):Object
		{
			if (_myLocalData.data[value])
			{
				return _myLocalData.data[value];
			} 
			_myLocalData.data[value] = true;
			_myLocalData.flush();
			return false;
		}
		
		//singleton methods
		public function SoManager(enforcer:Enforcer)
		{
		}
		
		private static var _soManager : SoManager;
		public static function getInstance() : SoManager
		{
			if ( _soManager == null )
			{
				_soManager = new SoManager(new Enforcer());
			}
			return _soManager;
		}
	}
}

class Enforcer
{
	
}		