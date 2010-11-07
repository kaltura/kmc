package com.kaltura.kmc.modules.account.view.paypal 
{
	
	import mx.controls.ComboBox;
	import mx.collections.ArrayCollection;

	public class CountryCombo extends ComboBox {
		
		private var _countryData:ArrayCollection;
		private var _defaultcountry:String;
		
		function CountryCombo() {
			super();
			this.prompt =  resourceManager.getString('kmc','chooseCountry');
			this.labelField = "country";
			this.setDataProvider();
		}
		
		private function setDataProvider():void {
			this._countryData = new ArrayCollection();
			this._countryData.addItem({country:"Afghanistan",code:"AF"});
			this._countryData.addItem({country:"Albania",code:"AL"});
			this._countryData.addItem({country:"Algeria",code:"DZ"});
			this._countryData.addItem({country:"American Samoa",code:"AS"});
			this._countryData.addItem({country:"Andorra",code:"AD"});
			this._countryData.addItem({country:"Angola",code:"AO"});
			this._countryData.addItem({country:"Anguilla",code:"AI"});
			this._countryData.addItem({country:"Antarctica",code:"AQ"});
			this._countryData.addItem({country:"Antigua and Barbuda",code:"AG"});
			this._countryData.addItem({country:"Argentina",code:"AR"});
			this._countryData.addItem({country:"Armenia",code:"AM"});
			this._countryData.addItem({country:"Aruba",code:"AW"});
			this._countryData.addItem({country:"Ascension Island",code:"AC"});
			this._countryData.addItem({country:"Australia",code:"AU"});
			this._countryData.addItem({country:"Austria",code:"AT"});
			this._countryData.addItem({country:"Azerbaijan",code:"AZ"});
			this._countryData.addItem({country:"Bahamas",code:"BS"});
			this._countryData.addItem({country:"Bahrain",code:"BH"});
			this._countryData.addItem({country:"Bangladesh",code:"BD"});
			this._countryData.addItem({country:"Barbados",code:"BB"});
			this._countryData.addItem({country:"Belarus",code:"BY"});
			this._countryData.addItem({country:"Belgium",code:"BE"});
			this._countryData.addItem({country:"Belize",code:"BZ"});
			this._countryData.addItem({country:"Benin",code:"BJ"});
			this._countryData.addItem({country:"Bermuda",code:"BM"});
			this._countryData.addItem({country:"Bhutan",code:"BT"});
			this._countryData.addItem({country:"Bolivia",code:"BO"});
			this._countryData.addItem({country:"Bosnia and Herzegovina",code:"BA"});
			this._countryData.addItem({country:"Botswana",code:"BW"});
			this._countryData.addItem({country:"Bouvet Island",code:"BV"});
			this._countryData.addItem({country:"Brazil",code:"BR"});
			this._countryData.addItem({country:"British Indian Ocean Territory",code:"IO"});
			this._countryData.addItem({country:"Brunei",code:"BN"});
			this._countryData.addItem({country:"Bulgaria",code:"BG"});
			this._countryData.addItem({country:"Burkina Faso",code:"BF"});
			this._countryData.addItem({country:"Burundi",code:"BI"});
			this._countryData.addItem({country:"Cambodia",code:"KH"});
			this._countryData.addItem({country:"Cameroon",code:"CM"});
			this._countryData.addItem({country:"Canada",code:"CA"});
			this._countryData.addItem({country:"Cape Verde",code:"CV"});
			this._countryData.addItem({country:"Cayman Islands",code:"KY"});
			this._countryData.addItem({country:"Central African Republic",code:"CF"});
			this._countryData.addItem({country:"Chad",code:"TD"});
			this._countryData.addItem({country:"Chile",code:"CL"});
			this._countryData.addItem({country:"China",code:"CN"});
			this._countryData.addItem({country:"Christmas Island",code:"CX"});
			this._countryData.addItem({country:"Cocos (Keeling) Islands",code:"CC"});
			this._countryData.addItem({country:"Colombia",code:"CO"});
			this._countryData.addItem({country:"Comoros",code:"KM"});
			this._countryData.addItem({country:"Congo",code:"CG"});
			this._countryData.addItem({country:"Congo (DRC)",code:"CD"});
			this._countryData.addItem({country:"Cook Islands",code:"CK"});
			this._countryData.addItem({country:"Costa Rica",code:"CR"});
			this._countryData.addItem({country:"Côte d'Ivoire",code:"CI"});
			this._countryData.addItem({country:"Croatia",code:"HR"});
			this._countryData.addItem({country:"Cuba",code:"CU"});
			this._countryData.addItem({country:"Cyprus",code:"CY"});
			this._countryData.addItem({country:"Czech Republic",code:"CZ"});
			this._countryData.addItem({country:"Denmark",code:"DK"});
			this._countryData.addItem({country:"Djibouti",code:"DJ"});
			this._countryData.addItem({country:"Dominica",code:"DM"});
			this._countryData.addItem({country:"Dominican Republic",code:"DO"});
			this._countryData.addItem({country:"Ecuador",code:"EC"});
			this._countryData.addItem({country:"Egypt",code:"EG"});
			this._countryData.addItem({country:"El Salvador",code:"SV"});
			this._countryData.addItem({country:"Equatorial Guinea",code:"GQ"});
			this._countryData.addItem({country:"Eritrea",code:"ER"});
			this._countryData.addItem({country:"Estonia",code:"EE"});
			this._countryData.addItem({country:"Ethiopia",code:"ET"});
			this._countryData.addItem({country:"Falkland Islands (Islas Malvinas)",code:"FK"});
			this._countryData.addItem({country:"Faroe Islands",code:"FO"});
			this._countryData.addItem({country:"Fiji Islands",code:"FJ"});
			this._countryData.addItem({country:"Finland",code:"FI"});
			this._countryData.addItem({country:"France",code:"FR"});
			this._countryData.addItem({country:"French Guiana",code:"GF"});
			this._countryData.addItem({country:"French Polynesia",code:"PF"});
			this._countryData.addItem({country:"French Southern and Antarctic Lands",code:"TF"});
			this._countryData.addItem({country:"Gabon",code:"GA"});
			this._countryData.addItem({country:"Gambia, The",code:"GM"});
			this._countryData.addItem({country:"Georgia",code:"GE"});
			this._countryData.addItem({country:"Germany",code:"DE"});
			this._countryData.addItem({country:"Ghana",code:"GH"});
			this._countryData.addItem({country:"Gibraltar",code:"GI"});
			this._countryData.addItem({country:"Greece",code:"GR"});
			this._countryData.addItem({country:"Greenland",code:"GL"});
			this._countryData.addItem({country:"Grenada",code:"GD"});
			this._countryData.addItem({country:"Guadeloupe",code:"GP"});
			this._countryData.addItem({country:"Guam",code:"GU"});
			this._countryData.addItem({country:"Guatemala",code:"GT"});
			this._countryData.addItem({country:"Guernsey",code:"GG"});
			this._countryData.addItem({country:"Guinea",code:"GN"});
			this._countryData.addItem({country:"Guinea-Bissau",code:"GW"});
			this._countryData.addItem({country:"Guyana",code:"GY"});
			this._countryData.addItem({country:"Haiti",code:"HT"});
			this._countryData.addItem({country:"Heard Island and McDonald Islands",code:"HM"});
			this._countryData.addItem({country:"Honduras",code:"HN"});
			this._countryData.addItem({country:"Hong Kong SAR",code:"HK"});
			this._countryData.addItem({country:"Hungary",code:"HU"});
			this._countryData.addItem({country:"Iceland",code:"IS"});
			this._countryData.addItem({country:"India",code:"IN"});
			this._countryData.addItem({country:"Indonesia",code:"ID"});
			this._countryData.addItem({country:"Iran",code:"IR"});
			this._countryData.addItem({country:"Iraq",code:"IQ"});
			this._countryData.addItem({country:"Ireland",code:"IE"});
			this._countryData.addItem({country:"Isle of Man",code:"IM"});
			this._countryData.addItem({country:"Israel",code:"IL"});
			this._countryData.addItem({country:"Italy",code:"IT"});
			this._countryData.addItem({country:"Jamaica",code:"JM"});
			this._countryData.addItem({country:"Japan",code:"JP"});
			this._countryData.addItem({country:"Jersey",code:"JE"});
			this._countryData.addItem({country:"Jordan",code:"JO"});
			this._countryData.addItem({country:"Kazakhstan",code:"KZ"});
			this._countryData.addItem({country:"Kenya",code:"KE"});
			this._countryData.addItem({country:"Kiribati",code:"KI"});
			this._countryData.addItem({country:"Korea",code:"KR"});
			this._countryData.addItem({country:"Kuwait",code:"KW"});
			this._countryData.addItem({country:"Kyrgyzstan",code:"KG"});
			this._countryData.addItem({country:"Laos",code:"LA"});
			this._countryData.addItem({country:"Latvia",code:"LV"});
			this._countryData.addItem({country:"Lebanon",code:"LB"});
			this._countryData.addItem({country:"Lesotho",code:"LS"});
			this._countryData.addItem({country:"Liberia",code:"LR"});
			this._countryData.addItem({country:"Libya",code:"LY"});
			this._countryData.addItem({country:"Liechtenstein",code:"LI"});
			this._countryData.addItem({country:"Lithuania",code:"LT"});
			this._countryData.addItem({country:"Luxembourg",code:"LU"});
			this._countryData.addItem({country:"Macao SAR",code:"MO"});
			this._countryData.addItem({country:"Macedonia, Former Yugoslav Republic of",code:"MK"});
			this._countryData.addItem({country:"Madagascar",code:"MG"});
			this._countryData.addItem({country:"Malawi",code:"MW"});
			this._countryData.addItem({country:"Malaysia",code:"MY"});
			this._countryData.addItem({country:"Maldives",code:"MV"});
			this._countryData.addItem({country:"Mali",code:"ML"});
			this._countryData.addItem({country:"Malta",code:"MT"});
			this._countryData.addItem({country:"Marshall Islands",code:"MH"});
			this._countryData.addItem({country:"Martinique",code:"MQ"});
			this._countryData.addItem({country:"Mauritania",code:"MR"});
			this._countryData.addItem({country:"Mauritius",code:"MU"});
			this._countryData.addItem({country:"Mayotte",code:"YT"});
			this._countryData.addItem({country:"Mexico",code:"MX"});
			this._countryData.addItem({country:"Micronesia",code:"FM"});
			this._countryData.addItem({country:"Moldova",code:"MD"});
			this._countryData.addItem({country:"Monaco",code:"MC"});
			this._countryData.addItem({country:"Mongolia",code:"MN"});
			this._countryData.addItem({country:"Montserrat",code:"MS"});
			this._countryData.addItem({country:"Morocco",code:"MA"});
			this._countryData.addItem({country:"Mozambique",code:"MZ"});
			this._countryData.addItem({country:"Myanmar",code:"MM"});
			this._countryData.addItem({country:"Namibia",code:"NA"});
			this._countryData.addItem({country:"Nauru",code:"NR"});
			this._countryData.addItem({country:"Nepal",code:"NP"});
			this._countryData.addItem({country:"Netherlands",code:"NL"});
			this._countryData.addItem({country:"Netherlands Antilles",code:"AN"});
			this._countryData.addItem({country:"New Caledonia",code:"NC"});
			this._countryData.addItem({country:"New Zealand",code:"NZ"});
			this._countryData.addItem({country:"Nicaragua",code:"NI"});
			this._countryData.addItem({country:"Niger",code:"NE"});
			this._countryData.addItem({country:"Nigeria",code:"NG"});
			this._countryData.addItem({country:"Niue",code:"NU"});
			this._countryData.addItem({country:"Norfolk Island",code:"NF"});
			this._countryData.addItem({country:"North Korea",code:"KP"});
			this._countryData.addItem({country:"Northern Mariana Islands",code:"MP"});
			this._countryData.addItem({country:"Norway",code:"NO"});
			this._countryData.addItem({country:"Oman",code:"OM"});
			this._countryData.addItem({country:"Pakistan",code:"PK"});
			this._countryData.addItem({country:"Palau",code:"PW"});
			this._countryData.addItem({country:"Palestinian Authority",code:"PS"});
			this._countryData.addItem({country:"Panama",code:"PA"});
			this._countryData.addItem({country:"Papua New Guinea",code:"PG"});
			this._countryData.addItem({country:"Paraguay",code:"PY"});
			this._countryData.addItem({country:"Peru",code:"PE"});
			this._countryData.addItem({country:"Philippines",code:"PH"});
			this._countryData.addItem({country:"Pitcairn Islands",code:"PN"});
			this._countryData.addItem({country:"Poland",code:"PL"});
			this._countryData.addItem({country:"Portugal",code:"PT"});
			this._countryData.addItem({country:"Puerto Rico",code:"PR"});
			this._countryData.addItem({country:"Qatar",code:"QA"});
			this._countryData.addItem({country:"Reunion",code:"RE"});
			this._countryData.addItem({country:"Romania",code:"RO"});
			this._countryData.addItem({country:"Russia",code:"RU"});
			this._countryData.addItem({country:"Rwanda",code:"RW"});
			this._countryData.addItem({country:"Samoa",code:"WS"});
			this._countryData.addItem({country:"San Marino",code:"SM"});
			this._countryData.addItem({country:"São Tomé and Príncipe",code:"ST"});
			this._countryData.addItem({country:"Saudi Arabia",code:"SA"});
			this._countryData.addItem({country:"Senegal",code:"SN"});
			this._countryData.addItem({country:"Serbia, Montenegro",code:"YU"});
			this._countryData.addItem({country:"Seychelles",code:"SC"});
			this._countryData.addItem({country:"Sierra Leone",code:"SL"});
			this._countryData.addItem({country:"Singapore",code:"SG"});
			this._countryData.addItem({country:"Slovakia",code:"SK"});
			this._countryData.addItem({country:"Slovenia",code:"SI"});
			this._countryData.addItem({country:"Solomon Islands",code:"SB"});
			this._countryData.addItem({country:"Somalia",code:"SO"});
			this._countryData.addItem({country:"South Africa",code:"ZA"});
			this._countryData.addItem({country:"South Georgia and the South Sandwich Islands",code:"GS"});
			this._countryData.addItem({country:"Spain",code:"ES"});
			this._countryData.addItem({country:"Sri Lanka",code:"LK"});
			this._countryData.addItem({country:"St. Helena",code:"SH"});
			this._countryData.addItem({country:"St. Kitts and Nevis",code:"KN"});
			this._countryData.addItem({country:"St. Lucia",code:"LC"});
			this._countryData.addItem({country:"St. Pierre and Miquelon",code:"PM"});
			this._countryData.addItem({country:"St. Vincent and the Grenadines",code:"VC"});
			this._countryData.addItem({country:"Sudan",code:"SD"});
			this._countryData.addItem({country:"Suriname",code:"SR"});
			this._countryData.addItem({country:"Svalbard and Jan Mayen",code:"SJ"});
			this._countryData.addItem({country:"Swaziland",code:"SZ"});
			this._countryData.addItem({country:"Sweden",code:"SE"});
			this._countryData.addItem({country:"Switzerland",code:"CH"});
			this._countryData.addItem({country:"Syria",code:"SY"});
			this._countryData.addItem({country:"Taiwan",code:"TW"});
			this._countryData.addItem({country:"Tajikistan",code:"TJ"});
			this._countryData.addItem({country:"Tanzania",code:"TZ"});
			this._countryData.addItem({country:"Thailand",code:"TH"});
			this._countryData.addItem({country:"Timor-Leste",code:"TP"});
			this._countryData.addItem({country:"Togo",code:"TG"});
			this._countryData.addItem({country:"Tokelau",code:"TK"});
			this._countryData.addItem({country:"Tonga",code:"TO"});
			this._countryData.addItem({country:"Trinidad and Tobago",code:"TT"});
			this._countryData.addItem({country:"Tristan da Cunha",code:"TA"});
			this._countryData.addItem({country:"Tunisia",code:"TN"});
			this._countryData.addItem({country:"Turkey",code:"TR"});
			this._countryData.addItem({country:"Turkmenistan",code:"TM"});
			this._countryData.addItem({country:"Turks and Caicos Islands",code:"TC"});
			this._countryData.addItem({country:"Tuvalu",code:"TV"});
			this._countryData.addItem({country:"Uganda",code:"UG"});
			this._countryData.addItem({country:"Ukraine",code:"UA"});
			this._countryData.addItem({country:"United Arab Emirates",code:"AE"});
			this._countryData.addItem({country:"United Kingdom",code:"UK"});
			this._countryData.addItem({country:"United States",code:"US"});
			this._countryData.addItem({country:"United States Minor Outlying Islands",code:"UM"});
			this._countryData.addItem({country:"Uruguay",code:"UY"});
			this._countryData.addItem({country:"Uzbekistan",code:"UZ"});
			this._countryData.addItem({country:"Vanuatu",code:"VU"});
			this._countryData.addItem({country:"Vatican City",code:"VA"});
			this._countryData.addItem({country:"Venezuela",code:"VE"});
			this._countryData.addItem({country:"Vietnam",code:"VN"});
			this._countryData.addItem({country:"Virgin Islands",code:"VI"});
			this._countryData.addItem({country:"Virgin Islands, British",code:"VG"});
			this._countryData.addItem({country:"Wallis and Futuna",code:"WF"});
			this._countryData.addItem({country:"Yemen",code:"YE"});
			this._countryData.addItem({country:"Zambia",code:"ZM"});
			this._countryData.addItem({country:"Zimbabwe",code:"ZW"});
			this.dataProvider = this._countryData;
		}
		
		private function setCountry():void {
			for(var i:uint=0; i<this._countryData.length; i++) {
				var tmp:Object = this._countryData.getItemAt(i);
				if(this._defaultcountry.length == 2) {
					if(tmp.code == this._defaultcountry.toUpperCase()) {
						this.selectedIndex = i;
					}
				} else {
					if(String(tmp.country).toLowerCase() == this._defaultcountry.toLowerCase()) {
						this.selectedIndex = i;
					}					
				}
			}
		}
		
		[Bindable]
		public function get label():String {
			return this.prompt;
		}
		public function set label(val:String):void {
			this.prompt = val;
			this.setDataProvider();
		}
		
		[Bindable]
		public function get defaultcountry():String {
			return this._defaultcountry;
		}
		public function set defaultcountry(val:String):void {
			this._defaultcountry = val;
			this.setCountry();
		}
		
		
	}
	
}