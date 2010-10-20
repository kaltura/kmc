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
		private static var _instance:KLanguageUtil = null;
		private var languagesMap:HashMap = new HashMap();
		private var _languagesArr:ArrayCollection = new ArrayCollection();
		
		[ResourceBundle("languages")]
		private static var rb:ResourceBundle;
		
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
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AA'), code:"AA"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AB'), code:"AB"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AF'), code:"AF"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AM'), code:"AM"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AR'), code:"AR"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AS'), code:"AS"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AY'), code:"AY"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'AZ'), code:"AZ"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BA'), code:"BA"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BE'), code:"BE"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BG'), code:"BG"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BH'), code:"BH"}); 
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BI'), code:"FO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BN'), code:"BI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BO'), code:"BO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'BR'), code:"BR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CA'), code:"CA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CO'), code:"CO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CS'), code:"CS"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'CY'), code:"CY"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'DA'), code:"DA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'DE'), code:"DE"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'DZ'), code:"DZ"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EL'), code:"EL"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EN'), code:"EN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EO'), code:"EO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ES'), code:"ES"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ET'), code:"ET"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'EU'), code:"EU"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FA'), code:"FA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FI'), code:"FI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FJ'), code:"FJ"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FO'), code:"FO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FR'), code:"FR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'FY'), code:"FY"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GA'), code:"GA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GD'), code:"GD"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GL'), code:"GL"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GN'), code:"GN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'GU'), code:"GU"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HA'), code:"HA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HI'), code:"HI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HR'), code:"HR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HU'), code:"HU"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'HY'), code:"HY"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IA'), code:"IA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IE'), code:"IE"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IK'), code:"IK"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IN'), code:"IN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IS'), code:"IS"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IT'), code:"IT"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'IW'), code:"IW"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'JA'), code:"JA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'JI'), code:"JI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'JW'), code:"JW"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KA'), code:"KA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KK'), code:"KK"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KL'), code:"KL"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KM'), code:"KM"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KN'), code:"KN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KO'), code:"KO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KS'), code:"KS"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KU'), code:"KU"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'KY'), code:"KY"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LA'), code:"LA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LN'), code:"LN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LO'), code:"LO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LT'), code:"LT"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'LV'), code:"LV"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MG'), code:"MG"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MI'), code:"MI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MK'), code:"MK"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ML'), code:"ML"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MN'), code:"MN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MO'), code:"MO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MR'), code:"MR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MS'), code:"MS"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MT'), code:"MT"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'MY'), code:"MY"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NA'), code:"NA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NE'), code:"NE"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NL'), code:"NL"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'NO'), code:"NO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'OC'), code:"OC"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'OM'), code:"OM"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'OR'), code:"OR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PA'), code:"PA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PL'), code:"PL"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PS'), code:"PS"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'PT'), code:"PT"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'QU'), code:"QU"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RM'), code:"RM"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RN'), code:"RN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RO'), code:"RO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RU'), code:"RU"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'RW'), code:"RW"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SA'), code:"SA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SD'), code:"SD"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SG'), code:"SG"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SH'), code:"SH"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SI'), code:"SI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SK'), code:"SK"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SL'), code:"SL"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SM'), code:"SM"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SN'), code:"SN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SO'), code:"SO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SQ'), code:"SQ"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SR'), code:"SR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SS'), code:"SS"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ST'), code:"ST"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SU'), code:"SU"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SV'), code:"SV"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'SW'), code:"SW"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TA'), code:"TA"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TE'), code:"TE"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TG'), code:"TG"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TH'), code:"TH"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TI'), code:"TI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TK'), code:"TK"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TL'), code:"TL"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TN'), code:"TN"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TO'), code:"TO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TR'), code:"TR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TS'), code:"TS"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TT'), code:"TT"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'TW'), code:"TW"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'UK'), code:"UK"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'UR'), code:"UR"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'UZ'), code:"UZ"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'VI'), code:"VI"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'VO'), code:"VO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'WO'), code:"WO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'XH'), code:"XH"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'YO'), code:"YO"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ZH'), code:"ZH"});
			languagesArr.addItem({label:ResourceManager.getInstance().getString('languages', 'ZU'), code:"ZU"});
		
			var nameSortField:SortField = new SortField();
            nameSortField.name = "label";
            nameSortField.numeric = false;

			var nameDataSort:Sort = new Sort();
            nameDataSort.fields = [nameSortField];
			languagesArr.sort = nameDataSort;
            languagesArr.refresh();
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
				languagesMap.put(lang.code, lang);
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
			var lang:Object = languagesMap.getValue(code.toUpperCase());
			return lang;
		}

	}
}
class Enforcer
{
	
}