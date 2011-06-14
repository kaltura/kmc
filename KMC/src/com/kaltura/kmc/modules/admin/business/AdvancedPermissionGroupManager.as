package com.kaltura.kmc.modules.admin.business {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.CheckBox;
	import mx.controls.LinkButton;
	import mx.resources.ResourceManager;

	[Bindable]
	/**
	 * manages a group of permission checkboxes, allowing the 
	 * state of only the head checkbox selected (view only state
	 * of screens relevant to the permission) 
	 */
	public class AdvancedPermissionGroupManager extends PermissionGroupManager {
		

		public function AdvancedPermissionGroupManager(groupCheckbox:CheckBox, innerCheckBoxes:Array, closeLinkButton:LinkButton, openLinkButton:LinkButton, showButtons:Boolean) {
			super(groupCheckbox, innerCheckBoxes, closeLinkButton, openLinkButton, showButtons);
		}

		/**
		 * click handler for main cb. 
		 * toggles between all selected / view only / none selected  
		 * @param event mouse click event
		 */
		override protected function onGroupChanged(event:MouseEvent):void {
			var cb:CheckBox;
			if (_status == STATUS_ALL) {
				groupCheckbox.selected = true;
				//turn off all inner checkboxes
				for each (cb in innerCheckBoxes) {
					if (cb.enabled) {
						cb.selected = false;
					}
				}
				setMainCBState();
				_status = STATUS_PARTIAL;
				
			}
			else if (_status == STATUS_PARTIAL) {
				groupCheckbox.selected = false;
				//turn off all inner checkboxes
				for each (cb in innerCheckBoxes) {
					if (cb.enabled) {
						cb.selected = false;
					}
				}
				setMainCBState();
				_status = STATUS_NONE;
				
			}
			else {
				groupCheckbox.selected = true;
				//turn on all inner checkboxes
				for each (cb in innerCheckBoxes) {
					if (cb.enabled) {
						cb.selected = true;
					}
				}
				setMainCBState();
				_status = STATUS_ALL;
				
			}
			
		}


		/**
		 * This function checks if all checkboxes are selected, or if part of them are
		 * selected or none, and changes the style of the group checkbox.
		 * @param event
		 *
		 */
		override public function setMainCBState(event:Event = null):void {
			super.setMainCBState(event);
			//view only
			if (_status == STATUS_NONE && groupCheckbox.selected == true) {
				groupCheckbox.label = _groupCheckboxString + ResourceManager.getInstance().getString('admin', 'viewOnly');
				groupCheckbox.styleName = "partial";
				groupCheckbox.selected = true;
			}
			else {
				groupCheckbox.label = _groupCheckboxString;
			}
		}
	}
}