package com.kaltura.kmc.business {
	import com.kaltura.kmc.vo.PermissionVo;

	/**
	 * This parser receives an XML and knows to build instructions.
	 * also the parser knows to provide a list of tabs and sub-tabs to hide.
	 * @author Eitan
	 *
	 */
	public class PermissionsParser {


		public function PermissionsParser() {

		}


		/**
		 * builds a list of instruction objects from permissions XML
		 * @param xml	list of permissions
		 * @return 	list of instructions in an array
		 */
		public function parsePermissions(xml:XML):Array {
			var array:Array = new Array();
			var allPermissions:XMLList = xml..permission;
			for each (var permission:XML in allPermissions) {
				array = array.concat(getInstructions(permission));
			}
			return array;
		}


		/**
		 * The function receives an XML, parses it and builds an array of PermissionVo
		 * @param permissionXml
		 * @return PermissionVos in an array
		 */
		protected function getInstructions(permissionXml:XML):Array {
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
				arr.push( new PermissionVo(uiPath,attributesObject));
			}
			return arr;
		}


		/**
		 * The function creates an array of tabs and sub-tabs that should be hidden
		 * from the user because of roles and permissions logic.
		 * @return	list of tabs and subtabs to hide
		 */
		public function getTabsToHide(permissionXml:XML,permissionsList:Array):Array {
			var arr:Array = new Array();
			var uiMapping:XML = permissionXml..uimapping[0];
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
						if (!checkIfPermissionExistInPermissionArray(tabPermission.@id , permissionsList)) {
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
							if (!checkIfPermissionExistInPermissionArray(subTabPermission.@id ,permissionsList )) {
								//Found one - no need to hide the tab. 
								hideSubTab = false;
								//No need to search for any other permissions
								break;
							}
						}
						if (hideSubTab) {
							arr.push(module.@id.toString()+"."+subtabXml.@id.toString());
						}

					}
				}

			}
			return arr;
		}

		
		protected function checkIfPermissionExistInPermissionArray(id:String , permissionsList:Array):Boolean {
			for each (var localId:String in permissionsList) {
				if (localId == id) {
					return true;
				}
			}
			return false;
		}
	}
}