package com.kaltura.kmc.modules.admin.business
{
	import com.kaltura.kmc.modules.admin.vo.LocaleVo;

	public class LocaleParser
	{
		public function LocaleParser()
		{
		}
		
		
		public static function getLanguagesArray(languagesXml:XML):Array {
			var result:Array = [];
			var loc:LocaleVo;
			for each (var lang:XML in languagesXml.children()) {
				loc = new LocaleVo();
				loc.code = lang.code.text();
				loc.value = lang.value.text();
				result.push(loc);
			}
			return result; 
		}
	}
}