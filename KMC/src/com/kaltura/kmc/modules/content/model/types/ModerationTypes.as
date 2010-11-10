package com.kaltura.kmc.modules.content.model.types {
	import mx.resources.ResourceManager;

	public class ModerationTypes {
		public static const PENDING:uint = 1;
		public static const REVIEW:uint = 5;
		public static const APPROVED:uint = 2;
		public static const AUTO_APPROVED:uint = 6;
		public static const REJECTED:uint = 3;


		public static function getModerationTypeName(num:uint):String {
			var result:String = '';
			switch (num) {
				case ModerationTypes.PENDING:
					result = ResourceManager.getInstance().getString('cms', 'review');
					break;
				case ModerationTypes.APPROVED:
					result = ResourceManager.getInstance().getString('cms', 'approved');
					break;
				case ModerationTypes.AUTO_APPROVED:
					result = ResourceManager.getInstance().getString('cms', 'approved');
					break;
				case ModerationTypes.REJECTED:
					result = ResourceManager.getInstance().getString('cms', 'rejected');
					break;
				case ModerationTypes.REVIEW:
					result = ResourceManager.getInstance().getString('cms', 'review');
					break;
			}

			return result;
		}
	}

}