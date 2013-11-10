package com.kaltura.utils
{
	import com.kaltura.dataStructures.HashMap;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	/**
	 * Singleton class 
	 * This util class handles all issues related to Languages UI - including the locales for all countries
	 * 
	 * 
	 */
	public class KLanguageUtil
	{
		[ResourceBundle("languages")]
		private static var rb:ResourceBundle;
		
		/**
		 * Singleton instance 
		 */
		private static var _instance:KLanguageUtil = null;
		
		/**
		 * language.code => language Object 
		 * (for easy access) 
		 */
		private var _languagesMap:HashMap = new HashMap();
		
		/**
		 * {label: localized lanuage name, code: upper-case language code 
		 */
		private var _languagesArr:ArrayCollection = new ArrayCollection();
		
		
		/**
		 * C'tor 
		 */
		public function KLanguageUtil(enforcer:Enforcer)
		{
			initLanguagesArr();
			initlanguagesMap();
		}
		
		public static function get instance():KLanguageUtil
		{
			if(_instance == null)
			{
				_instance = new KLanguageUtil(new Enforcer());
			}
			
			return _instance;
		}
		
		private function initLanguagesArr():void
		{
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AA'), code:"AA"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AB'), code:"AB"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AF'), code:"AF"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AM'), code:"AM"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AR'), code:"AR"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AS'), code:"AS"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AY'), code:"AY"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AZ'), code:"AZ"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BA'), code:"BA"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BE'), code:"BE"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BG'), code:"BG"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BH'), code:"BH"}); 
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BI'), code:"FO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BN'), code:"BI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BO'), code:"BO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BR'), code:"BR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CA'), code:"CA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CO'), code:"CO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CS'), code:"CS"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CY'), code:"CY"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'DA'), code:"DA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'DE'), code:"DE"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'DZ'), code:"DZ"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EL'), code:"EL"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EN'), code:"EN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EO'), code:"EO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ES'), code:"ES"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ET'), code:"ET"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EU'), code:"EU"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FA'), code:"FA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FI'), code:"FI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FJ'), code:"FJ"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FO'), code:"FO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FR'), code:"FR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FY'), code:"FY"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GA'), code:"GA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GD'), code:"GD"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GL'), code:"GL"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GN'), code:"GN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GU'), code:"GU"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HA'), code:"HA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HI'), code:"HI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HR'), code:"HR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HU'), code:"HU"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HY'), code:"HY"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IA'), code:"IA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IE'), code:"IE"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IK'), code:"IK"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IN'), code:"IN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IS'), code:"IS"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IT'), code:"IT"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IW'), code:"IW"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'JA'), code:"JA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'JI'), code:"JI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'JW'), code:"JW"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KA'), code:"KA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KK'), code:"KK"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KL'), code:"KL"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KM'), code:"KM"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KN'), code:"KN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KO'), code:"KO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KS'), code:"KS"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KU'), code:"KU"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KY'), code:"KY"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LA'), code:"LA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LN'), code:"LN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LO'), code:"LO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LT'), code:"LT"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LV'), code:"LV"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MG'), code:"MG"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MI'), code:"MI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MK'), code:"MK"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ML'), code:"ML"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MN'), code:"MN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MO'), code:"MO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MR'), code:"MR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MS'), code:"MS"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MT'), code:"MT"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MY'), code:"MY"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NA'), code:"NA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NE'), code:"NE"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NL'), code:"NL"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NO'), code:"NO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'OC'), code:"OC"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'OM'), code:"OM"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'OR'), code:"OR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PA'), code:"PA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PL'), code:"PL"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PS'), code:"PS"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PT'), code:"PT"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'QU'), code:"QU"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RM'), code:"RM"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RN'), code:"RN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RO'), code:"RO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RU'), code:"RU"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RW'), code:"RW"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SA'), code:"SA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SD'), code:"SD"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SG'), code:"SG"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SH'), code:"SH"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SI'), code:"SI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SK'), code:"SK"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SL'), code:"SL"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SM'), code:"SM"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SN'), code:"SN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SO'), code:"SO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SQ'), code:"SQ"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SR'), code:"SR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SS'), code:"SS"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ST'), code:"ST"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SU'), code:"SU"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SV'), code:"SV"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SW'), code:"SW"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TA'), code:"TA"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TE'), code:"TE"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TG'), code:"TG"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TH'), code:"TH"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TI'), code:"TI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TK'), code:"TK"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TL'), code:"TL"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TN'), code:"TN"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TO'), code:"TO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TR'), code:"TR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TS'), code:"TS"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TT'), code:"TT"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TW'), code:"TW"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'UK'), code:"UK"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'UR'), code:"UR"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'UZ'), code:"UZ"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'VI'), code:"VI"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'VO'), code:"VO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'WO'), code:"WO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'XH'), code:"XH"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'YO'), code:"YO"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ZH'), code:"ZH"});
			_languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ZU'), code:"ZU"});
		
			var nameSortField:SortField = new SortField();
            nameSortField.name = "label";
            nameSortField.numeric = false;

			var nameDataSort:Sort = new Sort();
            nameDataSort.fields = [nameSortField];
			_languagesArr.sort = nameDataSort;
            _languagesArr.refresh();
		}
		
		/***
		 * Get the list of all languages
		 * 
		 * 
		 */
		public function get languagesArr():ArrayCollection
		{
			return _languagesArr;
		}
		
		private function initlanguagesMap():void
		{
			var index:int = 0;
			for each(var lang:Object in languagesArr)
			{
				lang.index = index;
				_languagesMap.put(lang.code, lang);
				index++;
			}
		}
		
		
		/**
		 * This function is used to get the language object
		 * The object is with fields : code, label and index
		 * code - language code
		 * label - language label in the active locale
		 * index - the index of the language in the languages array collection 
		 * @param code - language code
		 * @return langauge object
		 * 
		 */		
		public function getLanguageByCode(code:String):Object
		{
			var lang:Object = _languagesMap.getValue(code.toUpperCase());
			return lang;
		}

	}
}
class Enforcer
{
	
}