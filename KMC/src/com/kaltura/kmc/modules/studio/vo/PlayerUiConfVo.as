package com.kaltura.kmc.modules.studio.vo {
	import com.kaltura.kmc.modules.studio.vo.ads.AdSourceVo;
	import com.kaltura.kmc.modules.studio.vo.ads.AdvertizingVo;
	import com.kaltura.kmc.modules.studio.vo.ads.CompanionAdVo;
	import com.kaltura.kmc.modules.studio.vo.ads.InPlayerAdVo;
	
	import mx.collections.ArrayCollection;

	/**
	 * The PlayerUiConfVo holds all player data 
	 * (features file, player uiconf, etc)
	 */	
	public class PlayerUiConfVo extends Object {

		
		/**
		 * player id 
		 */
		private var _playerId:String;


		/**
		 * current template's features (full uiconf)
		 * */
		private var _fullplayer:XML;

		/**
		 * all data, including features, player name, ratio, etc. <br>
		 * from this one we can derive the "real" uiconf.
		 * */
		private var _snapshot:XML;

		
		//TODO: CHANGE THE isMultiPlaylistTemplate | isSinglePlaylist TO ONE ATTRIBUTE 
		private var _isMultiPlaylistTemplate:Boolean = false;
		private var _isSinglePlaylist:Boolean;

		private var _tags:String = "Player";

		
		/**
		 * selected advertizing configuration data
		 */
		private var _advertizing:AdvertizingVo;

		/**
		 * player name (readable, not an id)
		 */
		public var name:String;


		/**
		 * Constructor 
		 * @param playerId
		 * @param fullplayer
		 * @param snapshot
		 * @param name
		 */
		public function PlayerUiConfVo(playerId:String, fullplayer:XML = null, snapshot:XML = null, name:String = "Player Name") {
			super();
			_playerId = playerId
				
			_fullplayer = fullplayer;
			if (_fullplayer) {
				setPlayerType(_fullplayer);
			}
			
			_snapshot = snapshot;

			if (snapshot != null) {
				_advertizing = new AdvertizingVo();
				if (snapshot.advertising.length() > 0) {
					populateAdvertizingVo(snapshot.advertising[0]);
				}
			}
			
			this.name = name;
		}


		/**
		 * fills all advertizing VO fields
		 * */
		private function populateAdvertizingVo(adData:XML):void {
			/* we take all values from XML so that when a user changes any "disabled" to "enabled" we
			 * will have the default values related on the VO.
			 */
			var xml:XML;
			var xmllst:XMLList;
			var prop:String;

			_advertizing.adsEnabled = (adData.@enabled == "true");

			_advertizing.adSources = new ArrayCollection();
			xmllst = adData.adSources.source;
			var src:AdSourceVo;
			for each (xml in xmllst) {
				src = new AdSourceVo();
				src.id = xml.@id;
				src.label = xml.@label;
				src.url = xml.@url;
				src.extra = xml.text();
				if (xml.attribute("selected") == "true") {
					_advertizing.adSource = src;
				}
				_advertizing.adSources.addItem(src);
			}


			_advertizing.timeout = parseFloat(adData.playerConfig.@timeout);

			_advertizing.noticeEnabled = (adData.playerConfig.notice.@enabled == "true");
			_advertizing.noticeText = adData.playerConfig.notice.text().toString();

			_advertizing.skipEnabled = (adData.playerConfig.skip.@enabled == "true");
			_advertizing.skipText = adData.playerConfig.skip.@label.toString();


			xmllst = adData.playerConfig.companion.ad;
			if (xmllst.length() > 0) {
				var ca:CompanionAdVo;
				_advertizing.companions = new Array /*CompanionAdVo*/();
				for each (xml in xmllst) {
					ca = new CompanionAdVo();
					ca.type = xml.@type.toString();
					ca.elementid = xml.@elementid.toString();
					ca.relativeTo = xml.@relativeTo.toString();
					ca.position = xml.@position.toString();
					ca.width = xml.@width.toString();
					ca.height = xml.@height.toString();
					_advertizing.companions.push(ca);
				}
			}
			xmllst = adData.playerConfig.companion.elements.element;
			var ar:Array = new Array();
			var o:Object;
			for each (xml in xmllst) {
				o = new Object();
				o.elementid = xml.@elementid.toString(); 
				o.relativeTo = xml.@relativeTo.toString(); 
				o.position = xml.@position.toString(); 
				ar.push(o);
			}
			_advertizing.flashCompanionLocations = new ArrayCollection(ar);



			_advertizing.bumperEnabled = adData.timeline.bumper.attribute("enabled") == "true";
			_advertizing.bumperUrl = adData.timeline.bumper.attribute("clickurl");
			_advertizing.bumperEntry = adData.timeline.bumper.attribute("entryid");
			// don't use @ because it is possible that no entryid is provided.

			var tmp1:InPlayerAdVo;
			xml = adData.timeline.preroll[0];
			tmp1 = new InPlayerAdVo();
			tmp1.enabled = xml.@enabled == "true";
			if (xml.length() > 0) {
				tmp1.nAds = xml.@nads.toString();
				tmp1.frequency = xml.@frequency.toString();
				tmp1.start = xml.@start.toString();
				tmp1.url = xml.@url.toString();
			}
			_advertizing.preroll = tmp1;

			xml = adData.timeline.postroll[0];
			tmp1 = new InPlayerAdVo();
			tmp1.enabled = xml.@enabled == "true";
			if (xml.length() > 0) {
				tmp1.nAds = xml.@nads.toString();
				tmp1.frequency = xml.@frequency.toString();
				tmp1.start = xml.@start.toString();
				tmp1.url = xml.@url.toString();
			}
			_advertizing.postroll = tmp1;

			xml = adData.timeline.overlay[0];
			tmp1 = new InPlayerAdVo();
			tmp1.enabled = xml.@enabled == "true";
			if (xml.length() > 0) {
				tmp1.nAds = xml.@nads.toString();
				tmp1.frequency = xml.@frequency.toString();
				tmp1.start = xml.@start.toString();
				tmp1.url = xml.@url.toString();
			}
			_advertizing.overlay = tmp1;

			_advertizing.linearAdsValues = adData.timeline.values[0];
		}


		private function setPlayerType(fullplayer:XML):void {
			if (fullplayer) {
				if (fullplayer.@isPlaylist == "true") {
					_tags = "Playlist";
					_isMultiPlaylistTemplate = false;
					_isSinglePlaylist = true;
				}
				else if (fullplayer.@isPlaylist == "multi") {
					_tags = "multiPlaylist";
					_isMultiPlaylistTemplate = true;
					_isSinglePlaylist = false;
				}
				else {
					_tags = "Player";
					_isMultiPlaylistTemplate = false;
					_isSinglePlaylist = false;
				}
			}
		}


		public function set fullplayer(value:XML):void {
			_fullplayer = value;
			setPlayerType(_fullplayer);
		}

		/**
		 * @copy #_fullplayer
		 * */
		public function get fullplayer():XML {
			return _fullplayer;
		}


		public function set isMultiPlaylistTemplate(value:Boolean):void {
			_isMultiPlaylistTemplate = value;
		}


		public function get isMultiPlaylistTemplate():Boolean {
			return _isMultiPlaylistTemplate;
		}


		public function get isSinglePlaylist():Boolean {
			return _isSinglePlaylist;
		}


		[Bindable]
		public function set isSinglePlaylist(value:Boolean):void {
			_isSinglePlaylist = value;
		}


		public function set snapshot(value:XML):void {
			_snapshot = value;
		}

		/**
		 * @copy #_snapshot 
		 */
		public function get snapshot():XML {
			return _snapshot;
		}


		public function set playerId(value:String):void {
			_playerId = value;
		}


		public function get playerId():String {
			return _playerId;
		}

		
		/**
		 * all the template's features, including unused ones, and with data for used ones.
		 * only for the features tab!!
		 * */
		public function get features():XML {
			return _snapshot..features[0];
		}


		public function get fullTemplateId():String {
			return _snapshot.@fullPlayerId.toString();
		}


		public function set tags(value:String):void {
			_tags = value;
		}


		public function get tags():String {
			return _tags;
		}


		/**
		 * @dopy _advertizing 
		 * @return 
		 * 
		 */		
		public function get advertizing():AdvertizingVo {
			return _advertizing;
		}


		[Bindable]
		public function set advertizing(value:AdvertizingVo):void {
			_advertizing = value;
		}

	}
}