//alert("service_url="+kmc.vars.service_url +"\n host=" + kmc.vars.host + "\n cdn_host=" + kmc.vars.cdn_host + " \n flash_dir=" + kmc.vars.flash_dir);
// @todo:
//		* Must do / should do:
//			* Graphics:
//				* overlay
//				* replace inline styles with classes
//			* Implement embed code template from server
//			* logout() shouldn't have to location.href to '/index.php/kmc/' (should already be ok on prod)
// *		* Fix uiconf names ("Kaltura", jw playlist names) (Gonen)
//
//		* Maybe / not that important / takes too long - pushed to Blackeye:
//			* why is srvurl flashvar hardcoded to "api_v3/index.php" (why not from kconf.php)
//			* organize kmcSuccess
//			* remove openPlayer/ openPlaylist flashvars for 2.0.9
//			* move some jw code into own sub-object (doJw)
//			* memory profiling
//				* nullify preview players
//				* kill swf's - profiling
//			* understand setObjectToRemove and use or remove
//			* move cookie functions to kmc.utils
//			* get rid of legacy functions
//			* a few leftover @todo's inside code
//			* deactivate header on openning of flash modal (Eitan)
//			* In p&e, if mix, show only message box for jw (Yaron)
//			* Full copy to clipboard
//			* Flavors preview to display based on flavor size with logic for not exceeding available screen area



//$(function(){
////	alert("dom ready:  setState("+kmc.mediator.readUrlHash()[0]+","+kmc.mediator.readUrlHash()[1]+")");
//	kmc.mediator.setState(kmc.mediator.readUrlHash());
////	alert("done setState");
//	kmc.utils.activateHeader(true);
////	alert("done activateHeader");
//
//	$(window).wresize(kmc.utils.resize);
//	kmc.modules.isLoadedInterval = setInterval("kmc.utils.isModuleLoaded()",200);
////	content_resize();
//
//});

/* kmc and kmc.vars defined in script block in kmc2success.php */
var kmc = {
		vars : {
			service_url		: "http://kaldev.kaltura.com",
			host			: "kaldev.kaltura.com",
			cdn_host		: "cdnkaldev.kaltura.com",
			rtmp_host		: "rtmp://rtmp2.kaltura.co.cc/ondemand",
			flash_dir		: "http://cdnkaldev.kaltura.com/flash",
			createmix_url	: "/index.php/kmc/createmix",
			getuiconfs_url	: "/index.php/kmc/getuiconfs",
			terms_of_use	: "index.php/terms",
			jw_swf			: "non-commercial.swf",
			ks				: "YTFlYWNkYTFmOTlmZDgwY2MwZWNiNTY2NzU2YWRhYTJkZWM1NzExNHw1Njk7NTY5OzEyODk5MDAzNzA7MjsxMjg3MzA4MzcwLjcyO19fQURNSU5fXzA7Kjs=",
			partner_id		: "569",
			subp_id			: "56900",
			user_id			: "__ADMIN__0",
			screen_name		: "",
			email			: "",
			first_login		: false,
			paying_partner	: "false",
			whitelabel		: 0,
			show_usage		: true,
			kse_uiconf		: "1002407", // add "id"
			kae_uiconf		: "1002408", // add "id"
			kcw_uiconf		: "1002404", // add "id"
			default_kdp		: {
					height		: "333",
					width		: "400",
					uiconf_id	: "1002401",
					swf_version	: "3.4.10.1"
			},
			versions			: {
					dashboard		:	"v1.0.14",
					content			:	"v3.2.11.1",
					appstudio		:	"v2.2.3",
					account			:	"v3.1.2.1", // "Settings" tab
					reports			:	"v1.1.8.2"
			},
			appstudio_uiconfid	: "1002336",
			reports_drilldown	: "1002418",
			enable_live			: "true",
			next_state			: { module : "dashboard", subtab : "default" },
			disableurlhashing	: "true",
			players_list		: [{"id":1002394,"name":"KDP3 Dark skin","width":"400","height":"333","swf_version":"v3.4.10.1"},{"id":1002395,"name":"KDP3 Light skin","width":"400","height":"333","swf_version":"v3.4.10.1"},{"id":1002419,"name":"Im a module","width":"400","height":"330","swf_version":"v3.4.10.1"},{"id":1002391,"name":"some player","width":"400","height":"330","swf_version":"v3.4.10.1"},{"id":1002373,"name":"my player with stars","width":"400","height":"330","swf_version":"v3.4.10.1"},{"id":1002342,"name":"Atar - Moderation","width":"400","height":"330","swf_version":"v3.4.10"},{"id":1002341,"name":"capturathumbnail test","width":"400","height":"330","swf_version":"v3.4.10"},{"id":1002337,"name":"v2.2.3 test","width":"400","height":"330","swf_version":"v3.4.10"},{"id":1002254,"name":"Neuer Player829","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002253,"name":"aa","width":"400","height":"330","swf_version":"v3.4.10"},{"id":1002248,"name":"wierd playroom vast thing","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002247,"name":"baha","width":"400","height":"330","swf_version":"v3.4.9"},{"id":1002245,"name":"Eitan\u00b4s player","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002243,"name":"stam","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002241,"name":"new player 3.4.9","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002238,"name":"bla bla","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002237,"name":"share by email","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002236,"name":"visibilator","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002235,"name":"advanced seek","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002234,"name":"stars","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002230,"name":"aaa","width":"400","height":"330","swf_version":"v3.4.8"},{"id":1002227,"name":"my hover player","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002226,"name":"my player","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002219,"name":"tada","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002215,"name":"Player N\u00b4ame","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002214,"name":"papapa","width":"356","height":"412","swf_version":"v3.4.3"},{"id":1002208,"name":"old adaptv test","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002207,"name":"old tremor test","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002206,"name":"example","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002205,"name":"aa","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002204,"name":"atar player","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002203,"name":"tt","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002202,"name":"fff","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002201,"name":"Shlomit template - do not touch","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002200,"name":"test VAST","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002199,"name":"fgdg","width":"400","height":"330","swf_version":"v3.4.2"},{"id":1002197,"name":"dfgdf","width":"400","height":"330","swf_version":"v3.4.2"},{"id":1002196,"name":"ddfg","width":"400","height":"330","swf_version":"v3.4.2"},{"id":1002194,"name":"b","width":"400","height":"330","swf_version":"v3.4.2"},{"id":1002193,"name":"a","width":"400","height":"330","swf_version":"v3.4.2"},{"id":1002192,"name":"bb","width":"400","height":"330","swf_version":"v3.4.2"},{"id":1002191,"name":"new hovering player","width":"363","height":"272","swf_version":"v3.4.2"},{"id":1002190,"name":"ho","width":"400","height":"330","swf_version":"v3.4.2"},{"id":1002188,"name":"vastSinglePlayer","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002186,"name":"custJs","width":"400","height":"330","swf_version":"v3.4.1"},{"id":1002185,"name":"popo","width":"400","height":"330","swf_version":"v3.4.1"},{"id":1002184,"name":"Eyewonder Test","width":"400","height":"330","swf_version":"v3.4.1"},{"id":1002182,"name":"new disappearing control bar cool player!","width":"400","height":"330","swf_version":"v3.4.0"},{"id":1002181,"name":"Eitan 3.3.9.2","width":"400","height":"330","swf_version":"v3.3.9.2"},{"id":1002174,"name":"bumper+vast","width":"400","height":"330","swf_version":"v3.4.0"},{"id":1002173,"name":"bumper player","width":"400","height":"330","swf_version":"v3.4.0"},{"id":1002172,"name":"bumper player","width":"400","height":"330","swf_version":"v3.4.0"},{"id":1002170,"name":"vast player","width":"400","height":"330","swf_version":"v3.4.0"},{"id":1002169,"name":"vast player","width":"400","height":"330","swf_version":"v3.4.0"},{"id":1002167,"name":"changed Name","width":"400","height":"330","swf_version":"v3.4.1"},{"id":1002166,"name":"fe","width":"400","height":"330","swf_version":"v3.4.0"},{"id":1002095,"name":"bn b","width":"400","height":"330","swf_version":"v3.3.4"},{"id":1002094,"name":"fgh","width":"400","height":"330","swf_version":"v3.3.4"},{"id":1002093,"name":"fgh","width":"400","height":"330","swf_version":"v3.3.4"},{"id":1002092,"name":"a","width":"400","height":"330","swf_version":"v3.3.4"},{"id":1002091,"name":"1002091","width":"400","height":"330","swf_version":"v3.3.4"},{"id":1002090,"name":"bxfg","width":"400","height":"330","swf_version":"v3.3.4"},{"id":1002048,"name":"adaptv","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002047,"name":"player+selector","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002046,"name":"adaptv2","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002044,"name":"player+adaptv","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002043,"name":"player with selector","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002041,"name":"player with flavors","width":"400","height":"330","swf_version":"v3.2.2"},{"id":1002039,"name":"adaptv test","width":"400","height":"330","swf_version":"v3.2.2"},{"id":1002036,"name":"adaptv test player","width":"400","height":"330","swf_version":"v3.2.2"},{"id":1002035,"name":"player","width":"400","height":"330","swf_version":"v3.2.2"},{"id":1002033,"name":"Boaz v3.2.2 with flavors","width":"400","height":"330","swf_version":"v3.2.2"},{"id":1002031,"name":"SmartClip - Eyewonder Test","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002049,"name":"SmartClip - Eyewonder Capped XML","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002050,"name":"SmartClip - Eyewonder Invalid XML","width":"400","height":"330","swf_version":"v3.3.2"},{"id":1002030,"name":"share at start and FS at pause","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002029,"name":"fullscreen at pasue screen ","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002027,"name":"with fullscreen","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002026,"name":"padding 20","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002019,"name":"Eitan test - do not touch","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002016,"name":"flavor player","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002015,"name":"Tremor-test","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002014,"name":"adaptv-test","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002008,"name":"player with edit","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002007,"name":"kaka","width":"400","height":"330","swf_version":"v3.4.3"},{"id":1002005,"name":"stretchy!","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002004,"name":"hila's player 3","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002003,"name":"hila's player 2","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002002,"name":"hila's player 2","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002001,"name":"hila's player","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1002000,"name":"lll","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001998,"name":"newPl","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001997,"name":"kkkk","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001996,"name":"tremorTest","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001995,"name":"adaptv3","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001994,"name":"adaptv2","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001993,"name":"Ariel","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001992,"name":"adapTv","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001991,"name":"hila","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001987,"name":"hilakaka","width":"400","height":"330","swf_version":"v3.2.0"},{"id":1001986,"name":"Fuck you ","width":"400","height":"330","swf_version":"v3.1.5"},{"id":800,"name":"JW Player, default skin","width":"400","height":"319","skin":"","share":false},{"id":801,"name":"JW Player, default skin - with Viral","width":"400","height":"319","skin":"","share":true},{"id":802,"name":"JW Player, Snel skin","width":"400","height":"332","skin":"snel","share":false},{"id":803,"name":"JW Player, Snel skin - with Viral","width":"400","height":"332","skin":"snel","share":true},{"id":804,"name":"JW Player, Stijl skin","width":"400","height":"346","skin":"stijl","share":false},{"id":805,"name":"JW Player, Stijl skin - with Viral","width":"400","height":"346","skin":"stijl","share":true}],
			playlists_list		: [{"id":1002396,"name":"KDP3 Playlist Light skin Vertical","width":"400","height":"680","swf_version":"v3.4.10.1"},{"id":1002397,"name":"KDP3 Playlist Light skin Horizontal","width":"680","height":"333","swf_version":"v3.4.10.1"},{"id":1002398,"name":"KDP3 Playlist Dark skin Vertical","width":"400","height":"680","swf_version":"v3.4.10.1"},{"id":1002399,"name":"KDP3 Playlist Dark skin Horizontal","width":"680","height":"333","swf_version":"v3.4.10.1"},{"id":1002340,"name":"another 2.2.3 test","width":"400","height":"620","swf_version":"v3.4.10"},{"id":1002339,"name":"test 2.2.3","width":"740","height":"330","swf_version":"v3.4.10"},{"id":1002300,"name":"ghj","width":"740","height":"330","swf_version":"v3.4.10"},{"id":1002299,"name":"vertical playlist","width":"400","height":"620","swf_version":"v3.4.10"},{"id":1002298,"name":"fgh","width":"740","height":"330","swf_version":"v3.4.10"},{"id":1002252,"name":"playlist autocontinue2","width":"740","height":"330","swf_version":"v3.4.10"},{"id":1002251,"name":"atar playlist autocontinue","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002246,"name":"hbox","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002242,"name":"playlist 3.4.9","width":"740","height":"330","swf_version":"v3.4.9"},{"id":1002229,"name":"dsdfrgh","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002225,"name":"my h playlist","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002224,"name":"multi ssssemek","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002223,"name":"sssemek","width":"400","height":"620","swf_version":"v3.4.3"},{"id":1002222,"name":"my playlist player","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002218,"name":"x","width":"400","height":"620","swf_version":"v3.4.3"},{"id":1002217,"name":"b","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002216,"name":"xcvx","width":"400","height":"620","swf_version":"v3.4.3"},{"id":1002211,"name":"ppop","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002198,"name":"kkk","width":"740","height":"330","swf_version":"v3.4.3"},{"id":1002187,"name":"playlist IR test","width":"740","height":"330","swf_version":"v3.4.1"},{"id":1002183,"name":"der","width":"750","height":"373","swf_version":"v2.5.3.31228"},{"id":1002180,"name":"vast+bumper","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002179,"name":"tremor+bumper","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002171,"name":"vast multiplaylist","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002168,"name":"intelliseek test player","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002165,"name":"vast playlist 6","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002164,"name":"vast playlist 5","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002163,"name":"vast playlist 4","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002162,"name":"dsf","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002161,"name":"vast playlist 3","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002159,"name":"vast playlist 2","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002158,"name":"vast playlist","width":"740","height":"330","swf_version":"v3.4.0"},{"id":1002154,"name":"vast player","width":"740","height":"330","swf_version":"v3.3.9"},{"id":1002153,"name":"kalturian plugin","width":"400","height":"620","swf_version":"v3.3.9"},{"id":1002152,"name":"bumperOnly player","width":"740","height":"330","swf_version":"v3.3.9"},{"id":1002045,"name":"adaptv+playlist","width":"740","height":"330","swf_version":"v3.3.2"},{"id":1002040,"name":"playlist adaptv","width":"740","height":"330","swf_version":"v3.2.2"},{"id":1002038,"name":"asda","width":"740","height":"330","swf_version":"v3.2.2"},{"id":1002037,"name":"adaptv+playlist","width":"740","height":"330","swf_version":"v3.2.2"},{"id":1002032,"name":"boaz 2","width":"740","height":"330","swf_version":"v3.2.2"},{"id":1002028,"name":"pl with FS ","width":"400","height":"620","swf_version":"v3.2.0"},{"id":1002025,"name":"no content","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002024,"name":"new one ","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002023,"name":"my mpl","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002022,"name":"dx","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002018,"name":"kkkkk","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002017,"name":"playlist","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002013,"name":"zona","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002012,"name":"asdasdasdasd","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002011,"name":"asdasdasdasd","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1002009,"name":"llll","width":"740","height":"330","swf_version":"v3.2.0"},{"id":1001999,"name":"my playlist ","width":"400","height":"620","swf_version":"v3.2.0"},{"id":1001990,"name":"streamPlaylist","width":"740","height":"330","swf_version":"v3.2.0"},{"id":806,"name":"JW Player vertical playlist, default skin","width":"400","height":"499","skin":"","share":false,"playlistType":"bottom"},{"id":807,"name":"JW Player vertical playlist, default skin - with Viral","width":"400","height":"499","skin":"","share":true,"playlistType":"bottom"},{"id":808,"name":"JW Player vertical playlist, Snel skin","width":"400","height":"512","skin":"snel","share":false,"playlistType":"bottom"},{"id":809,"name":"JW Player vertical playlist, Snel skin - with Viral","width":"400","height":"512","skin":"snel","share":true,"playlistType":"bottom"},{"id":810,"name":"JW Player vertical playlist, Stijl skin","width":"400","height":"526","skin":"stijl","share":false,"playlistType":"bottom"},{"id":811,"name":"JW Player vertical playlist, default skin - with Viral","width":"400","height":"526","skin":"stijl","share":true,"playlistType":"bottom"},{"id":812,"name":"JW Player horizontal playlist, default skin","width":"700","height":"319","skin":"","share":false,"playlistType":"right"},{"id":813,"name":"JW Player horizontal playlist, default skin - with Viral","width":"700","height":"319","skin":"","share":true,"playlistType":"right"},{"id":814,"name":"JW Player horizontal playlist, Snel skin","width":"700","height":"332","skin":"snel","share":false,"playlistType":"right"},{"id":815,"name":"JW Player horizontal playlist, Snel skin - with Viral","width":"700","height":"332","skin":"snel","share":true,"playlistType":"right"},{"id":816,"name":"JW Player horizontal playlist, Stijl skin","width":"700","height":"346","skin":"stijl","share":false,"playlistType":"right"},{"id":817,"name":"JW Player horizontal playlist, Stijl skin - with Viral","width":"700","height":"346","skin":"stijl","share":true,"playlistType":"right"}],
			enable_custom_data	: "true",
			metadata_view_uiconf	: "1002402",
			content_drilldown_uiconf : "1002403",
			content_moderate_uiconf	 : "1002400",
			google_analytics_account : "UA-15857288-1",
			appstudio_templatesXmlUrl: false,
			enableAds		 : true,
			appStudioExampleEntry : "_KMCLOGO1", 
			appStudioExamplePlayList0	 : "_KMCSPL1",
			appStudioExamplePlayList1	 : "_KMCSPL2"
		}
	}

	// kmc.vars.quickstart_guide = "/content/docs/pdf/KMC_Quick_Start_Guide__Butterfly.pdf#";
	kmc.vars.quickstart_guide = "/content/docs/pdf/KMC3_Quick_Start_Guide.pdf#"; // cassiopea

	kmc.functions = {
		expired : function() {
			// @todo: why no cookie killing ?
			window.location = kmc.vars.service_url + "/index.php/kmc/kmc" + location.hash; // @todo: shouldn't require '/index.php/kmc/'
		},
		doNothing : function() {
			return false;
		},
		closeEditor : function(is_modified) { // KSE
			if(is_modified) {
				var myConfirm = confirm("Exit without saving?\n\n - Click [OK] to close editor\n\n - Click [Cancel] to remain in editor\n\n");
				if(!myConfirm) {
					return;
				}
			}
			document.getElementById("flash_wrap").style.visibility = "visible";
			kalturaCloseModalBox();
		},
		saveEditor : function() { // KSE
			return;
		},
		openKcw : function(ks, conversion_profile) {
			conversion_profile = conversion_profile || "";

			// use wrap = 0 to indicate se should be open withou the html & form wrapper ????
			$("#flash_wrap").css("visibility","hidden");
			modal = kalturaInitModalBox ( null , { width: 700, height: 360 } );
			modal.innerHTML = '<div id="kcw"></div>';
			var flashvars = {
				host			: kmc.vars.host,
				cdnhost			: kmc.vars.cdn_host,
				userId			: kmc.vars.user_id,
				partnerid		: kmc.vars.partner_id,
				subPartnerId	: kmc.vars.subp_id,
				sessionId		: kmc.vars.ks,
				devFlag			: "true",
				entryId			: "-1",
				kshow_id		: "-1",
				terms_of_use	: kmc.vars.terms_of_use,
				close			: "kmc.functions.onCloseKcw",
				quick_edit		: 0, 		// "when opening from the KMC - don't add to the roughcut" ???
				kvar_conversionQuality : conversion_profile
			};

			var params = {
				allowscriptaccess: "always",
				allownetworking: "all",
				bgcolor: "#DBE3E9",
				quality: "high",
//				wmode: "opaque" ,
				movie: kmc.vars.service_url + "/kcw/ui_conf_id/" + kmc.vars.kcw_uiconf
			};

			swfobject.embedSWF(params.movie,			// old note: 36201 - new CW with ability to pass params not ready for this version
				"kcw", "680", "400" , "9.0.0", false, flashvars , params);

			setObjectToRemove("kaltura_cw"); // ???
		},
		onCloseKcw : function() {
			$("#flash_wrap").css("visibility","visible");
			kalturaCloseModalBox();
			modal = null;
			kmc.vars.kcw_open = false;
			// nullify flash object inside div kcw
		}
	}

	kmc.utils = {
		activateHeader : function(on) { // supports turning menu off if needed - just uncomment else clause
			if(on) {
//				$("a").unbind("click");
				$("a").click(function(e) {
					var go_to,
					tab = (e.target.tagName == "A") ? e.target.id : $(e.target).parent().attr("id");
//					alert("tab="+tab);
					switch(tab) {
						case "Dashboard" :
							go_to = { module : "dashboard", subtab : "" };
							break;
						case "Content" :
							go_to = { module : "content", subtab : "Manage" };
							break;
						case "Studio" :
//							go_to = { module : "appstudio", subtab : "players_list" };
//							break;
						case "Appstudio" :
							go_to = { module : "appstudio", subtab : "players_list" };
							break;
						case "Settings" :
							go_to = { module : "Settings", subtab : "Account_Settings" };
							break;
						case "Analytics" :
							go_to = { module : "reports", subtab : "Bandwidth Usage Reports" };
							break;
//						case "Advertising" :
//							go_to = "tremor";
//							break;
						case "Quickstart Guide" :
							this.href = kmc.vars.quickstart_guide;
							return true;
						case "Logout" :
							kmc.utils.logout();
							return false;
						case "Support" :
							kmc.utils.openSupport(this);
							return false;
						default :
							return false;
					}
//					console.log(go_to);
//					if(go_to == "tremor") {
//						$("#flash_wrap").html('<iframe src="http://publishers.adap.tv/osclient/" scrolling="no" frameborder="0" marginheight="0" marginwidth="0" width="100%" height="' + $("#main").height() + '"></iframe>');
//					}
//					else {
					kmc.mediator.setState(go_to);
					return false;
				});
			}
//			else {
//				$("a").unbind("click")
//					  .click(function(){
//						return false;
//					  });
//			}
		},
		openSupport : function(href) {
			kalturaCloseModalBox();
			var modal_width = $.browser.msie ? 543 : 519;
			var iframe_height = $.browser.msie ? 751 : ($.browser.safari ? 697 : 732);
			$("#flash_wrap").css("visibility","hidden");
			modal = kalturaInitModalBox ( null , { width : modal_width , height: 450 } );
			modal.innerHTML = '<div id="modal"><div id="titlebar"><a id="close" href="#close"></a>' +
							  '<b>Support Request</b></div> <div id="modal_content"><iframe id="support" src="' + href + '" scrolling="no" frameborder="0"' +
							  'marginheight="0" marginwidth="0" height="' + iframe_height + '" width="519"></iframe></div></div>';
			$("#mbContent").addClass("new");
			$("#close").click(function() {
				kmc.utils.closeModal();
				return false;
			});
			return false;
		},

		// merge multipile (unlimited) json object into one.  All arguments passed must be json object.
		// The first argument passed is the json object into which the others will be merged.
		mergeJson : function() {
			var i,
			args=arguments.length,
			primaryObject=arguments[0];
			for(var j=1; j<args ; j++) {
				var jsonObj=arguments[j];
				for(i in jsonObj) {
					primaryObject[i] = jsonObj[i];
				}
			}
			return primaryObject;
		},
		jsonToQuerystring : function(jsonObj,joiner) {
			var i,
			myString="";
			if(typeof joiner == "undefined")
				var joiner = "&";
			for(i in jsonObj) {
				myString += i + "=" + jsonObj[i] + joiner;
			}
			return myString;
		},
		logout : function() {
			var expiry = new Date("January 1, 1970"); // "Thu, 01-Jan-70 00:00:01 GMT";
			expiry = expiry.toGMTString();
			document.cookie = "pid=; expires=" + expiry + "; path=/";
			document.cookie = "subpid=; expires=" + expiry + "; path=/";
			document.cookie = "uid=; expires=" + expiry + "; path=/";
			document.cookie = "kmcks=; expires=" + expiry + "; path=/";
			document.cookie = "screen_name=; expires=" + expiry + "; path=/";
			document.cookie = "email=; expires=" + expiry + "; path=/";
			var state = kmc.mediator.readUrlHash();
			$.ajax({
                url: location.protocol + "//" + location.hostname + "/index.php/kmc/logout",
                type: "POST",
                data: { "ks": kmc.vars.ks },
                dataType: "json",
                complete: function() {
                        window.location = kmc.vars.service_url + "/index.php/kmc/kmc#" + state.module + "|" + state.subtab;
                }
			});
		},
		copyCode : function () {
			$("#copy_msg").show();
			setTimeout(function(){$("#copy_msg").hide(500);},1500)
			$(" textarea#embed_code").select();
		},
		resize : function() {
			var doc_height = $(document).height(),
			offset = $.browser.mozilla ? 37 : 74;
			doc_height = (doc_height-offset)+"px";
			$("#flash_wrap").height(doc_height);
			$("#server_wrap iframe").height(doc_height);
		},
		escapeQuotes : function(string) {
			string = string.replace(/"/g,"&Prime;");
			string = string.replace(/'/g,"&prime;");
			return string;
		},
		isModuleLoaded : function() {
			if($("#flash_wrap object").length || $("#flash_wrap embed").length) {
				kmc.utils.resize();
//				clearInterval(flashMovieTimeout);
				clearInterval(kmc.modules.isLoadedInterval);
				kmc.modules.isLoadedInterval = null;
			}
		},
		debug : function() {
			try{
				console.info(" ks: ",kmc.vars.ks);
				console.info(" partner_id: ",kmc.vars.partner_id);
			}
			catch(err) {}
		}()

		/*,
		cookies : {
			set		: function(){},
			get		: function(){},
			kill	: function(){}
		}*/
	}
//};
	kmc.utils.closeModal = function() {
			kalturaCloseModalBox();
			$("#flash_wrap").css("visibility","visible");
			return false;
	}

	kmc.mediator =  {
		/*
		  Need to implement saveAndClose call to module before switching tabs via html click:
			- inside swf's, show confirm: Save your changes before exiting ? [Yes] [No] [Cancel]
				- Yes = save and return true to html js function (to continue with tab change)
				- No = return true to html js function (without saving)
				- Cancel = return false to html js function, thereby canceling tab change
			- currently saveandclose calls onTabChange (no need)
		*/
		setState : function(go_to) { // go_to as json { module : module, subtab : subtab  }
//			alert("setState("+go_to.module+","+go_to.subtab+")");
			if(!go_to) {
				go_to = kmc.vars.next_state; // dbl... checked elsewhere
				kmc.vars.next_state = null; // ???
			}
			if(go_to.subtab == "uploadKMC") {
				kmc.vars.kcw_open = true;
				go_to.subtab = "Upload";
			}
			if(go_to.subtab.toLowerCase() == "publish")
				go_to.subtab = "Playlists";
			if(!kmc.vars.kcw_open) { // ???
				kalturaCloseModalBox();
			}
			kmc.mediator.setTab(go_to.module);
			kmc.mediator.writeUrlHash(go_to.module,go_to.subtab);
			kmc.mediator.loadModule(go_to.module,go_to.subtab);
		},
		
		
		/**
		 * tell KMC to change module
		 */
		loadModule : function(module,subtab) {
//			alert(module, subtab);
			module = module.toLowerCase();
//			if(module=="account")
//				module = "settings";
			subtab = subtab.replace(/ /g,"%20");
			
			document.getElementById("KMC").gotoPage(module, subtab);
			
			if(kmc.vars.kcw_open) {
				$("#flash_wrap").css("visibility","hidden");
				kmc.functions.openKcw();
				kmc.vars.kcw_open = false;
			}
		},
		
		
		/**
		 * write the correct string to the url hash
		 * (triggered from swf)
		 */
		writeUrlHash : function(module,subtab){
//			alert("writing url hash");
			if(module == "account")
				module = "Settings";
			location.hash = module + "|" + subtab;
			document.title = "KMC > " + module.charAt(0).toUpperCase() + module.slice(1) + ((subtab && subtab != "") ? " > " + subtab + " |" : "");
		},
		
		/**
		 * mark the correct tab as active
		 */
		setTab : function(module){
			alert("setting tab");
			if(module == "reports") {
				module = "Analytics";
			}
			else if(module == "account"){
				module = "Settings";
			}
			else {
				module = module.substring(0,1).toUpperCase() + module.substring(1); // capitalize 1st letter
			}
			$("#kmcHeader ul li a").removeClass("active");
			$("a#" + module).addClass("active");
		},
		readUrlHash : function() {
			var module = "dashboard", // @todo: change to kmc.vars.default_state.module ?
			subtab = "";
			try {
				var hash = location.hash.split("#")[1].split("|");
			}
			catch(err) {
				var nohash=true;
			}
			if(!nohash && hash[0]!="") {
				module = hash[0];
				subtab = hash[1];
			}
			return { "module" : module, "subtab" : subtab };
		},
		 selectContent : function(uiconf_id,is_playlist) { // called by selectPlaylistContent which is caled from appstudio
//			alert("selectContent("+uiconf_id+","+is_playlist+")");
			var subtab = is_playlist ? "Playlists" : "Manage";
//			kmc.vars.current_uiconf = uiconf_id; // used by doPreviewEmbed
			kmc.vars.current_uiconf = { "uiconf_id" : uiconf_id , "is_playlist" : is_playlist }; // used by doPreviewEmbed
			kmc.mediator.setState( { module : "content", subtab : subtab } );
		 }
	}

	kmc.modules = {
		shared : {
			attributes : {
				height				: "100%",
				width				: "100%"
			},
			params : {
				allowScriptAccess	: "always",
				allowNetworking		: "all",
				allowFullScreen		: "false",
				bgcolor				: "#F7F7F7",
				autoPlay			: "true"//,
//				wmode				: "opaque"
			},
			flashvars : {
				host				: kmc.vars.host,
				cdnhost				: kmc.vars.cdn_host,
				srvurl				: "api_v3/index.php",
				partnerid			: kmc.vars.partner_id,
				subpid				: kmc.vars.subp_id,
				uid					: kmc.vars.user_id,
				ks					: kmc.vars.ks,
				entryId				: "-1",
				kshowId				: "-1",
				widget_id			: "_" + kmc.vars.partner_id,
				enableCustomData	: kmc.vars.enable_custom_data,
				urchinNumber		: kmc.vars.google_analytics_account // "UA-12055206-1""
			}
		},
		dashboard : {
			swf_url : kmc.vars.flash_dir + "/kmc/dashboard/"   + kmc.vars.versions.dashboard + "/dashboard.swf",
			flashvars : {
				userName			: kmc.vars.screen_name,
				firstLogin			: kmc.vars.first_login,
				uploadDocLink		: kmc.vars.quickstart_guide + "page=3",
				embedDocLink		: kmc.vars.quickstart_guide + "page=5",
				customizeDocLink	: kmc.vars.quickstart_guide + "page=52" // bf=37
			}
		},
		content : {
			swf_url : kmc.vars.flash_dir + "/kmc/content/" + kmc.vars.versions.content + "/content.swf",
			flashvars : {
				moderationKDPVersion : "v3.3.4",
				drillDownKDPVersion  : "v3.3.4",
				moderationUiconf	: kmc.vars.content_moderate_uiconf,
				drilldownUiconf		: kmc.vars.content_drilldown_uiconf,
				refreshPlayerList	: "refreshPlayerList", // @todo: ???!!!
				refreshPlaylistList : "refreshPlaylistList", // @todo: ???!!!
				openPlayer			: "kmc.preview_embed.doPreviewEmbed", // @todo: remove for 2.0.9 ?
				openPlaylist		: "kmc.preview_embed.doPreviewEmbed",
				email				: kmc.vars.email,
				visibleCT			: kmc.vars.paying_partner,
				openCw				: "kmc.functions.openKcw",
				enableLiveStream	: kmc.vars.enable_live,
				sampleFileUrl		: "/content/docs/csv/kaltura_batch_upload_andromeda.csv",
				metadataViewUiconf	: kmc.vars.metadata_view_uiconf
			}
		},
		appstudio : {
			swf_url : kmc.vars.flash_dir + "/kmc/appstudio/" + kmc.vars.versions.appstudio + "/applicationstudio.swf",
			playlist_url :	'http%3A%2F%2F' + kmc.vars.host + '%2Findex.php%2Fpartnerservices2%2Fexecuteplaylist%3Fuid%3D%26partner_id%3D' +
							kmc.vars.partner_id + '%26subp_id%3D' +  kmc.vars.partner_id + '00%26format%3D8%26ks%3D%7Bks%7D%26playlist_id%3D',
			flashvars : {
				entryId					: kmc.vars.appStudioExampleEntry ,
				"playlistAPI.kpl0Name"	: "playlist1",
				"playlistAPI.kpl0Url"	: '',
				"playlistAPI.kpl1Name"	: "playlist2",
				"playlistAPI.kpl1Url"	: '',
				inapplicationstudio		: "true",
				Appstudiouiconfid		: kmc.vars.appstudio_uiconfid,
				//kdpUrl					: kmc.vars.flash_dir + "/kdp3/v3.3.4/kdp3.swf",
				servicesPath			: "index.php/partnerservices2/",
				serverPath				: "http://"+kmc.vars.host,
				partner_id				: kmc.vars.partner_id,
				subp_id					: kmc.vars.subp_id,
				templatesXmlUrl			: kmc.vars.appstudio_templatesXmlUrl || "",
				enableAds				: kmc.vars.enableAds,
				enableCustomData		: kmc.vars.enable_custom_data
//				widget_id				: "_" + kmc.vars.partner_id
			}
		},
		settings : { // formerly "account""
			swf_url : kmc.vars.flash_dir + "/kmc/account/"   + kmc.vars.versions.account + "/account.swf",
			flashvars: {
				email				: kmc.vars.email,
				showUsage			: kmc.vars.show_usage
			}
		},
		reports : {
			swf_url : kmc.vars.flash_dir + "/kmc/analytics/"   + kmc.vars.versions.reports + "/ReportsAndAnalytics.swf",
			flashvars : {
				drillDownKdpVersion	: "v3.3.4",
				drillDownKdpUiconf	: kmc.vars.reports_drilldown,
				serverPath			: kmc.vars.service_url
			}
		}
	}
	kmc.utils.mergeJson(kmc.modules.appstudio.flashvars,{ "playlistAPI.kpl0Url"	: kmc.modules.appstudio.playlist_url + kmc.vars.appStudioExamplePlayList0, "playlistAPI.kpl1Url" : kmc.modules.appstudio.playlist_url + kmc.vars.appStudioExamplePlayList1 });
//	kmc.modules.studio = kmc.modules.appstudio;

	kmc.preview_embed = {

		// called from p&e dropdown, from content.swf and from appstudio.swf
		doPreviewEmbed : function(id, name, description, is_playlist, uiconf_id, live_bitrates) {
		// entry/playlist id, description, true/ false (or nothing or "" or null), uiconf id, live_bitrates obj or boolean, is_mix
//			alert("doPreviewEmbed: id="+id+", name="+name+", description="+description+", is_playlist="+is_playlist+", uiconf_id="+uiconf_id);

			if(id != "multitab_playlist") {

				name = kmc.utils.escapeQuotes(name);
				description = kmc.utils.escapeQuotes(description); // @todo: move to "// JW" block

				if(kmc.vars.current_uiconf) { // set by kmc.mediator.selectContent called from appstudio's "select content" action
//					console.log(kmc.vars.current_uiconf); alert("kmc.vars.current_uiconf logged");
//					console.log("is_playlist=",is_playlist);
					if((is_playlist && kmc.vars.current_uiconf.is_playlist) || (!is_playlist && !kmc.vars.current_uiconf.is_playlist)) { // @todo: minor optimization possible
						var uiconf_id = kmc.vars.current_uiconf.uiconf_id;
//						alert("doPreviewEmbed says:\nkmc.vars.current_uiconf true -> uiconf_id = "+uiconf_id);
					}
					kmc.vars.current_uiconf = null;
				}

				if(!uiconf_id) { // get default uiconf_id (first one in list)
					var uiconf_id = is_playlist ? kmc.vars.playlists_list[0].id : kmc.vars.players_list[0].id;
	//				alert(uiconf_id);
				}

				if(uiconf_id > 899 && uiconf_id < 1000) {
					kmc.vars.silverlight = true;
				}
				// JW
				else if(uiconf_id > 799 && uiconf_id < 900) {
					kmc.vars.jw = true,
					jw_license_html = '<strong>COMMERCIAL</strong>',
					jw_options_html = '',
					jw_nomix_box_html = kmc.preview_embed.jw.showNoMix(false,"check");

					if(kmc.vars.jw_swf == "non-commercial.swf") {
						jw_license_html =   '<a href="http://creativecommons.org/licenses/by-nc-sa/3.0/" target="_blank" class="license tooltip"' +
											'title="With this license your player will show a JW Player watermark.  You may NOT use the non-commercial' +
											'JW Player on commercial sites such as: sites owned or operated by corporations, sites with advertisements,' +
											'sites designed to promote a product, service or brand, etc.  If you are not sure whether you need to '+
											'purchase a license, contact us.  You also may not use the AdSolution monetization plugin ' +
											'(which lets you make money off your player).">NON-COMMERCIAL <img src="http://corp.kaltura.com/images/graphics/info.png" alt="show tooltip" />' +
											'</a>&nbsp;&bull;&nbsp;<a href="http://corp.kaltura.com/about/contact?subject=JW%20Player%20to%20commercial%20license&amp;' +
											'&amp;pid=' + kmc.vars.partner_id + '&amp;name=' + kmc.vars.screen_name + '&amp;email=' + kmc.vars.email  + '" target="_blank" class="license tooltip" ' +
											'title="Go to the Contact Us page and call us or fill in our Contact form and we\'ll call you (opens in new window/ tab).">Upgrade ' +
											'<img src="http://corp.kaltura.com/images/graphics/info.png" alt="show tooltip" /></a>';
						var jw_license_ads_html = '<li>Requires <a href="http://corp.kaltura.com/about/contact?subject=JW%20Player%20to%20commercial%20license&amp;" ' +
											  'class="tooltip" title="With a Commercial license your player will not show the JW Player watermark and you will be ' +
											  'allowed to use the player on any site you want as well as use AdSolution (which lets you make money off your player)."' +
											  'target="_blank">Commercial license <img src="http://corp.kaltura.com/images/graphics/info.png" alt="show tooltip" /></a></li>';
					}
					jw_options_html =	'<div class="label">License Type:</div>\n<div class="description">' + jw_license_html + '</div>\n' +
										'<div class="label">AdSolution:</div><div class="description"> <input type="checkbox" id="AdSolution" ' +
										'onclick="kmc.preview_embed.jw.adSolution()" onmousedown="kmc.vars.jw_chkbox_flag=true" /> Enable ads ' +
										'in your videos.&nbsp; <a href="http://www.longtailvideo.com/referral.aspx?page=kaltura&ref=azbkefsfkqchorl" ' +
										'target="_blank" class="tooltip" title="Go to the JW website to sign up for FREE or to learn more about ' +
										'running in-stream ads in your player from Google AdSense for Video, ScanScout, YuMe and others. (opens ' +
										'in new window/ tab)"> Free sign up... <img src="http://corp.kaltura.com/images/graphics/info.png" alt="' +
										'show tooltip" /></a><br />\n <ul id="ads_notes">\n  <li>Channel Code: <input onblur="' +
										'kmc.preview_embed.jw.adsChannel(this, \'' + id + '\', \'' + name + '\', \'' + description + '\', ' + (is_playlist || false) + ', \'' + uiconf_id + '\');" ' +
										'type="text" id="adSolution_channel" value="" /> <button>Apply</button></li>\n' + (jw_license_ads_html || '') +
										'\n </ul>\n </div>\n';
				} // END JW
			} // end !multitab_playlist

			var embed_code, preview_player,
			id_type = is_playlist ? "Playlist " + (id == "multitab_playlist" ? "Name" : "ID") : "Entry ID",
			uiconf_details = kmc.preview_embed.getUiconfDetails(uiconf_id,is_playlist);
//			console.log("uiconf_details="+uiconf_details);
			if(kmc.vars.jw) {
				embed_code = kmc.preview_embed.jw.buildJWEmbed(id, name, description, is_playlist, uiconf_id);
				preview_player = embed_code.replace('flvclipper', 'flvclipper/ks/' + kmc.vars.ks);
			}
			else if(kmc.vars.silverlight) {
				embed_code = kmc.preview_embed.buildSilverlightEmbed(id, name, is_playlist, uiconf_id);
				preview_player = embed_code.replace('{KS}','ks=' + kmc.vars.ks);
				embed_code = embed_code.replace('{KS}','');
				embed_code = embed_code.replace("{ALT}", ((kmc.vars.whitelabel) ? "" : "<br/>" + kmc.preview_embed.embed_code_template.kaltura_links));
			}
			else {
				embed_code = kmc.preview_embed.buildKalturaEmbed(id, name, description, is_playlist, uiconf_id);
				preview_player = embed_code.replace('{FLAVOR}','ks=' + kmc.vars.ks + '&');
				embed_code = embed_code.replace('{FLAVOR}','');
			}
			var modal_html = '<div id="modal"><div id="titlebar"><a id="close" href="#close"></a>' +
							 '<a id="help" target="_blank" href="' + kmc.vars.service_url + '/index.php/kmc/help#contentSection118"></a>' + id_type +
							 ': ' + id + '</div> <div id="modal_content">' +
							 ((typeof live_bitrates == "object") ? kmc.preview_embed.buildLiveBitrates(name,live_bitrates) : '') +
//							 ((id == "multitab_playlist") ? '' : kmc.preview_embed.buildSelect(id, name, description, is_playlist, uiconf_id)) +
							 ((id == "multitab_playlist") ? '' : kmc.preview_embed.buildSelect(is_playlist, uiconf_id)) +
							 (kmc.vars.jw ? jw_nomix_box_html : '') +
							 '<div id="player_wrap">' + preview_player + '</div>' +
							 (kmc.vars.jw ? jw_options_html : '') +
							 ((kmc.vars.silverlight || live_bitrates) ? '' : kmc.preview_embed.buildRtmpOptions()) +
							 '<div class="label">Embed Code:</div> <textarea id="embed_code" rows="5" cols=""' +
							 'readonly="true" style="width:' + (parseInt(uiconf_details.width)-10) + 'px;">' + embed_code + '</textarea>' +
							 '<div id="copy_msg">Press Ctrl+C to copy embed code (Command+C on Mac)</div><button id="select_code">' +
							 '<span>Select Code</span></button></div></div>';
//			alert(modal_html);
			kmc.vars.jw = false;
			kmc.vars.silverlight = false;

			kalturaCloseModalBox();
			$("#flash_wrap").css("visibility","hidden");
			modal = kalturaInitModalBox ( null , { width : parseInt(uiconf_details.width) + 20 , height: parseInt(uiconf_details.height) + 200 } );
			modal.innerHTML = modal_html;
			$("#mbContent").addClass("new");
			// attach events here instead of writing them inline
			$("#embed_code, #select_code").click(function(){
				kmc.utils.copyCode();
			});
			$("#close").click(function(){
				 kmc.utils.closeModal();
				 return false;
			});
			$("#delivery_type").change(function(){
				kmc.vars.embed_code_delivery_type = this.value;
				kmc.preview_embed.doPreviewEmbed(id, name, description, is_playlist, uiconf_id);
			});
			$("#player_select").change(function(){
				kmc.preview_embed.doPreviewEmbed(id, name, description, is_playlist, this.value, live_bitrates);
			});
		}, // doPreviewEmbed

		buildLiveBitrates : function(name,live_bitrates) {
			var bitrates = "",
			len = live_bitrates.length,
			i;
			for(i=0;i<len;i++) {
				bitrates += live_bitrates[i].bitrate + " kbps, " + live_bitrates[i].width + " x " + live_bitrates[i].height + "<br />";
			}
			var lbr_data = 	'<dl style="margin: 0 0 15px">' + '<dt>Name:</dt><dd>' + name + '</dd>' +
							'<dt>Bitrates:</dt><dd>' + bitrates + '</dd></dl>';
			return lbr_data;
		},

		buildSilverlightEmbed : function(id, name, is_playlist, uiconf_id) {
			var uiconf_details = kmc.preview_embed.getUiconfDetails(uiconf_id,is_playlist),
			cache_st = kmc.preview_embed.setCacheStartTime(),
			embed_code = kmc.preview_embed.embed_code_template.silverlight;
			embed_code = embed_code.replace("{WIDTH}",uiconf_details.width);
			embed_code = embed_code.replace("{HEIGHT}",uiconf_details.height);
			embed_code = embed_code.replace("{HOST}",kmc.vars.host);
			embed_code = embed_code.replace("{CACHE_ST}",cache_st);
			embed_code = embed_code.replace("{VER}",uiconf_details.swfUrlVersion); // sl
			embed_code = embed_code.replace("{PARTNER_ID}",kmc.vars.partner_id);
//			embed_code = embed_code.replace("{CDN_HOST}",kmc.vars.cdn_host); // sl
			embed_code = embed_code.replace("{UICONF_ID}",uiconf_id);
			embed_code = embed_code.replace(/{SILVERLIGHT}/gi,uiconf_details.minRuntimeVersion);
			embed_code = embed_code.replace("{INIT_PARAMS}",(is_playlist ? "playlist_id" : "entry_id"));
			embed_code = embed_code.replace("{ENTRY_ID}", id);
			return embed_code;
		},
		buildRtmpOptions : function() {
			var selected = ' selected="selected"';
			var delivery_type = kmc.vars.embed_code_delivery_type || "http";
			var html = '<div id="rtmp" class="label">Delivery Type:</div> <select id="delivery_type">';
			var options = '<option value="http"' + ((delivery_type == "http") ? selected : "") + '>Progressive Download (HTTP)&nbsp;</option>' +
						  '<option value="rtmp"' + ((delivery_type == "rtmp") ? selected : "") + '>Adaptive Streaming (RTMP)&nbsp;</option>';
			html += options + '</select>';
			return html;
		},

		// for content|Manage->drilldown->flavors->preview
		// flavor_details = json:
		doFlavorPreview : function(entry_id, entry_name, flavor_details) {
//			console.log(flavor_details);
//			alert("doFlavorPreview(entry_id="+entry_id+", entry_name="+entry_name+", flavor_details logged)");
			entry_name = kmc.utils.escapeQuotes(entry_name);
//			var flavor_asset_name = kmc.utils.escapeQuotes(flavor_details.flavor_name) || "unknown";
			kalturaCloseModalBox();
			$("#flash_wrap").css("visibility","hidden");
			modal = kalturaInitModalBox ( null , { width : parseInt(kmc.vars.default_kdp.width) + 20 , height: parseInt(kmc.vars.default_kdp.height) + 10 } );
			$("#mbContent").addClass("new");
			var player_code = kmc.preview_embed.buildKalturaEmbed(entry_id,entry_name,null,false,kmc.vars.default_kdp);
//			alert("flavor_details.asset_id="+flavor_details.asset_id);
			player_code = player_code.replace('&{FLAVOR}', '&flavorId=' + flavor_details.asset_id + '&ks=' + kmc.vars.ks);
			var modal_html = '<div id="modal"><div id="titlebar"><a id="close" href="#close"></a>' +
							 'Flavor Preview</div>' +
							 '<div id="modal_content">' + player_code + '<dl>' +
							 '<dt>Entry Name:</dt><dd>&nbsp;' + entry_name + '</dd>' +
							 '<dt>Entry Id:</dt><dd>&nbsp;' + entry_id + '</dd>' +
							 '<dt>Flavor Name:</dt><dd>&nbsp;' + flavor_details.flavor_name + '</dd>' +
							 '<dt>Flavor Asset Id:</dt><dd>&nbsp;' + flavor_details.asset_id + '</dd>' +
							 '<dt>Bitrate:</dt><dd>&nbsp;' + flavor_details.bitrate + '</dd>' +
							 '<dt>Codec:</dt><dd>&nbsp;' + flavor_details.codec + '</dd>' +
							 '<dt>Dimensions:</dt><dd>&nbsp;' + flavor_details.dimensions.width + ' x ' + flavor_details.dimensions.height + '</dd>' +
							 '<dt>Format:</dt><dd>&nbsp;' + flavor_details.format + '</dd>' +
							 '<dt>Size (KB):</dt><dd>&nbsp;' + flavor_details.sizeKB + '</dd>' +
							 '<dt>Status:</dt><dd>&nbsp;' + flavor_details.status + '</dd>' +
							 '</dl></div></div>';
			modal.innerHTML = modal_html;
			$("#close").click(function(){
				 kmc.utils.closeModal();
				 return false;
			});
		},

		// eventually replace with <? php echo $embedCodeTemplate; ?>  ;  (variables used: HEIGHT WIDTH HOST CACHE_ST UICONF_ID PARTNER_ID PLAYLIST_ID ENTRY_ID) + {VER}, {SILVERLIGHT}, {INIT_PARAMS} for Silverlight + NAME, DESCRIPTION
		embed_code_template :	{
			object_tag :	'<object id="kaltura_player" name="kaltura_player" type="application/x-shockwave-flash" allowFullScreen="true" ' +
							'allowNetworking="all" allowScriptAccess="always" height="{HEIGHT}" width="{WIDTH}" ' +
							'xmlns:dc="http://purl.org/dc/terms/" xmlns:media="http://search.yahoo.com/searchmonkey/media/" rel="media:{MEDIA}" ' +
							'resource="http://{HOST}/index.php/kwidget/cache_st/{CACHE_ST}/wid/_{PARTNER_ID}/uiconf_id/{UICONF_ID}{ENTRY_ID}" ' +
							'data="http://{HOST}/index.php/kwidget/cache_st/{CACHE_ST}/wid/_{PARTNER_ID}/uiconf_id/{UICONF_ID}{ENTRY_ID}">' +
							'<param name="allowFullScreen" value="true" /><param name="allowNetworking" value="all" />' +
							'<param name="allowScriptAccess" value="always" /><param name="bgcolor" value="#000000" />' +
							'<param name="flashVars" value="{FLASHVARS}&{FLAVOR}" /><param name="movie" value="http://{HOST}/index.php/kwidget' +
							'/cache_st/{CACHE_ST}/wid/_{PARTNER_ID}/uiconf_id/{UICONF_ID}{ENTRY_ID}" />{ALT} {SEO} ' + '</object>',
			playlist_flashvars :	'playlistAPI.autoInsert=true&playlistAPI.kpl0Name={PL_NAME}' +
									'&playlistAPI.kpl0Url=http%3A%2F%2F{HOST}%2Findex.php%2Fpartnerservices2%2Fexecuteplaylist%3Fuid%3D%26' +
									'partner_id%3D{PARTNER_ID}%26subp_id%3D{PARTNER_ID}00%26format%3D8%26ks%3D%7Bks%7D%26playlist_id%3D{PLAYLIST_ID}',
			kaltura_links :		'<a href="http://corp.kaltura.com">video platform</a> <a href="http://corp.kaltura.com/video_platform/video_management">' +
								'video management</a> <a href="http://corp.kaltura.com/solutions/video_solution">video solutions</a> ' +
								'<a href="http://corp.kaltura.com/video_platform/video_publishing">video player</a>',
			media_seo_info :	'<a rel="media:thumbnail" href="http://{CDN_HOST}/p/{PARTNER_ID}/sp/{PARTNER_ID}00/thumbnail{ENTRY_ID}/width/120/height/90/bgcolor/000000/type/2" /> ' +
								'<span property="dc:description" content="{DESCRIPTION}" /><span property="media:title" content="{NAME}" /> ' +
								'<span property="media:width" content="{WIDTH}" /><span property="media:height" content="{HEIGHT}" /> ' +
								'<span property="media:type" content="application/x-shockwave-flash" />',
							// removed <span property="media:duration" content="{DURATION}" />
			// (variables used: {WIDTH} {HEIGHT} {HOST} {CDN_HOST} {UICONF_ID} {VER} {ENTRY_ID} {SILVERLIGHT} + Missing id and name
			silverlight :	'<object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="{WIDTH}" height="{HEIGHT}"> <param name="source" ' +
							'value="http://{HOST}/index.php/kwidget/cache_st/{CACHE_ST}/wid/_{PARTNER_ID}/uiconf_id/{UICONF_ID}/nowrapper/1/a/a.xap" />' +
//							'value="http://{HOST}/flash/slp/v{VER}/KalturaPlayer.xap?widget_id=_{PARTNER_ID}&host={HOST}&cdnHost={CDN_HOST}&uiconf_id={UICONF_ID}" />' +
							' <param name="enableHtmlAccess" value="true" /> <param name="background" value="black" /> <param name="minRuntimeVersion" ' +
							'value="{SILVERLIGHT}" /> <param name="autoUpgrade" value="true" /> <param name="InitParams" value="{INIT_PARAMS}={ENTRY_ID}&{KS}" />' +
							' <a href="http://go.microsoft.com/fwlink/?LinkId=149156&v={SILVERLIGHT}"><img src="http://go.microsoft.com/fwlink/?LinkId=161376" ' +
							'alt="Get Microsoft Silverlight" /></a>{ALT}</object>'
		},

		// id = entry id, asset id or playlist id; name = entry name or playlist name;
		// uiconf = uiconfid (normal scenario) or uiconf details json (for #content|Manage->drill down->flavors->preview)
		buildKalturaEmbed : function(id, name, description, is_playlist, uiconf) {
//		alert("buildKalturaEmbed(id="+id+", name="+name+", is_playlist="+is_playlist+", uiconf = " + uiconf);
			var uiconf_id = uiconf.uiconf_id || uiconf,
			uiconf_details = (typeof uiconf == "object") ? uiconf : kmc.preview_embed.getUiconfDetails(uiconf_id,is_playlist),  // getUiconfDetails returns json
			cache_st = kmc.preview_embed.setCacheStartTime(),
			embed_code;
//			console.log(uiconf_details); alert("uiconf_details logged");
//			alert("cache_st = " + cache_st);
			embed_code = kmc.preview_embed.embed_code_template.object_tag;
			if(!kmc.vars.jw) { // more efficient to add "&& !kmc.vars.silverlight" (?)
				kmc.vars.embed_code_delivery_type = kmc.vars.embed_code_delivery_type || "http";
				if(kmc.vars.embed_code_delivery_type == "rtmp") {
					embed_code = embed_code.replace("{FLASHVARS}", "streamerType=rtmp&amp;streamerUrl=" + kmc.vars.rtmp_host + "&amp;rtmpFlavors=1&{FLASHVARS}"); // rtmp://rtmpakmi.kaltura.com/ondemand
				}
			}
			if(is_playlist && id != "multitab_playlist") {	// playlist (not multitab)
				embed_code = embed_code.replace(/{ENTRY_ID}/g,"");
				embed_code = embed_code.replace("{FLASHVARS}",kmc.preview_embed.embed_code_template.playlist_flashvars);
//				console.log(uiconf_details.swf_version); alert("uiconf_details.swf_version logged");
				if(uiconf_details.swf_version.indexOf("v3") == -1) { // not kdp3
					embed_code = embed_code.replace("playlistAPI.autoContinue","k_pl_autoContinue");
					embed_code = embed_code.replace("playlistAPI.autoInsert","k_pl_autoInsertMedia");
					embed_code = embed_code.replace("playlistAPI.kpl0Name","k_pl_0_name");
					embed_code = embed_code.replace("playlistAPI.kpl0Url","k_pl_0_url");
				}
			}
			else {											// player and multitab playlist
				embed_code = embed_code.replace("{SEO}", (is_playlist ? "" : kmc.preview_embed.embed_code_template.media_seo_info));
				embed_code = embed_code.replace(/{ENTRY_ID}/g, (is_playlist ? "" : "/entry_id/" + id));
				embed_code = embed_code.replace("{FLASHVARS}", "");
			}
			
			embed_code = embed_code.replace("{MEDIA}", "video");	// to be replaced by real media type once doPreviewEmbed (called from within KMC>Content) starts passing full entry object			embed_code = embed_code.replace(/{ENTRY_ID}/gi, (is_playlist ? "-1" : id));
			embed_code = embed_code.replace(/{HEIGHT}/gi,uiconf_details.height);
			embed_code = embed_code.replace(/{WIDTH}/gi,uiconf_details.width);
			embed_code = embed_code.replace(/{HOST}/gi,kmc.vars.host);
			embed_code = embed_code.replace(/{CACHE_ST}/gi,cache_st);
			embed_code = embed_code.replace(/{UICONF_ID}/gi,uiconf_id);
			embed_code = embed_code.replace(/{PARTNER_ID}/gi,kmc.vars.partner_id);
			embed_code = embed_code.replace("{PLAYLIST_ID}",id);
			embed_code = embed_code.replace("{PL_NAME}",name);
   			embed_code = embed_code.replace(/{SERVICE_URL}/gi,kmc.vars.service_url);
			embed_code = embed_code.replace("{ALT}", ((kmc.vars.whitelabel) ? "" : kmc.preview_embed.embed_code_template.kaltura_links));
			embed_code = embed_code.replace("{CDN_HOST}",kmc.vars.cdn_host);
			embed_code = embed_code.replace("{NAME}", name);
			embed_code = embed_code.replace("{DESCRIPTION}", description);
//			embed_code = embed_code.replace("{DURATION}", entry.duration || '');
//			alert("embed_code: "+embed_code);
			return embed_code;
		},
//		buildSelect : function(id, name, description, is_playlist, uiconf_id) { // called from modal_html;
		buildSelect : function(is_playlist, uiconf_id) { // called from modal_html;
			// used = uiconf_id; is_playlist;
//			alert("buildSelect("+id+", "+name+", "+description+", "+is_playlist+", "+uiconf_id+")");
			uiconf_id = kmc.vars.current_uiconf || uiconf_id;  // @todo: need to nullify kmc.vars.current_uiconf somewhere... on very next line ?
			var list_type = is_playlist ? "playlist" : "player",
			list_length = eval("kmc.vars." + list_type + "s_list.length"),
			html_select = '',
			this_uiconf, selected;
//			alert("uiconf_id="+uiconf_id+" | list_type="+list_type+" | html_select ="+html_select+" | list_length ="+list_length);
			for(var i=0; i<list_length; i++) {
				this_uiconf = eval("kmc.vars." + list_type + "s_list[" + i + "]"),
				selected = (this_uiconf.id == uiconf_id) ? ' selected="selected"' : '';
				html_select += '<option ' + selected + ' value="' + this_uiconf.id + '">' + this_uiconf.name + '</option>';
			}
//			html_select = '<select onchange="kmc.preview_embed.doPreviewEmbed(\'' + id + '\',\'' + name + '\',\'' + description + '\',' + is_playlist + ', this.value)">'
			html_select = '<select id="player_select">' + html_select + '</select>';
			kmc.vars.current_uiconf = null;
			return html_select;
		},

//		reload : function(id, name, description, is_playlist, uiconf_id) {
//			var embed_code = kmc.preview_embed.buildEmbed(id, name, description, is_playlist, uiconf_id);
//			$("#player_wrap").html(embed_code);
//			$("#embed_code textarea").val(embed_code);
//			kmc.preview_embed.doPreviewEmbed(id, name, description, is_playlist, uiconf_id);
//		},

		getUiconfDetails : function(uiconf_id,is_playlist) {
//			alert("getUiconfDetails("+"uiconf_id="+uiconf_id+", +is_playlist="+is_playlist+")");
			var i,
			uiconfs_array = is_playlist ? kmc.vars.playlists_list : kmc.vars.players_list;
			for(i in uiconfs_array) {
				if(uiconfs_array[i].id == uiconf_id) {
					return uiconfs_array[i];
					break;
				}
			}
			alert("getUiconfDetails error: uiconf_id "+uiconf_id+" not found in " + ((is_playlist) ? "kmc.vars.playlists_list" : "kmc.vars.players_list"));
			return false;
		},
		setCacheStartTime : function() {
            var d = new Date;
            cache_st = Math.floor(d.getTime() / 1000) + (15 * 60); // start caching in 15 minutes
            return cache_st;
		},
		updateList : function(is_playlist) {
//			alert("updateList(" + is_playlist + ")");
			var type = is_playlist ? "playlist" : "player";
//			alert("type = " + type);
			$.ajax({
				url: kmc.vars.getuiconfs_url,
				type: "POST",
				data: { "type": type, "partner_id": kmc.vars.partner_id, "ks": kmc.vars.ks },
				dataType: "json",
				success: function(data) {
//					alert(data);
					if (data && data.length) {
//						alert("success: data && data.length");
						if(is_playlist) {
//							alert("success: kmc.vars.playlists_list = data");
							kmc.vars.playlists_list = data;
						}
						else {
//							alert("success: kmc.vars.players_list = data");
							kmc.vars.players_list = data;
						}
					}
				}
			});
		},
		// JW
		jw : {
			// @todo: chg function name to ?
			adSolution		: function() {	// checkbox onclick; @todo: change id's ?
				if ($("#AdSolution").attr("checked")) {
					$("#ads_notes").show();
					$("#adSolution_channel").focus();
				}
				else {
					$("div.description ul").hide();
					$("#adSolution_channel").val("");
				}
				kmc.vars.jw_chkbox_flag=false;
			},
			adsChannel		: function(this_input, id, name, description, is_playlist, uiconf_id) {
				if(this_input.value=="" || this_input.value=="_") {
					if (!kmc.vars.jw_chkbox_flag) {
						$("#AdSolution").attr("checked",false);
					}
					$("div.description ul").hide();
				}
				var embed_code = kmc.preview_embed.jw.buildJWEmbed(id, name, description, is_playlist, uiconf_id);
				$("#player_wrap").html(embed_code);
				$("#embed_code textarea").val(embed_code);
				// @todo: improve ux by only reloading if actual change took place
			},
			adsolutionSetup	: function(start) { // @todo: explain
				var $adSolution_channel = $("#adSolution_channel");
				if(start)
					if($adSolution_channel.val()=="")
						$adSolution_channel.val("_");
				else
					if($adSolution_channel.val()=="_")
						$adSolution_channel.val("");
			},
			showNoMix : function(checkbox,action) {
				if(checkbox) {
					if($(checkbox).is(':checked'))
						action = "set";
					else
						action = "delete"
				}
				switch(action) {
					case "set" :
						document.cookie = "kmc_preview_show_nomix_box=true; ; path=/";
						$("#nomix_box").hide(250);
						break;
					case "delete" :
						document.cookie = "kmc_preview_show_nomix_box=true; expires=Sun, 01 Jan 2000 00:00:01 GMT; path=/";
						break;
					case "check" :
						if (document.cookie.indexOf("kmc_preview_show_nomix_box") == -1)
							var html =	'<div id="nomix_box"><p><strong>NOTE</strong>: ' +
										'The JW Player does not work with Kaltura <dfn title="A Video Mix is a video made up of two or more ' +
										'Entries, normally created through the Kaltura Editor.">Video Mixes</dfn>.</p>\n<div><input type="' +
										'checkbox" onclick="kmc.preview_embed.jw.showNoMix(this)"> Don\'t show this message again.</div></div>\n';
						else
							var html =	'';
						break;
					default :
						alert("error: no action");
						return;
				}
				return html;
			},

			buildJWEmbed : function (entry_id, name, description, is_playlist, uiconf_id) {
				var uiconf_details = kmc.preview_embed.getUiconfDetails(uiconf_id,is_playlist); // @ todo: change to embed_code.
				 var width			= uiconf_details.width;
				 var height			= uiconf_details.height;
				 var playlist_type	= uiconf_details.playlistType;
				 var share			= uiconf_details.share;
				 var skin			= uiconf_details.skin;
				var jw_flashvars = '';
				var unique_id = new Date(); unique_id = unique_id.getTime();
				var jw_plugins =  new Array();

				if(!is_playlist || is_playlist == "undefined") {
					jw_flashvars += 'file=http://' + kmc.vars.cdn_host + '/p/' + kmc.vars.partner_id + '/sp/' + kmc.vars.partner_id +
									'00/flvclipper/entry_id/' + entry_id + '/version/100000/ext/flv';
					jw_plugins.push("kalturastats");
				}
				else {
					jw_flashvars += 'file=http://' + kmc.vars.cdn_host + '/index.php/partnerservices2/executeplaylist%3Fuid%3D%26format%3D8%26playlist_id%3D' +
									entry_id + '%26partner_id%3D' + kmc.vars.partner_id + '%26subp_id%3D' + kmc.vars.partner_id + '00%26ks%3D%7Bks%7D' +
									'&playlist=' + playlist_type;
					if(playlist_type != "bottom") {
						jw_flashvars += '&playlistsize=300';
					}
				}

				if(share == "true" || share == true) {
					jw_flashvars += '&viral.functions=embed,link&viral.onpause=false';
					jw_plugins.push("viral-2");
				}

			/* for AdSolution */
				var jw_ads = { channel : $("#adSolution_channel").val() };
				if ($("#AdSolution").is(":checked") && jw_ads.channel != "") {
					jw_ads.flashvars =	'&ltas.cc=' + jw_ads.channel + 	// &ltas.xmlprefix=http://zo.longtailvideo.com.s3.amazonaws.com/ //uacbirxmcnulxmf
										'&mediaid=' + entry_id;
					jw_plugins.push("ltas");
					jw_ads.flashvars += "&title=" + name + "&description=" + description;
					jw_flashvars += jw_ads.flashvars;
				}
			/* end AdSolution */

				var jw_skin = (skin == "undefined" || skin == "") ? '' : '&skin=http://' + kmc.vars.cdn_host + '/flash/jw/skins/' + skin;

				jw_flashvars =  jw_flashvars +
								'&amp;image=http://' + kmc.vars.cdn_host + '/p/' + kmc.vars.partner_id + '/sp/' + kmc.vars.partner_id +
								'00/thumbnail/entry_id/' + entry_id + '/width/640/height/480' + jw_skin + '&widgetId=jw00000001&entryId=' +
								entry_id + '&partnerId=' + kmc.vars.partner_id + '&uiconfId=' + uiconf_id + '&plugins=' + jw_plugins;

				var jw_embed_code = '<div id="jw_wrap_' + unique_id + '"> <object width="' + width + '" height="' + height + '" id="jw_player_' +
									unique_id + '" name="jw_player_' + unique_id + '">' +
									' <param name="movie" value="http://' + kmc.vars.cdn_host + '/flash/jw/player/' + kmc.vars.jw_swf + '" />' +
//									' <param name="wmode" value="transparent" />' +
									' <param name="allowScriptAccess" value="always" />' +
									' <param name="flashvars" value="' + jw_flashvars + '" />' +
									' <embed id="jw_player__' + unique_id + '" name="jw_player__' + unique_id + '" src="http://' +
									kmc.vars.cdn_host + '/flash/jw/player/' + kmc.vars.jw_swf + '" width="' + width + '" height="' + height +
									'" allowfullscreen="true" ' +
									'wmode="transparent" ' +
									'allowscriptaccess="always" ' + 'flashvars="' + jw_flashvars +
									'" /> <noembed><a href="http://www.kaltura.org/">Open Source Video</a></noembed> </object> </div>';
				return jw_embed_code;
			} /* end build jw embed code */
		} // END JW
	}

	kmc.editors = {
		start: function(entry_id, entry_name, editor_type, new_mix) {
//			alert("kmc.editors.start("+entry_id+","+entry_name+","+editor_type+","+new_mix+")");
			if(new_mix) {
//				alert("call create mix ajax");
//				$("body").css("cursor","wait");
				jQuery.ajax({
					url: kmc.vars.createmix_url,
					type: "POST",
					data: { "entry_id": entry_id, "entry_name": entry_name, "partner_id": kmc.vars.partner_id, "ks": kmc.vars.ks, "editor_type": editor_type, "user_id": kmc.vars.user_id },
//						dataType: "json",
					success: function(data) {
//							alert("ajax success: " + data);
						if (data && data.length) {
//								console.info(data);
//								alert("openEditor(data logged," + entry_name + ",1)");
							kmc.editors.start(data, entry_name, editor_type, false);
						}
					}
				});
				return;
			}
			switch(editor_type) {
				case "1" :	// KSE
				case 1	 :
					var width = "868";  // 910
					var height = "544";
					var editor_uiconf = kmc.vars.kse_uiconf;
					kmc.editors.flashvars.entry_id = entry_id;
					break;

				case "2" :	// KAE
				case 2	 :
					var width = "825";
					var height = "604";
					var editor_uiconf = kmc.vars.kae_uiconf;
					kmc.editors.params.movie = kmc.vars.service_url + "/kse/ui_conf_id/" + kmc.vars.kae_uiconf;
					kmc.editors.flashvars.entry_id = entry_id;
					break;
				default :
					alert("error: switch=default");
					break;
			}
			kmc.editors.flashvars.entry_id = entry_id;
			width = $.browser.msie ? parseInt(width) + 32 : parseInt(width) + 22;
			$("#flash_wrap").css("visibility","hidden");
			modal = kalturaInitModalBox( null, { width: width, height: height } );
			modal.innerHTML = '<div id="keditor"></div>';
			swfobject.embedSWF(	kmc.vars.service_url + "/kse/ui_conf_id/" + editor_uiconf,
								"keditor",
								width,
								height,
								"9.0.0",
								false,
								kmc.editors.flashvars,
//								kmc.utils.mergeJson(kmc.editors.flashvars, { "entry_id" : entry_id }),
								kmc.editors.params
							);
			setObjectToRemove("keditor");
		},
		flashvars: {
			"uid"			: kmc.vars.user_id, // Anonymous
			"partner_id"	: kmc.vars.partner_id,
			"subp_id"		: kmc.vars.subp_id,
			"ks"			: kmc.vars.ks,
			"kshow_id"		: "-1",
			"backF"			: "kmc.functions.closeEditor", // kse
			"saveF"			: "kmc.functions.saveEditor", // kse
			// KAE can read both formats and cases of flashvars:
			// "partnerId", "subpId", "kshowId", "entryId", "uid", "ks"
			"terms_of_use"	: kmc.vars.terms_of_use,
			"disableurlhashing" : kmc.vars.disableurlhashing,
			"jsDelegate"	: "kmc.editors.kae_functions"
		},
		params: {
			allowscriptaccess	: "always",
			allownetworking		: "all",
			bgcolor				: "#ffffff", // ? for both ?
			quality				: "high",
//			wmode				: "opaque" ,
			movie				: kmc.vars.service_url + "/kse/ui_conf_id/" + kmc.vars.kse_uiconf
		},

		kae_functions: {
			closeHandler							: function(obj) {
					kmc.utils.closeModal();
				},
			publishHandler							: kmc.functions.doNothing,
			publishFailHandler						: kmc.functions.doNothing,
			connectVoiceRecorderFailHandler			: kmc.functions.doNothing,
			getMicrophoneVoiceRecorderFailHandler	: kmc.functions.doNothing,
			initializationFailHandler				: kmc.functions.doNothing,
			initKalturaApplicationFailHandler		: kmc.functions.doNothing,
			localeFailHandler						: kmc.functions.doNothing,
			skinFailHandler							: kmc.functions.doNothing,
			getUiConfFailHandler					: kmc.functions.doNothing,
			getPluginsProviderFailHandler			: kmc.functions.doNothing,
			openVoiceRecorderHandler				: kmc.functions.doNothing,
			connectVoiceRecorderHandler				: kmc.functions.doNothing,
			startRecordingHandler					: kmc.functions.doNothing,
			recorderCancelHandler					: kmc.functions.doNothing,
			contributeVoiceRecordingHandler			: kmc.functions.doNothing,
			openContributionWizardHandler			: kmc.functions.doNothing,
			contributeEntriesHandler				: kmc.functions.doNothing,
			addTransitionHandler					: kmc.functions.doNothing,
			trimTransitionHandler					: kmc.functions.doNothing,
			addPluginHandler						: kmc.functions.doNothing,
			pluginFlagClickHandler					: kmc.functions.doNothing,
			pluginEditHandler						: kmc.functions.doNothing,
			pluginTrimHandler						: kmc.functions.doNothing,
			addAssetHandler							: kmc.functions.doNothing,
			changeSolidColorHandler					: kmc.functions.doNothing,
			trimAssetHandler						: kmc.functions.doNothing,
			duplicateHandler						: kmc.functions.doNothing,
			splitHandler							: kmc.functions.doNothing,
			reorderStoryboardHandler				: kmc.functions.doNothing,
			reorderTimelineHandler					: kmc.functions.doNothing,
			removeHandler							: kmc.functions.doNothing,
			zoomChangeHandler						: kmc.functions.doNothing,
			kalturaLogoClickHandler					: kmc.functions.doNothing,
			editVolumeLevelsButtonHandler			: kmc.functions.doNothing,
			editVolumeLevelsChangeHandler			: kmc.functions.doNothing,
			volumeOverallChangeHandler				: kmc.functions.doNothing,
			emptyTimelinesHandler					: kmc.functions.doNothing,
			showHelpHandler							: kmc.functions.doNothing,
			showVersionsWindowHandler				: kmc.functions.doNothing,
			sortMediaClipsHandler					: kmc.functions.doNothing,
			filterMediaClipsHandler					: kmc.functions.doNothing
		}
	},


// Maintain support for old kmc2 functions:

//function openCw (ks ,conversion_quality) {
//	kmc.functions.openKcw();
// }
 function expiredF() { // @todo: change all modules
	kmc.utils.expired();
 }
 function selectPlaylistContent(params) { // @todo: change call in appstudio
// function selectPlaylistContent(uiconf_id,is_playlist) {
//		alert("kmc.mediator.selectContent("+uiconf_id+","+is_playlist+")");
//		console.log(uiconf_id);
		kmc.mediator.selectContent(params.playerId,params.isPlaylist);
 }
 function logout() {
	kmc.utils.logout();
 }
 function openEditor(entry_id,entry_name,editor_type,newmix) {
	kmc.editors.start(entry_id,entry_name,editor_type,newmix);
 }
 function refreshSWF() {
//	alert("refreshSWF()");
	var state = kmc.mediator.readUrlHash();
	kmc.mediator.loadModule(state.module,state.subtab);
 }
 function openPlayer(emptystring, width, height, uiconf_id) { // for catching appstudio p&e
//	 alert("received call to openPlayer(emptystring="+emptystring+", "+"width="+width+", "+"height="+height+", uiconf_id="+uiconf_id+")");
	 kmc.preview_embed.doPreviewEmbed("multitab_playlist", null, null, true, uiconf_id); // id, name, description, is_playlist, uiconf_id
 }
// function openPlayer(id, name, description, is_playlist, uiconf_id) {
//	kmc.preview_embed.doPreviewEmbed(id, name, description, is_playlist, uiconf_id);
// }
// function openPlaylist(id, name, description, is_playlist, uiconf_id) {
//	kmc.preview_embed.doPreviewEmbed(id, name, description, is_playlist, uiconf_id);
// }
function playlistAdded() { // called from appstudio
//	alert("playlistAdded() calling kmc.preview_embed.updateList(true)");
	kmc.preview_embed.updateList(true);
}

function playerAdded() { // called from appstudio
//	alert("playerAdded() calling kmc.preview_embed.updateList(false)");
	kmc.preview_embed.updateList(false);
}

/*** end old functions ***/

//		moduleRenaming : function(module) {
//			switch(module) {
//				case "account" :
//					module = "Settings";
//				case "reports" :
//					module = "Analytics";
////				case "appstudio" :
////					module = "Studio";
//			}
//			return module;
//		},

