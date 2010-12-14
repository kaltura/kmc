package com.kaltura.kmc.modules.admin.business
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.CheckBox;
	import mx.controls.LinkButton;
	import mx.resources.ResourceManager;
		/**
		 * This class recieves instances  
		 */
	[Bindable]
	public class PermissionGroupManager
	{
		public static const STATUS_NONE:String = "statusNone";
		public static const STATUS_ALL:String = "statusAll";
		public static const STATUS_PARTIAL:String = "statusPartial";
		
		public var _isOpen:Boolean = false;
		public var _isOpenRevers:Boolean = true;
		private var _status:String;
		
		public var groupCheckbox:CheckBox;
		private var groupCheckboxString:String;
		public var innerCheckBoxes:Array;
		
		public var closeLinkButton:LinkButton;
		public var openLinkButton:LinkButton;
		
		public function PermissionGroupManager(groupCheckbox:CheckBox,innerCheckBoxes:Array , closeLinkButton:LinkButton , openLinkButton:LinkButton , showButtons:Boolean)
		{
			this.closeLinkButton = closeLinkButton;
			this.openLinkButton = openLinkButton;
			this.innerCheckBoxes = innerCheckBoxes;
			this.groupCheckbox = groupCheckbox ;
			this.groupCheckbox.addEventListener(MouseEvent.CLICK , onGroupChanged);
			
			this.openLinkButton.addEventListener(MouseEvent.CLICK , onAdvancedClicked);
			this.closeLinkButton.addEventListener(MouseEvent.CLICK , onGroupClosed);
			groupCheckboxString = groupCheckbox.label;
			if (showButtons)
			{
				BindingUtils.bindProperty(this.closeLinkButton, "visible", this , "_isOpen");
				BindingUtils.bindProperty(this.closeLinkButton, "includeInLayout", this , "_isOpen"); 
				
				BindingUtils.bindProperty(this.openLinkButton, "visible", this,"_isOpenRevers");
				BindingUtils.bindProperty(this.openLinkButton, "includeInLayout", this,"_isOpenRevers"); 
			} else 
			{
				closeLinkButton.includeInLayout = false;
				openLinkButton.includeInLayout = false;
				closeLinkButton.visible = false;
				openLinkButton.visible = false;
			}

			for each (var cb:CheckBox in innerCheckBoxes) 
			{
				BindingUtils.bindProperty(cb, "visible", this , "_isOpen");
				BindingUtils.bindProperty(cb, "includeInLayout", this , "_isOpen"); 
				cb.addEventListener(Event.CHANGE , innerCheckboxChanged);
			}
		}
		
		
		/**
		 * In case of editing, 
		 */ 
		public function init():void
		{
			if (innerCheckBoxes.length && groupCheckbox.selected  )
			{
				var allSelected:Boolean = true;
				for each(var cb:CheckBox in innerCheckBoxes)
				{
					allSelected = allSelected&&cb.selected;
				}
				if (!allSelected)
					groupCheckbox.styleName = "partial";
			}
		}
		
		public function revers(val:Boolean):Boolean
		{
			return !val;
		}
		
		protected function onGroupChanged (event:MouseEvent):void
		{
			var wasSelected:Boolean = (event.target as CheckBox).selected;
			for each (var cb:CheckBox in innerCheckBoxes) {
				cb.selected = wasSelected;
			}
			innerCheckboxChanged();
		}
		/**
		 * A group option button was clicked
		 * 
		 */
		protected function  onAdvancedClicked (event:MouseEvent):void
		{
			isOpen = true;
		}
		/**
		 * A group close (fold) button was clicked
		 * 
		 */
		protected function onGroupClosed (event:MouseEvent):void
		{
			isOpen = false;
		}
		/**
		 * This property indicates if the inner checkbox are visible 
		 * or is this group folded. 
		 * @return 
		 * 
		 */
		public function get isOpen():Boolean
		{
			return _isOpen;
		}
		/**
		 * This function checks if all checkboxes are selecets, or if part of them are 
		 * selected or none, and changes the style of the group checkbox.  
		 * @param event
		 * 
		 */
		public function innerCheckboxChanged(event:Event = null):void
		{
			var n:uint = innerCheckBoxes.length;
			for each (var cb:CheckBox in innerCheckBoxes) {
				if (cb.selected == true)
				{
					n--;
				}
			}
			// all checkbox are selected 
			if (n==0) 
			{
				_status = STATUS_ALL;
				groupCheckbox.styleName = "";
				groupCheckbox.selected = true;
				
			} else if (n == innerCheckBoxes.length)
			{
				_status = STATUS_NONE;
				groupCheckbox.styleName = "";
			} else
			{
				_status = STATUS_PARTIAL;
				groupCheckbox.styleName = "partial";
			}
			
			if (_status == STATUS_NONE && groupCheckbox.selected == true)
			{
				groupCheckbox.label = groupCheckboxString + ResourceManager.getInstance().getString( 'admin' , 'viewOnly' );
				groupCheckbox.styleName = "partial";
			}else
			{
				groupCheckbox.label = groupCheckboxString ;
			}
				
			
		}
		
		
		public function set isOpen(value:Boolean):void
		{
			_isOpen = value;
			_isOpenRevers = !_isOpen;
		}


	}
}