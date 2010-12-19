package com.kaltura.kmc.business {
	import com.kaltura.kmc.events.KmcErrorEvent;
	import com.kaltura.kmc.vo.PermissionVo;
	import com.kaltura.utils.CastUtil;
	
	import flash.events.EventDispatcher;
	import flash.utils.describeType;

	/**
	 * This class will apply all permission to the UI by receiving a target screen to work with,
	 * and a list of PermissionVos.
	 * @author Eitan
	 *
	 */
	public class PermissionManager extends EventDispatcher {

		/**
		 * role permissions (original XML from <code>init()</code> transformed).
		 * it holds the effects on UI of permissions this role doesn't have.
		 */
		private var _permissionXml:XML;
		
		
		/**
		 * @copy #partnerPermissions 
		 */
		private var _partnerPermissions:XML;

		/**
		 * list of permission ids that are denied
		 */
		private var _deniedPermissions:Array = new Array();

		/**
		 * list of permissions VOs
		 */
		private var _instructionVos:Array;

		/**
		 * list of tabs and subtabs to hide
		 */
		private var _hideTabs:Array;
		/**
		 * List of features that the partner does not have (IE live stream , custom metadata , 508 etc') 
		 */
		private var _hideFeatures:Array;


		/**
		 * Get the partner permissions XML and the users permissions list (comma-seperated list),
		 * parse them and keep relevant data in this class.
		 * @param permissionXml		all partner's permissions
		 * @param rolePermission	a comma-separated-string of ids of the role's permissions
		 * @param allPartnersPermission	a comma-separated-string of ids of partners permissions
		 */
		public function init(partnerPermissionsXml:XML, rolePermissions:String = "" , allPartnersPermission:String=""):void {
			_partnerPermissions = partnerPermissionsXml.copy();
			_permissionXml = partnerPermissionsXml.copy();
			var allRolePermissions:Array = rolePermissions.split(",");
			
			// remove from permissions list the granted permissions and leave the ones that are forbidden.
			// first remove only sub-permissions (not groups)
			if (allRolePermissions.length > 0 && allRolePermissions[0] != "") {
				for each (var permissionId:String in allRolePermissions) {
					var permissionData:XML = _permissionXml.permissions..descendants().(attribute("id") == permissionId)[0];
					// if such permission exists (permission or permissionGroup)
					if (permissionData) {
						if (permissionData.localName() == "permissionGroup") {
							// if we remove groups now we will actually remove permissions we may need to ban.
							continue;
						}
						delete _permissionXml.permissions..descendants().(attribute("id") == permissionId)[0];
					}
				}
			}

			// scan permissionGroups that need to be removed and remove them if they are empty.
			// we want to keep these groups:
			var permissionsToKeep:XMLList = _permissionXml.permissions.permissionGroup.(child("permission").length() > 0 || rolePermissions.indexOf(@id) == -1);
			
			// replace the original permissions node with the "clean" one
			delete _permissionXml.permissions[0];
			
			_permissionXml.appendChild(XML(<permissions/>).appendChild(permissionsToKeep));

			var permissionParser:PermissionsParser = new PermissionsParser();
			_instructionVos = permissionParser.parsePermissions(permissionsToKeep..permission);
			
			var permissionIdList:XMLList = _permissionXml.permissions.descendants().attribute("id");
			for each (var xml:XML in permissionIdList) {
				_deniedPermissions.push(xml.toString());
			}
			_hideTabs = permissionParser.getTabsToHide(_permissionXml..uimapping[0], allRolePermissions);
			// parse features that the partner does not have, and combine them with the current users permissions 
			var partnerPermissionsList:Array = allPartnersPermission.split(",");
			for each (var partnerPermission:String in partnerPermissionsList)
			{
				
				if (partnerPermission)
				{
					// search for existing permissions in the Vos and delete them if the partner does 
					// not have these permissions 
					
				}	
			}
			
			_hideFeatures = [];
		}


		/**
		 * Get a list of permission VOs that is relevant to the component specified by componentPath. 
		 * @param componentPath 	path to component
		 * @return	list of permissionVo-s 
		 */
		protected function getRelevantPermissions(componentPath:String):Array {
			var arr:Array = new Array();
			for each (var vo:PermissionVo in _instructionVos) {
				if (vo.path.indexOf(componentPath) > -1) {
					// found a match
					arr.push(vo);
				}
			}
			return arr;
		}


		/**
		 * Search for relevant attributes for this component accourding to path,
		 * iterate on them, and try to change their value
		 * @param startComponent
		 * @param path
		 *
		 */
		public function applyAllAttributes(startComponent:Object, path:String):void {
			var relevantPermissions:Array = getRelevantPermissions(path);
			for each (var o:PermissionVo in relevantPermissions) {
				for (var attribute:Object in o.attributes) {
					apply(startComponent, o.path, attribute.toString(), o.attributes[attribute]);
				}
			}
		}


		/**
		 * This function recieves a path to a component IE myCompo1.myCompo2.myButton
		 * a starting target (instance of a uiComponent),a propery on the target to change
		 * and a new value.
		 * @param startComponent	the component from which to calculate path
		 * @param componentPath		path to the component to act on
		 * @param componentProperty	the property of the target component to be changed
		 * @param newValue			new value for <code>componentProperty</code> 
		 */
		public function apply(startComponent:Object, componentPath:String, componentProperty:String, newValue:*):void {
			var o:Object = getWorkComponent(startComponent, componentPath);
			
			if (o) {
				var dt:XML = describeType(o);
				if (dt.@isDynamic.toString() == "true") {
					// dynamic type, always assign.
					assignProperty(o, componentProperty, newValue);
				}
				else if (o.hasOwnProperty(componentProperty)) {
					// statics type, only assign if attribute exists
					assignProperty(o, componentProperty, newValue);
				}
				else {
					dispatchError("cannot push attribute " + componentProperty + " to component of type " + dt.@name.toString());
				}
			}
		}

		/**
		 * Select the component to act on.
		 * @param startComponent	the component from which to calculate path
		 * @param componentPath		path to the component to act on
		 * @return 		the component to which componentPath directs.
		 */
		protected function getWorkComponent(startComponent:Object, componentPath:String):Object {
			var o:Object = startComponent;
			var chain:Array = componentPath.split(".");
			var ind:int = stringIndex(startComponent.id, chain); 
			if (ind > -1) {
				// remove everything before, including.
				/*chain = */chain.splice(0, ind + 1);
			}
			else {
				// in this case we assume this is one of the popup windows, so we 
				// need to remove the meaningless first item
				chain.shift();
			}
			
			// find the current component position in chain
			// iterate from the next position 
			for (var i:uint = 0; i < chain.length; i++) {
				// next in chain
				if (chain[i]) {
					if (o.hasOwnProperty(chain[i])) {
						o = o[chain[i]];
					}
					else {
						dispatchError("component " + o.id + " doesn't have property " + chain[i]);
						return null;
					}
				}
			}
			return o;
		}

		
		
		/**
		 * dispatch an error event 
		 * @param errorString	error text to present to the user
		 */		
		protected function dispatchError(errorString:String):void {
			var kee:KmcErrorEvent = new KmcErrorEvent(KmcErrorEvent.ERROR, errorString);
			dispatchEvent(kee);
		}


		/**
		 * Assign a new value to a property. This function cast if needed (depend on the
		 * target type) to Boolean and to int.
		 *
		 * @param target - the target object
		 * @param prop - the property name
		 * @param value - the new value
		 *
		 */
		protected function assignProperty(target:*, prop:String, value:*):void {
			if (target[prop] is Boolean) {
				target[prop] = CastUtil.castToBoolean(value);
				return;
			}
			//default behavior
			target[prop] = value;
		}


		/**
		 * The function returns the relevant sub-tabs to hide
		 * @param module
		 * @return
		 *
		 */
		public function getRelevantSubTabsToHide(module:String = null):Array {
			var arr:Array = new Array();
			var tabName:String;
			if (module) {
				for each (tabName in _hideTabs) {
					if (tabName.indexOf(module) > -1 && tabName.indexOf(".") > -1) {
						arr.push(tabName.split(".").pop().toString()); //isolate the main tab name
					}
				}
			}
			else {
				// this is the KMC module dropping thingy
				for each (tabName in _hideTabs) {
					if (tabName.indexOf(".") == -1) {
						arr.push(tabName); 
					}
				}
			}
			return arr;
		}


		/**
		 * If there is a permission vo associated with the component, and that vo
		 * has a definition for the given attribute, return the value.
		 * @param componentPath path to component
		 * @param attribute		the attribute whose value we want
		 * @return the value for the desired attribute
		 */
		public function getValue(componentPath:String, attribute:String):* {
			var relevantPermissions:Array = getRelevantPermissions(componentPath);
			for each (var o:PermissionVo in relevantPermissions) {
				for (var att:Object in o.attributes) {
					if (att.toString() == attribute) {
						return o.attributes[att];
					}
				}
			}
			//TODO what should the default value be?
		}

		
		/**
		 * See if the given string is in the given array 
		 * @param str
		 * @param array
		 * @return true if the string is in the array, false otherwise
		 */		
		protected function stringIndex(str:String , array:Array):int {
			var l:int = array.length;
			for (var i:int = 0; i<l; i++) {
				if (array[i] == str) {
					return i;
				}
			}
			return -1;
		}
		
		
		////////////////// getters ///////////////////////////

		/**
		 * @copy #_permissionXml
		 */
		public function get permissionXml():XML {
			return _permissionXml;
		}


		/**
		 * @copy #_permissions
		 */		
		public function get deniedPermissions():Array {
			return _deniedPermissions;
		}

		
		/**
		 * @copy #_instructionVos
		 */	
		public function get instructionVos():Array {
			return _instructionVos;
		}

		/**
		 * @copy #_hideTabs
		 */
		public function get hideTabs():Array {
			return _hideTabs;
		}
		
		

		/**
		 * @copy #_partnerPermissions
		 */
		public function get partnerPermissions():XML
		{
			return _partnerPermissions;
		}

		/**
		 * @copy #_hideFeatures
		 */
		public function get hideFeatures():Array
		{
			return _hideFeatures;
		}

		////////////////////////////////////////////////singleton code
		/**
		 * Singleton instance
		 */
		private static var _instance:PermissionManager;


		/**
		 * @param enforcer	singleton garantee
		 */
		public function PermissionManager(enforcer:Enforcer) {

		}


		/**
		 * Singleton means of retreiving an instance of the
		 * <code>PermissionManager</code> class.
		 */
		public static function getInstance():PermissionManager {
			if (_instance == null) {
				_instance = new PermissionManager(new Enforcer());
			}
			return _instance;
		}




	}
}

class Enforcer {

}