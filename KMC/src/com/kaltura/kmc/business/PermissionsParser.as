package com.kaltura.kmc.business {
	import com.kaltura.kmc.vo.PermissionVo;

	/**
	 * This parser receives an XML and knows to build instructions.
	 * also the parser knows to provide a list of tabs and sub-tabs to hide.
	 * @author Eitan
	 */
	public class PermissionsParser {

		/**
		 * builds a list of instruction objects from permissions XML
		 * @param allPermissions	list of permissions
		 * @return 	list of instructions (PermissionVo) in an array
		 */
		public function parsePermissions(allPermissions:XMLList):Array {
			var array:Array = new Array();
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
				arr.push(new PermissionVo(uiPath,attributesObject));
			}
			return arr;
		}


		/**
		 * The function creates an array of tabs and sub-tabs that should be hidden
		 * from the user because of roles and permissions logic.
		 * @param uimapping				ui mapping part of the permissions uiconf
		 * @param permissionsList		role permission ids
		 * @return	list of modules and subtabs to hide (String)
		 */
		public function getTabsToHide(uimapping:XML, permissionsList:Array):Array {
			var arr:Array = new Array();
			var modules:XMLList = uimapping..module;
			
			// iterate modules 
			for each (var module:XML in modules) {
				var hideTab:Boolean = true;
				var subtabsList:XMLList = module.tab;
				// support min attribute - minimum amount of nodes to show this tab
				var subtabs:int = subtabsList.length();
				var minNodes:int = 1;
				if (module.attribute("min").toString())
					minNodes = Number(module.attribute("min"));
				// check for sub-tabs 
				if (subtabs == 0) {
					// count the permissions needed to show the tab
					var count:int = 0;
					// this is a main tab that has no subtabs. 
					var modulePermissions:XMLList = module.permission;
					if (!modulePermissions.length()) {
						// no inner permission - move to next module
						continue;
					}
					// found permission - check its id
					for each (var permission:XML in modulePermissions) {
						// If one id is in the permissionsList - this module should not be hidden
						if (permissionsList.indexOf(permission.@id ) > -1) {
							// Found one - count it. 
							count ++;
							
							// if already have enough, no need to continue.
							if (count >= minNodes) {
								break;
							}
						}
					}
					// need at least minNodes non-denied permissions to show the tab
					if (count >= minNodes) {
						hideTab = false;
					}
				}
				else {
					// this top tab has sub-tabs and we need to scan each subtab.
					// if no subtabs are left, we also hide the module.
					for each (var subtabXml:XML in subtabsList) {
						//get all restrictions of current subtab
						var subtabPermissions:XMLList = subtabXml.permission;
						
						var hideSubTab:Boolean = true;
						for each (var subTabPermission:XML in subtabPermissions) {
							//if one id is in the permissionsList - this subtab should not be hidden
							if (permissionsList.indexOf(subTabPermission.@id) > -1) {
								//Found one - no need to hide the subtab or the tab. 
								hideSubTab = false;
								//No need to search for any other permissions
								break;
							}
						}
						if (hideSubTab) {
							// remember the subtab to hide:
							arr.push(module.@id.toString()+"."+subtabXml.@id.toString());
							// this subtab will be hidden, one less visible one:
							subtabs--;
						}
						else {
							hideTab = false;
						}
					}
				}
				if (hideTab) {
					arr.push(module.@id.toString());
				}
			}
			return arr;
		}
	}
}