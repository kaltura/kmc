package com.kaltura.kmc.modules.admin.control.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.admin.model.AdminModelLocator;
	import com.kaltura.kmc.view.ForbidenBox;
	
	import flash.display.DisplayObject;
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;

	public class BaseCommand implements ICommand {
		protected var _model:AdminModelLocator = AdminModelLocator.getInstance();


		/**
		 * default implementation for service fault response
		 */
		protected function fault(info:Object):void {
			// invalid KS
			if (info && info.error && info.error.errorMsg &&
				info.error.errorCode == APIErrorCode.INVALID_KS) {
				ExternalInterface.call("kmc.functions.expired");
			}
			// forbidden service
			else if (info && info.error && info.error.errorCode &&
				info.error.errorCode.toString() == "SERVICE_FORBIDDEN") {
				// added the support of non closable window
				var forbiddenBox:ForbidenBox = new ForbidenBox();
				forbiddenBox.text = ResourceManager.getInstance().getString('cms','forbiddenError');
				//de-activate the HTML tabs
				ExternalInterface.call("kmc.utils.activateHeader", false);
				PopUpManager.addPopUp(forbiddenBox, (_model.app as DisplayObject), true);
				PopUpManager.centerPopUp(forbiddenBox);
			}
			// other errors
			else if (info && info.error && info.error.errorMsg) {
				Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('admin', 'error'));
			}
			_model.decreaseLoadCounter();
		}


		/**
		 * default implementation for result.
		 * check if call response is data or error, respond to error.
		 * when overriding this method you should always call
		 * <code>super.result(data)</code> first.
		 * @param data data returned from server.
		 *
		 */
		protected function result(data:Object):void {
			// for simple requests
			if (data.error) {
				fault(data);
			}
			// for multirequests
			else if (data.data && data.data.length > 0) {
				var l:int = data.data.length ;
				for(var i:int = 0; i<l; i++) {
					if (data.data[i].error) {
						fault(data.data[i]);
					}
				}
			}
			// do not call _model.decreaseLoading(); here, because this is might be
			// called more than once per command (i.e. inner recursion) 
		}


		/**
		 * @inheritDocs
		 */
		public function execute(event:CairngormEvent):void {
			throw new Error("execute() must be implemented");
		}

	}
}