package com.kaltura.kmc.modules.admin.business {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.CheckBox;
	import mx.controls.LinkButton;
	import mx.resources.ResourceManager;
	
	
	[Bindable]
	/**
	 * manages a group of permission checkboxes
	 */
	public class PermissionGroupManager {
		public static const STATUS_NONE:String = "statusNone";
		public static const STATUS_ALL:String = "statusAll";
		public static const STATUS_PARTIAL:String = "statusPartial";
		
		public var _isOpen:Boolean = false;
		public var _isOpenReverse:Boolean = true;
		protected var _status:String;
		
		/**
		 * main CheckBox for this group
		 */
		public var groupCheckbox:CheckBox;
		
		protected var _groupCheckboxString:String;
		
		[ArrayElementType("CheckBox")]
		/**
		 * list sub-checkboxes of this group
		 */
		public var innerCheckBoxes:Array;
		
		/**
		 * button that collapses this group
		 */
		public var closeLinkButton:LinkButton;
		
		/**
		 * button that expands this group
		 */
		public var openLinkButton:LinkButton;
		
		
		public function PermissionGroupManager(groupCheckbox:CheckBox, innerCheckBoxes:Array, closeLinkButton:LinkButton, openLinkButton:LinkButton, showButtons:Boolean) {
			this.closeLinkButton = closeLinkButton;
			this.openLinkButton = openLinkButton;
			this.innerCheckBoxes = innerCheckBoxes;
			this.groupCheckbox = groupCheckbox;
			this.groupCheckbox.addEventListener(MouseEvent.CLICK, onGroupChanged, false, 0, true);
			
			this.openLinkButton.addEventListener(MouseEvent.CLICK, onAdvancedClicked, false, 0, true);
			this.closeLinkButton.addEventListener(MouseEvent.CLICK, onGroupClosed, false, 0, true);
			_groupCheckboxString = groupCheckbox.label;
			if (showButtons) {
				BindingUtils.bindProperty(this.closeLinkButton, "visible", this, "_isOpen");
				BindingUtils.bindProperty(this.closeLinkButton, "includeInLayout", this, "_isOpen");
				
				BindingUtils.bindProperty(this.openLinkButton, "visible", this, "_isOpenReverse");
				BindingUtils.bindProperty(this.openLinkButton, "includeInLayout", this, "_isOpenReverse");
			}
			else {
				closeLinkButton.includeInLayout = false;
				openLinkButton.includeInLayout = false;
				closeLinkButton.visible = false;
				openLinkButton.visible = false;
			}
			
			for each (var cb:CheckBox in innerCheckBoxes) {
				BindingUtils.bindProperty(cb, "visible", this, "_isOpen");
				BindingUtils.bindProperty(cb, "includeInLayout", this, "_isOpen");
				cb.addEventListener(Event.CHANGE, setMainCBState, false, 0, true);
			}
		}
		
		
		
		public function reverse(val:Boolean):Boolean {
			return !val;
		}
		
		
		/**
		 * click handler for main cb. 
		 * toggles between all selected / view only / none selected  
		 * @param event mouse click event
		 */
		protected function onGroupChanged(event:MouseEvent):void {
			var cb:CheckBox;
			if (_status == STATUS_ALL) {
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
			else if (_status == STATUS_PARTIAL) {
				groupCheckbox.selected = true;
				//turn off all inner checkboxes
				for each (cb in innerCheckBoxes) {
					if (cb.enabled) {
						cb.selected = true;
					}
				}
				setMainCBState();
				_status = STATUS_ALL;
				
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
		 * A group option button was clicked
		 *
		 */
		protected function onAdvancedClicked(event:MouseEvent):void {
			isOpen = true;
		}
		
		
		/**
		 * A group close (fold) button was clicked
		 *
		 */
		protected function onGroupClosed(event:MouseEvent):void {
			isOpen = false;
		}
		
		
		/**
		 * This property indicates if the inner checkbox are visible
		 * or is this group folded.
		 * @return
		 *
		 */
		public function get isOpen():Boolean {
			return _isOpen;
		}
		
		
		/**
		 * This function checks if all checkboxes are selected, or if part of them are
		 * selected or none, and changes the style of the group checkbox.
		 * @param event
		 *
		 */
		public function setMainCBState(event:Event = null):void {
			// n is number of unselected child cbs
			var n:uint = innerCheckBoxes.length;
			for each (var cb:CheckBox in innerCheckBoxes) {
				if (cb.selected == true) {
					n--;
				}
			}
			if (n == 0) {
				// all checkbox are selected 
				_status = STATUS_ALL;
				groupCheckbox.styleName = "adminMainCheckbox";
				groupCheckbox.selected = true;
				
			}
			else if (n == innerCheckBoxes.length) {
				//none of children selected 
				_status = STATUS_NONE;
				groupCheckbox.styleName = "adminMainCheckbox";
				groupCheckbox.selected = false;
			}
			else {
				//real partial 
				_status = STATUS_PARTIAL;
				groupCheckbox.styleName = "partial";
				groupCheckbox.selected = true;
			}
			
			
			
		}
		
		
		public function set isOpen(value:Boolean):void {
			_isOpen = value;
			_isOpenReverse = !_isOpen;
		}
		
		
	}
}