package com.kaltura.utils
{
	/**
	 * This class will be a casting util for all classes.  
	 * @author Eitan
	 * 
	 */
	public class CastUtil
	{
		
		public function CastUtil()
		{
		}
		
		/**
		 * The function will return a real boolean value from a given string or boolean  
		 * @param str
		 * @return 
		 * 
		 */		
		public static function castToBoolean(o:Object):Boolean
		{
			if (o is Boolean)
				return o;
			if ((o == 'false') || (o==0) || o=="False" || (o=="0")  )
				return false;
			return true;
		}
	}
}