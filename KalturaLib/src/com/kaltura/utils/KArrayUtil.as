package com.kaltura.utils
{
	import mx.utils.ArrayUtil;

	public class KArrayUtil
	{
		public static function subtract(subtracted:Array, subtrahend:Array):Array
		{
			if (!subtracted || subtracted.length == 0)
				return null;
			else if (!subtrahend || subtrahend.length == 0)
				return subtracted;

			var subtractionArray:Array = new Array();
			for each (var member:Object in subtracted)
			{
				if (ArrayUtil.getItemIndex(member, subtrahend) == -1)
				{
					subtractionArray.push(member);
				}

			}

			return subtractionArray;
		}

		public static function removeItemFromArray(item:Object, source:Array):Boolean
		{
			var index:int = ArrayUtil.getItemIndex(item, source);
			var itemFound:Boolean = index != -1;
			if (itemFound)
				source.splice(index, 1);
			return itemFound;
		}

	}
}