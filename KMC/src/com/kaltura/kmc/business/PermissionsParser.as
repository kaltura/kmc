package com.kaltura.kmc.business {

	/**
	 * This parser receives an XML and knows to build instructions.
	 * also the parser knows to provide a list of tabs and sub-tabs to hide.
	 * @author Eitan
	 *
	 */
	public class PermissionsParser {

		private var _permissionXml:XML;
		private var _permissions:Array = new Array();;


		public function PermissionsParser() {

		}


		/**
		 * builds a list of instruction objects from permissions XML
		 * @param xml	list of permissions
		 * @return 	list of instructions in an array
		 */
		public function parsePermissions(xml:XML):Array {
			_permissionXml = xml;
			var array:Array = new Array();
			var allPermissions:XMLList = _permissionXml..permission;
			for each (var permission:XML in allPermissions) {
				array = array.concat(getInstructions(permission));
				_permissions.push(permission.@id.toString());
			}
			return array;
		}


		/**
		 * The function receives an XML, parses it and builds an array of objects
		 * where the id relevant objects and the id is the key
		 * @param permissionXml
		 * @return list of instructions in an array
		 */
		public function getInstructions(permissionXml:XML):Array {
			var arr:Array = new Array();
			// parse and build the instructions  
			var uiXmls:XMLList = permissionXml.children();
			for each (var uiXml:XML in uiXmls) {
				var uiPath:String = uiXml.@id;
				delete uiXml.@id;
				var attributes:XMLList = uiXml.attributes();
				if (!attributes.length())
					break;
				var attributesObject:Object = new Object();
				for (var i:uint = 0; i < attributes.length(); i++) {
					attributesObject[(attributes[i] as XML).localName()] = (attributes[i] as XML).toString();
				}
				arr.push({path: uiPath, attributes: attributesObject});
			}
			return arr;
		}


		/**
		 * The function creates an array of tabs and sub-tabs that should be hidden
		 * from the user because of roles and permissions logic.
		 * @return	list of tabs and subtabs to hide
		 */
		public function getTabsToHide():Array {
			var arr:Array = new Array();
			var uiMapping:XML = _permissionXml..uimapping[0];
			var modules:XMLList = uiMapping..module;
			//iterate modules 
			for each (var module:XML in modules) {
				var subtabs:XMLList = module.tab;
				//check for sub-tabs 
				if (subtabs.length() == 0) {
					// this is a main tab that has no su tabs. 
					// if all its permissions are in the _permissionArray
					// it needs to be removed
					var tabsPermissions:XMLList = module.permission;
					if (!tabsPermissions.length()) {
						//no inner permission - move to next tab
						break;
					}
					//found permission - check its ids  
					var hideTab:Boolean = true;
					for each (var tabPermission:XML in tabsPermissions) {
						// If one id does not exist in the _permissions - this module 
						// should not be hidden
						if (!checkIfPermissionExistInPermissionArray(tabPermission.@id)) {
							//Found one - no need to hide the tab. 
							hideTab = false;
							//No need to search for any other permissions
							break;
						}
					}
					if (hideTab) {
						arr.push(module.@id.toString());
					}
				}
				else {
					// this top tab has sub-tabs and we need to scan each subtab
					for each (var subtabXml:XML in subtabs) {
						//get all restrictions of current subtab
						var subtabPermissions:XMLList = subtabXml.permission;
						var hideSubTab:Boolean = true;
						for each (var subTabPermission:XML in subtabPermissions) {
							//if one id does not exist in the _permissions - this subtab 
							// should not be hidden
							if (!checkIfPermissionExistInPermissionArray(subTabPermission.@id)) {
								//Found one - no need to hide the tab. 
								hideSubTab = false;
								//No need to search for any other permissions
								break;
							}
						}
						if (hideSubTab) {
							//TODO - think if we want the parent of the tab too or if the 
							//subtab name is good enough
							arr.push(subtabXml.@id.toString());
						}

					}
				}

			}
			return arr;
		}


		private function checkIfPermissionExistInPermissionArray(id:String):Boolean {
			for each (var localId:String in _permissions) {
				if (localId == id) {
					return true;
				}
			}
			return false;
		}
	}
}