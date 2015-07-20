package com.kaltura.utils {
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.types.KalturaLanguage;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;

	/**
	 * Singleton class
	 * This util class handles all issues related to Languages UI - including the locales for all countries
	 */
	public class KLanguageUtil {
		[ResourceBundle("languages")]
		private static var rb:ResourceBundle;

		/**
		 * Singleton instance
		 */
		private static var _instance:KLanguageUtil = null;

		/**
		 * language.code => language Object
		 * language.value => language Object
		 * (for easy access)
		 */
		private var _languagesMap:HashMap = new HashMap();

		/**
		 * {label: localized language name, code: upper-case language code, value:KalturaLanguage.<code>}
		 */
		private var _languagesArr:ArrayCollection = new ArrayCollection();


		/**
		 * C'tor
		 */
		public function KLanguageUtil(enforcer:Enforcer) {
			initLanguagesArr();
			initlanguagesMap();
		}


		public static function get instance():KLanguageUtil {
			if (_instance == null) {
				_instance = new KLanguageUtil(new Enforcer());
			}

			return _instance;
		}


		/***
		 * Get the list of all languages
		 */
		public function get languagesArr():ArrayCollection {
			return _languagesArr;
		}


		/**
		 * This function is used to get the language object
		 * The object is with fields : code, label and index
		 * code - language code
		 * label - language label in the active locale
		 * index - the index of the language in the languages array collection
		 * @param code - language code
		 * @return langauge object
		 */
		public function getLanguageByCode(code:String):Object {
			var lang:Object = _languagesMap.getValue(code.toUpperCase());
			return lang;
		}


		private function initLanguagesArr():void {
			var rm:IResourceManager = ResourceManager.getInstance();
			var tmp:Array = [
				{label: rm.getString('languages', 'AA'), code: "AA", value:KalturaLanguage.AA},
				{label: rm.getString('languages', 'AB'), code: "AB", value:KalturaLanguage.AB},
				{label: rm.getString('languages', 'AF'), code: "AF", value:KalturaLanguage.AF},
				{label: rm.getString('languages', 'AM'), code: "AM", value:KalturaLanguage.AM},
				{label: rm.getString('languages', 'AR'), code: "AR", value:KalturaLanguage.AR},
				{label: rm.getString('languages', 'AS'), code: "AS", value:KalturaLanguage.AS_},
				{label: rm.getString('languages', 'AY'), code: "AY", value:KalturaLanguage.AY},
				{label: rm.getString('languages', 'AZ'), code: "AZ", value:KalturaLanguage.AZ},
				{label: rm.getString('languages', 'BA'), code: "BA", value:KalturaLanguage.BA},
				{label: rm.getString('languages', 'BE'), code: "BE", value:KalturaLanguage.BE},
				{label: rm.getString('languages', 'BG'), code: "BG", value:KalturaLanguage.BG},
				{label: rm.getString('languages', 'BH'), code: "BH", value:KalturaLanguage.BH},
				{label: rm.getString('languages', 'BI'), code: "BI", value:KalturaLanguage.BI},
				{label: rm.getString('languages', 'BN'), code: "BN", value:KalturaLanguage.BN},
				{label: rm.getString('languages', 'BO'), code: "BO", value:KalturaLanguage.BO},
				{label: rm.getString('languages', 'BR'), code: "BR", value:KalturaLanguage.BR},
				{label: rm.getString('languages', 'CA'), code: "CA", value:KalturaLanguage.CA},
				{label: rm.getString('languages', 'CO'), code: "CO", value:KalturaLanguage.CO},
				{label: rm.getString('languages', 'CS'), code: "CS", value:KalturaLanguage.CS},
				{label: rm.getString('languages', 'CY'), code: "CY", value:KalturaLanguage.CY},
				{label: rm.getString('languages', 'DA'), code: "DA", value:KalturaLanguage.DA},
				{label: rm.getString('languages', 'DE'), code: "DE", value:KalturaLanguage.DE},
				{label: rm.getString('languages', 'DZ'), code: "DZ", value:KalturaLanguage.DZ},
				{label: rm.getString('languages', 'EL'), code: "EL", value:KalturaLanguage.EL},
//				{label: rm.getString('languages', 'EN'), code: "EN", value:KalturaLanguage.EN},
				{label: rm.getString('languages', 'EN_GB'), code: "EN_GB", value:KalturaLanguage.EN_GB},
				{label: rm.getString('languages', 'EN_US'), code: "EN_US", value:KalturaLanguage.EN_US},
				{label: rm.getString('languages', 'EO'), code: "EO", value:KalturaLanguage.EO},
				{label: rm.getString('languages', 'ES'), code: "ES", value:KalturaLanguage.ES},
				{label: rm.getString('languages', 'ET'), code: "ET", value:KalturaLanguage.ET},
				{label: rm.getString('languages', 'EU'), code: "EU", value:KalturaLanguage.EU},
				{label: rm.getString('languages', 'FA'), code: "FA", value:KalturaLanguage.FA},
				{label: rm.getString('languages', 'FI'), code: "FI", value:KalturaLanguage.FI},
				{label: rm.getString('languages', 'FJ'), code: "FJ", value:KalturaLanguage.FJ},
				{label: rm.getString('languages', 'FO'), code: "FO", value:KalturaLanguage.FO},
				{label: rm.getString('languages', 'FR'), code: "FR", value:KalturaLanguage.FR},
				{label: rm.getString('languages', 'FY'), code: "FY", value:KalturaLanguage.FY},
				{label: rm.getString('languages', 'GA'), code: "GA", value:KalturaLanguage.GA},
				{label: rm.getString('languages', 'GD'), code: "GD", value:KalturaLanguage.GD},
				{label: rm.getString('languages', 'GL'), code: "GL", value:KalturaLanguage.GL},
				{label: rm.getString('languages', 'GN'), code: "GN", value:KalturaLanguage.GN},
				{label: rm.getString('languages', 'GU'), code: "GU", value:KalturaLanguage.GU},
				{label: rm.getString('languages', 'HA'), code: "HA", value:KalturaLanguage.HA},
				{label: rm.getString('languages', 'HI'), code: "HI", value:KalturaLanguage.HI},
				{label: rm.getString('languages', 'HR'), code: "HR", value:KalturaLanguage.HR},
				{label: rm.getString('languages', 'HU'), code: "HU", value:KalturaLanguage.HU},
				{label: rm.getString('languages', 'HY'), code: "HY", value:KalturaLanguage.HY},
				{label: rm.getString('languages', 'IA'), code: "IA", value:KalturaLanguage.IA},
				{label: rm.getString('languages', 'IE'), code: "IE", value:KalturaLanguage.IE},
				{label: rm.getString('languages', 'IK'), code: "IK", value:KalturaLanguage.IK},
				{label: rm.getString('languages', 'IN'), code: "IN", value:KalturaLanguage.IN},
				{label: rm.getString('languages', 'IS'), code: "IS", value:KalturaLanguage.IS},
				{label: rm.getString('languages', 'IT'), code: "IT", value:KalturaLanguage.IT},
				{label: rm.getString('languages', 'IW'), code: "IW", value:KalturaLanguage.IW},
				{label: rm.getString('languages', 'JA'), code: "JA", value:KalturaLanguage.JA},
				{label: rm.getString('languages', 'JI'), code: "JI", value:KalturaLanguage.JI},
				{label: rm.getString('languages', 'JW'), code: "JW", value:KalturaLanguage.JV},
				{label: rm.getString('languages', 'KA'), code: "KA", value:KalturaLanguage.KA},
				{label: rm.getString('languages', 'KK'), code: "KK", value:KalturaLanguage.KK},
				{label: rm.getString('languages', 'KL'), code: "KL", value:KalturaLanguage.KL},
				{label: rm.getString('languages', 'KM'), code: "KM", value:KalturaLanguage.KM},
				{label: rm.getString('languages', 'KN'), code: "KN", value:KalturaLanguage.KN},
				{label: rm.getString('languages', 'KO'), code: "KO", value:KalturaLanguage.KO},
				{label: rm.getString('languages', 'KS'), code: "KS", value:KalturaLanguage.KS},
				{label: rm.getString('languages', 'KU'), code: "KU", value:KalturaLanguage.KU},
				{label: rm.getString('languages', 'KY'), code: "KY", value:KalturaLanguage.KY},
				{label: rm.getString('languages', 'LA'), code: "LA", value:KalturaLanguage.LA},
				{label: rm.getString('languages', 'LN'), code: "LN", value:KalturaLanguage.LN},
				{label: rm.getString('languages', 'LO'), code: "LO", value:KalturaLanguage.LO},
				{label: rm.getString('languages', 'LT'), code: "LT", value:KalturaLanguage.LT},
				{label: rm.getString('languages', 'LV'), code: "LV", value:KalturaLanguage.LV},
				{label: rm.getString('languages', 'MG'), code: "MG", value:KalturaLanguage.MG},
				{label: rm.getString('languages', 'MI'), code: "MI", value:KalturaLanguage.MI},
				{label: rm.getString('languages', 'MK'), code: "MK", value:KalturaLanguage.MK},
				{label: rm.getString('languages', 'ML'), code: "ML", value:KalturaLanguage.ML},
				{label: rm.getString('languages', 'MN'), code: "MN", value:KalturaLanguage.MN},
				{label: rm.getString('languages', 'MU'), code: "MU", value:KalturaLanguage.MU},
				{label: rm.getString('languages', 'MO'), code: "MO", value:KalturaLanguage.MO},
				{label: rm.getString('languages', 'MR'), code: "MR", value:KalturaLanguage.MR},
				{label: rm.getString('languages', 'MS'), code: "MS", value:KalturaLanguage.MS},
				{label: rm.getString('languages', 'MT'), code: "MT", value:KalturaLanguage.MT},
				{label: rm.getString('languages', 'MY'), code: "MY", value:KalturaLanguage.MY},
				{label: rm.getString('languages', 'NA'), code: "NA", value:KalturaLanguage.NA},
				{label: rm.getString('languages', 'NE'), code: "NE", value:KalturaLanguage.NE},
				{label: rm.getString('languages', 'NL'), code: "NL", value:KalturaLanguage.NL},
				{label: rm.getString('languages', 'NO'), code: "NO", value:KalturaLanguage.NO},
				{label: rm.getString('languages', 'OC'), code: "OC", value:KalturaLanguage.OC},
				{label: rm.getString('languages', 'OM'), code: "OM", value:KalturaLanguage.OM},
				{label: rm.getString('languages', 'OR'), code: "OR", value:KalturaLanguage.OR_},
				{label: rm.getString('languages', 'PA'), code: "PA", value:KalturaLanguage.PA},
				{label: rm.getString('languages', 'PL'), code: "PL", value:KalturaLanguage.PL},
				{label: rm.getString('languages', 'PS'), code: "PS", value:KalturaLanguage.PS},
				{label: rm.getString('languages', 'PT'), code: "PT", value:KalturaLanguage.PT},
				{label: rm.getString('languages', 'QU'), code: "QU", value:KalturaLanguage.QU},
				{label: rm.getString('languages', 'RM'), code: "RM", value:KalturaLanguage.RM},
				{label: rm.getString('languages', 'RN'), code: "RN", value:KalturaLanguage.RN},
				{label: rm.getString('languages', 'RO'), code: "RO", value:KalturaLanguage.RO},
				{label: rm.getString('languages', 'RU'), code: "RU", value:KalturaLanguage.RU},
				{label: rm.getString('languages', 'RW'), code: "RW", value:KalturaLanguage.RW},
				{label: rm.getString('languages', 'SA'), code: "SA", value:KalturaLanguage.SA},
				{label: rm.getString('languages', 'SD'), code: "SD", value:KalturaLanguage.SD},
				{label: rm.getString('languages', 'SG'), code: "SG", value:KalturaLanguage.SG},
				{label: rm.getString('languages', 'SH'), code: "SH", value:KalturaLanguage.SH},
				{label: rm.getString('languages', 'SI'), code: "SI", value:KalturaLanguage.SI},
				{label: rm.getString('languages', 'SK'), code: "SK", value:KalturaLanguage.SK},
				{label: rm.getString('languages', 'SL'), code: "SL", value:KalturaLanguage.SL},
				{label: rm.getString('languages', 'SM'), code: "SM", value:KalturaLanguage.SM},
				{label: rm.getString('languages', 'SN'), code: "SN", value:KalturaLanguage.SN},
				{label: rm.getString('languages', 'SO'), code: "SO", value:KalturaLanguage.SO},
				{label: rm.getString('languages', 'SQ'), code: "SQ", value:KalturaLanguage.SQ},
				{label: rm.getString('languages', 'SR'), code: "SR", value:KalturaLanguage.SR},
				{label: rm.getString('languages', 'SS'), code: "SS", value:KalturaLanguage.SS},
				{label: rm.getString('languages', 'ST'), code: "ST", value:KalturaLanguage.ST},
				{label: rm.getString('languages', 'SU'), code: "SU", value:KalturaLanguage.SU},
				{label: rm.getString('languages', 'SV'), code: "SV", value:KalturaLanguage.SV},
				{label: rm.getString('languages', 'SW'), code: "SW", value:KalturaLanguage.SW},
				{label: rm.getString('languages', 'TA'), code: "TA", value:KalturaLanguage.TA},
				{label: rm.getString('languages', 'TE'), code: "TE", value:KalturaLanguage.TE},
				{label: rm.getString('languages', 'TG'), code: "TG", value:KalturaLanguage.TG},
				{label: rm.getString('languages', 'TH'), code: "TH", value:KalturaLanguage.TH},
				{label: rm.getString('languages', 'TI'), code: "TI", value:KalturaLanguage.TI},
				{label: rm.getString('languages', 'TK'), code: "TK", value:KalturaLanguage.TK},
				{label: rm.getString('languages', 'TL'), code: "TL", value:KalturaLanguage.TL},
				{label: rm.getString('languages', 'TN'), code: "TN", value:KalturaLanguage.TN},
				{label: rm.getString('languages', 'TO'), code: "TO", value:KalturaLanguage.TO},
				{label: rm.getString('languages', 'TR'), code: "TR", value:KalturaLanguage.TR},
				{label: rm.getString('languages', 'TS'), code: "TS", value:KalturaLanguage.TS},
				{label: rm.getString('languages', 'TT'), code: "TT", value:KalturaLanguage.TT},
				{label: rm.getString('languages', 'TW'), code: "TW", value:KalturaLanguage.TW},
				{label: rm.getString('languages', 'UK'), code: "UK", value:KalturaLanguage.UK},
				{label: rm.getString('languages', 'UR'), code: "UR", value:KalturaLanguage.UR},
				{label: rm.getString('languages', 'UZ'), code: "UZ", value:KalturaLanguage.UZ},
				{label: rm.getString('languages', 'VI'), code: "VI", value:KalturaLanguage.VI},
				{label: rm.getString('languages', 'VO'), code: "VO", value:KalturaLanguage.VO},
				{label: rm.getString('languages', 'WO'), code: "WO", value:KalturaLanguage.WO},
				{label: rm.getString('languages', 'XH'), code: "XH", value:KalturaLanguage.XH},
				{label: rm.getString('languages', 'YO'), code: "YO", value:KalturaLanguage.YO},
				{label: rm.getString('languages', 'ZH'), code: "ZH", value:KalturaLanguage.ZH},
				{label: rm.getString('languages', 'ZU'), code: "ZU", value:KalturaLanguage.ZU}
			];
			tmp.sortOn('label');
			// put english first
			tmp.unshift({label: rm.getString('languages', 'EN'), code: "EN", value:KalturaLanguage.EN});
			_languagesArr = new ArrayCollection(tmp);
		}


		/**
		 * for each language, keep in hashmap both by name (KalturaLanguage) and code 
		 */
		private function initlanguagesMap():void {
			var index:int = 0;
			for each (var lang:Object in _languagesArr) {
				lang.index = index;
				_languagesMap.put(lang.code, lang);
				_languagesMap.put(lang.value.toUpperCase(), lang);
				index++;
			}
		}


//		public static const GV : String = 'Gaelic (Manx)';
//		public static const HE : String = 'Hebrew';
//		public static const ID : String = 'Indonesian';
//		public static const IU : String = 'Inuktitut';
//		public static const LI : String = 'Limburgish ( Limburger)';
//		public static const UG : String = 'Uighur';
//		public static const YI : String = 'Yiddish';


	}
}

class Enforcer {

}
