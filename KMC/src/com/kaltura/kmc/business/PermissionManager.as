package com.kaltura.kmc.business
{
	import com.kaltura.kmc.vo.PermissionVo;
	import com.kaltura.utils.CastUtil;
	
	import flash.utils.describeType;

	/**
	 * This class will apply all permission to the UI by receiving a target screen to work with, 
	 * and a list of PermissionVos. 
	 * @author Eitan
	 * 
	 */
	public class PermissionManager
	{
		
		//the original XML from the init
		private var _permissionXml:XML;
		// list of permissions ids 
		private var _permissions:Array = new Array();
		// list of permissions VOs 
		private var _instructionVos:Array;
		// list of tabs and subtabs to hide
		private var _hideTabs:Array;
		
	
		/**
		 * Get the XML, parse it and keep relevant data in this class 
		 * @param permissionXml
		 * 
		 */		
		public function init(permissionXml:XML):void
		{
			_permissionXml = permissionXml;
			var permissionParser:PermissionsParser = new PermissionsParser();
			_instructionVos = permissionParser.parsePermissions(_permissionXml);
			var permissions:XMLList = permissionXml..permission.attribute("id");
			for each (var xml:XML in permissions )
			{
				_permissions.push(xml.toString());
			}
			_hideTabs = permissionParser.getTabsToHide(_permissionXml,_permissions);
			
		}
		/**
		 * Return only the relevant permission VOs by the component path 
		 * @param componentPath
		 * @return 
		 * 
		 */		
		public function getRelevantPermissions(componentPath:String):Array
		{
			var arr:Array = new Array();
			for each(var vo:PermissionVo in _instructionVos )
			{
				if (vo.path.indexOf(componentPath)>-1)
				{
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
		public function applyAllAttributes(startComponent:Object , path:String):void
		{
			var relevantPermissions:Array =  getRelevantPermissions(path);
			for each (var o:PermissionVo in relevantPermissions )
			{
				for (var attribute:Object in o.attributes)
				{
					apply(startComponent , o.path , attribute.toString() , o.attributes[attribute]);
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
		public function apply(startComponent:Object ,compoentPath:String , componentProperty:String , newValue:*):void
		{
			var chainWithoutPrefix:Array = compoentPath.split(startComponent["id"]);
			//isolate all items after the correct item - drop everything before
			chainWithoutPrefix.shift();
			
			var chain:Array = chainWithoutPrefix.join().split(".");
			//create the new chain without the dots 
			var o:Object = startComponent;
			//find the current component position in chain
			
			//iteratd from the next position 
			for (var i:uint=0; i<chain.length;i++) {
				// next in chain
				if(chain[i])
					o=o[chain[i]];
			}
			var dt:XML = describeType(o);
			if(dt.@isDynamic.toString() == "true") {
				// dynamic type, always assign.
				assignProperty(o,componentProperty, newValue);
			} 
			else if (o.hasOwnProperty(componentProperty)) {
				// statics type, only assign if attribute exists
				assignProperty(o,componentProperty, newValue);
			}
			else {
				trace("cannot push attribute " +  componentProperty + 
					"to component of type " + dt.@name.toString());
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
		protected function assignProperty( target:* ,prop:String, value:*):void
		{
			if (target[prop] is Boolean)
			{
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
		public function getRelevantSubTabsToHide(module:String):Array
		{
			var arr:Array = new Array ();
			for each (var tabName:String in _hideTabs)
			{
				trace (tabName);
				if (tabName.indexOf(module) > -1 && tabName.indexOf(".")>-1 )
				{
					arr.push(tabName.split(".").pop().toString()); //isolate the main tab name
				}
			}
			return arr;
		}

		
		////////////////// getters ///////////////////////////


		public function get permissionXml():XML
		{
			return _permissionXml;
		}

		public function get permissions():Array
		{
			return _permissions;
		}

		public function get instructionVos():Array
		{
			return _instructionVos;
		}

		public function get hideTabs():Array
		{
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
		public function PermissionManager(enforcer:Enforcer) 
		{
			
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