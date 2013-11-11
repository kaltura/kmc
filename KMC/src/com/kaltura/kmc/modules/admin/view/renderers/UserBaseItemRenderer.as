package com.kaltura.kmc.modules.admin.view.renderers {
	import com.kaltura.vo.KalturaUser;
	
	import mx.containers.HBox;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;

	public class UserBaseItemRenderer extends HBox implements IDropInListItemRenderer {
		/**
		 * Internal variable for the property value.
		 * */
		protected var _listData:DataGridListData;


		[Bindable("dataChange")]
		public function get listData():BaseListData {
			return _listData;
		}

		public function set listData(value:BaseListData):void {
			_listData = DataGridListData(value);
		}


		public function UserBaseItemRenderer() {
			super();
			this.setStyle("paddingLeft", "6");
			this.setStyle("verticalAlign", "middle");
		}


		public function setDefaultContainer():void {
			if (data && (data as KalturaUser).isAccountOwner) {
				this.setStyle("backgroundColor", "#FFFDEF");
			}
			else {
				this.setStyle("backgroundColor", null);
			}
		}


		override public function validateNow():void {
			super.validateNow();
			setDefaultContainer();
		}
	}
}
