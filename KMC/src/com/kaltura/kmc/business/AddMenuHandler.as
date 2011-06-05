package com.kaltura.kmc.business {
	import com.kaltura.kmc.view.AddEntryPanel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;

	/**
	 * this class is responsible for the visual aspecs of the add menu 
	 * (creating, showing, hiding and positioning..) 
	 * @author Atar
	 */	
	public class AddMenuHandler {
		
		
		/**
		 * the menu panel 
		 */
		protected var _panel:AddEntryPanel;

		public function AddMenuHandler() {
			ExternalInterface.addCallback("positionAddPanel", positionAddPanel);
		}
		
		/**
		 * Create the AddEntryPanel instance (if needed) and attach it to stage. 
		 * Position will be determined by triggering a JS function (via JSGate) – 
		 * getAddPanelPosition(). If the page's dimensions change, the page is 
		 * responsible to re-position the popup (see Opening and Manipulation of 
		 * AddEntry Menu).
		 * Add a stage listener to hide the popup. 
		 */
		public function showAddPanel():void {
			if (!_panel) {
				_panel = new AddEntryPanel();
			}
			PopUpManager.addPopUp(_panel, Application.application as DisplayObjectContainer);
			positionAddPanel(JSGate.getAddPanelPosition());
			
			// add stage listener
			(Application.application as DisplayObjectContainer).addEventListener(MouseEvent.MOUSE_OVER, hideAddPanel);
		}
		
					
		/**
		 * Remove stage listener and hide the popup. 
		 */
		public function hideAddPanel(me:MouseEvent = null):void {
			if (_panel && _panel.parent) {
				PopUpManager.removePopUp(_panel);
				// remove stage listener
				(Application.application as DisplayObjectContainer).removeEventListener(MouseEvent.MOUSE_OVER, hideAddPanel);
			}
		}
		
		/**
		 * An externalInterface method that will allow HTML to position the menu. 
		 * @param right
		 */
		public function positionAddPanel(right:Number):void {
			_panel.x = right - _panel.width;
			_panel.y = 0;
		}
		
	}
}