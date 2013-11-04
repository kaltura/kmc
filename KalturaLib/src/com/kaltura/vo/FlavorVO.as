package com.kaltura.vo {
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.utils.ObjectUtil;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.ObjectProxy;

	[Bindable]
	/**
	 * wrapper for KalturaFlavorParams 
	 */	
	public class FlavorVO extends ObjectProxy implements IValueObject {
		public static const SELECTED_CHANGED_EVENT:String = "flavorSelectedChanged";

		private var _selected:Boolean = false;
		
		/**
		 * the KalturaFlavorParams this vo represents 
		 */
		public var kFlavor:KalturaFlavorParams = new KalturaFlavorParams();
		

		/**
		 * should the line in the conversion settings table
		 * representing this item be editable
		 * */
		public var editable:Boolean = true;


		public function get selected():Boolean {
			return _selected;
		}


		public function set selected(selected:Boolean):void {
			_selected = selected;
			dispatchEvent(new Event(SELECTED_CHANGED_EVENT));
		}


		public function clone():FlavorVO {
			var newFlavor:FlavorVO = new FlavorVO();
			newFlavor.selected = this.selected;
			newFlavor.editable = this.editable;
			// need to make kFlavor the same type as current!!
			var kFlavorClassName:String = getQualifiedClassName(this.kFlavor);
			var kFlavorClass:Class = getDefinitionByName(kFlavorClassName) as Class; 
			newFlavor.kFlavor = (new kFlavorClass()) as KalturaFlavorParams;
			var ar:Array = ObjectUtil.getObjectAllKeys(this.kFlavor);
			for (var i:int = 0; i < ar.length; i++) {
				newFlavor.kFlavor[ar[i]] = kFlavor[ar[i]];
			}

			return newFlavor;
		}

	}
}