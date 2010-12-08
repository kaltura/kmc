package com.kaltura.kmc.business {
	import com.kaltura.kmc.vo.PermissionVo;
	import com.kaltura.utils.CastUtil;

	import flash.utils.describeType;

	import mx.events.IndexChangedEvent;

	/**
	 * This class will apply all permission to the UI by receiving a target screen to work with,
	 * and a list of PermissionVos.
	 * @author Eitan
	 *
	 */
	public class PermissionManager {

		/**
		 * role permissions (original XML from <code>init()</code> transformed)
		 */
		private var _permissionXml:XML;

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
		 * Get the partner XML and the users permissions list (comma seperate list),
		 * parse them and keep relevant data in this class.
		 * @param permissionXml		all partner's permissions
		 * @param rolePermission	a comma-separated-string of ids of the role's permissions
		 *
		 */
		public function init(partnerPermissionsXml:XML, rolePermissions:String = ""):void {
			_permissionXml = partnerPermissionsXml.copy();
			var allRolePermissions:Array = rolePermissions.split(",");
			// remove from permissions list the granted permissions and leave the ones that are forbidden.
			// first remove only sub-permissions (not groups)
			if (allRolePermissions.length > 0 && allRolePermissions[0] != "") {
				for each (var permission:String in allRolePermissions) {
					if ((_permissionXml.permissions..descendants().(attribute("id") == permission)[0] as XML).localName() == "permissionGroup") {
						// if we move groups now we will actually remove permissions we need
						continue;
					}
					delete _permissionXml.permissions..descendants().(attribute("id") == permission)[0];
				}
			}

			// scan permissionGroups that need to be removed and remove them if they are empty.
			// we want to keep these groups:
			var permissionsToKeep:XMLList = _permissionXml.permissions.permissionGroup.(children().length() > 0 || rolePermissions.indexOf(@id) == -1);
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
		}


		/**
		 * Return only the relevant permission VOs by the component path
		 * @param componentPath
		 * @return
		 *
		 */
		public function getRelevantPermissions(componentPath:String):Array {
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
		 * @param startComponent
		 * @param compoentPath
		 * @param componentProperty
		 * @param newValue
		 */
		public function apply(startComponent:Object, compoentPath:String, componentProperty:String, newValue:*):void {
			var idIndex:int = compoentPath.indexOf(startComponent["id"]);
			var chain:Array;
			if (idIndex > -1) {
				var str:String = compoentPath.substring(idIndex + startComponent["id"].length);
				chain = str.split(".");
			}
			else {
				chain = compoentPath.split(".");
			}
			//create the new chain without the dots 
			var o:Object = startComponent;
			if (o.id != chain[0]) {
				// path starting from the middle: drop the first name because it referes to startComponent
				chain.shift();
			}
			//find the current component position in chain
			//iterate from the next position 
			for (var i:uint = 0; i < chain.length; i++) {
				// next in chain
				if (chain[i])
					o = o[chain[i]];
			}
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
				trace("cannot push attribute " + componentProperty + " to component of type " + dt.@name.toString());
			}
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
		public function getRelevantSubTabsToHide(module:String):Array {
			var arr:Array = new Array();
			for each (var tabName:String in _hideTabs) {
//				trace (tabName);
				if (tabName.indexOf(module) > -1 && tabName.indexOf(".") > -1) {
					arr.push(tabName.split(".").pop().toString()); //isolate the main tab name
				}
			}
			return arr;
		}


		/**
		 * if there is a permission vo associated with the component, and that vo
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


		////////////////////////////////////////////////singleton code
		/**
		 * singleton instance
		 */
		private static var _instance:PermissionManager;


		/**
		 * @param enforcer	singleton garantee
		 */
		public function PermissionManager(enforcer:Enforcer) {

		}


		/**
		 * singleton means of retreiving an instance of the
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