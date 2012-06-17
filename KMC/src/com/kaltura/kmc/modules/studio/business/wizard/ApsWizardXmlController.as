package com.kaltura.kmc.modules.studio.business.wizard {
	import com.kaltura.kmc.modules.studio.view.wizard.ApsWizFeatures;
	import com.kaltura.kmc.modules.studio.view.wizard.ApsWizPreviewPlayer;
	import com.kaltura.kmc.modules.studio.view.wizard.ApsWizStyle;
	import com.kaltura.kmc.modules.studio.view.wizard.ApsWizTemplate;
	import com.kaltura.kmc.modules.studio.view.wizard.ApsWizardContent;
	import com.kaltura.kmc.modules.studio.vo.StyleVo;
	import com.kaltura.kmc.modules.studio.vo.TemplateVo;
	import com.kaltura.kmc.modules.studio.vo.ads.AdSourceVo;
	import com.kaltura.kmc.modules.studio.vo.ads.AdvertizingVo;
	import com.kaltura.kmc.modules.studio.vo.ads.CompanionAdVo;
	import com.kaltura.kmc.modules.studio.vo.ads.InPlayerAdVo;
	import com.kaltura.utils.ObjectUtil;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.XMLListCollection;
	import mx.controls.ColorPicker;
	import mx.resources.ResourceManager;

	/**
	 * ApsWizardXmlController handles all (most..) XML-related actions.
	 */
	public class ApsWizardXmlController extends EventDispatcher {

		private const CUSTOM:String = "Custom";


		/**
		 * XMLListCollection of all currently used features.
		 * <br>(from features.xml)
		 */
		private var _featuresCollection:XMLListCollection;
		
		/**
		 * @copy #colorPlugins 
		 */		
		private var _colorPlugins:XML = null;

		/**
		 * a full uiconf.xml, with all possible features
		 * */
		private var _fullPlayer:XML;

		
		/**
		 * get XMLList of all nodes whose Id starts with given substring
		 * @param xml	full player
		 * @param idSubstring	the string to find
		 * @reutrn list of matching nodes
		 */
		private function getElementsWhereIdStartsWith(xml:XML, idSubstring:String):XMLList {
			return xml..descendants().(attribute("id").toString().indexOf(idSubstring) == 0);
		}




		/**
		 * Clear the icon/s or the label from the button node in Uiconf, 
		 * add colors tags and button type
		 * @param buttonXml		button node to process
		 * @param kButtonType	the type of the button as the studio sees it
		 * @param colorObject	color definitions to apply
		 * @return processed button node
		 */
		protected function clearIconsOrLabels(buttonXml:XML, kButtonType:String, colorObject:StyleVo):XML {
			// old skin
			if (kButtonType == "buttonControllerArea") {
				// label buttons on the controller
				delete buttonXml.@Icon;
				delete buttonXml.@icon;
				delete buttonXml.@selectedIcon;
				delete buttonXml.@upIcon;
				delete buttonXml.@overIcon;
				delete buttonXml.@downIcon;
				delete buttonXml.@disabeledIcon;
				delete buttonXml.@selectedUpIcon;
				delete buttonXml.@selectedOverIcon;
				delete buttonXml.@selectedDownIcon;
				delete buttonXml.@selectedDisabledIcon;
				buttonXml.@buttonType = "labelButton";
			}
			else if (kButtonType == "buttonIconControllerArea") {
				// icon buttons on the controller
				delete buttonXml.@label[0];
				buttonXml.@buttonType = "iconButton";
			}
			
			// new (Falcon) skin
			else if (kButtonType == "falconButtonIconControllerArea") {
				// icon buttons on the controller
				delete buttonXml.@label[0];
				buttonXml.@buttonType = "normal";
			}
			
			else if (kButtonType == "buttonVideoArea") {
				buttonXml.@buttonType = "onScreenButton";
			}
			else if (kButtonType == "falconButtonVideoArea") {
				buttonXml.@buttonType = "normal";
			}
			
			
			
			// style
			if (colorObject) {
				colorElement(buttonXml, colorObject);
				if (colorObject.fontName)
					buttonXml.@font = colorObject.fontName;
			}
			return buttonXml;
		}


		/**
		 * clears all data from the controller and makes it eligible
		 * for garbage collection.
		 */
		public function dispose():void {
			_featuresCollection = null;
			_fullPlayer = null;
		}


		/**
		 * creates a snapshot xml
		 * @param ads		advertising data, or null if template don't have advertising data
		 * @param screenAssets	screen assets data
		 * @param fullPlayerID	id of full player file
		 * @param templateType	player's type
		 * @param style			color and font data
		 * @param size			width and height
		 * @param template		template data
		 * @param genFeatures	general plugins and features data
		 * @param content		playlists data (for multiplaylist players)
		 * @return a snapshot xml made of the given parameters
		 */
		public function buildSnapshot(advo:AdvertizingVo, screenAssets:XML, fullPlayerID:String,
			templateType:String, style:StyleVo, size:Object,
			template:TemplateVo, genFeatures:XML,
			content:ApsWizardContent):XML {
			// implement the full template within the snapshot
			var snapshot:XML = <snapshot/>;
			snapshot.@fullPlayerId = fullPlayerID;
			// add features:
			var features:XML = getFeaturesXML();
			snapshot.appendChild(features);

			// don't add advertising data if template features file doesn't have this tab
			if (advo != null) {
				var ads:XML = getAdvertisingXML(advo);
				snapshot.appendChild(ads);
			}

			snapshot.appendChild(screenAssets);

			// add theme:

			var visual:XML =
				<visual/>
				;
			var createdTheme:XML;
			if (style){ // 508 players don't have style
				createdTheme = getStyleXML(style);
				visual.appendChild(createdTheme);
			}
			snapshot.appendChild(visual);

			// add player properties:
			var playerProperties:XML = <playerProperties/>
			var playerWidth:XML = XML("<width>" + size.playerWidth.toString() + "</width>");
			playerProperties.appendChild(playerWidth);
			var playerHeight:XML = XML("<height>" + size.playerHeight.toString() + "</height>");
			playerProperties.appendChild(playerHeight);

			if (style){
				var playerTheme:XML = XML("<theme>" + createdTheme.@id + "</theme>");
				playerProperties.appendChild(playerTheme);
			}
			snapshot.appendChild(playerProperties);

			// build the uiVars section
			var contentXml:XML;
			if (content) {
				contentXml = content.getWidgetPlaylistXML();
			}

			var uiVars:XML = getUiVarsXml(templateType, template, genFeatures, contentXml);
			snapshot.appendChild(uiVars);

			return snapshot;
		}


		/**
		 * deleting specific items from specific screens <br>
		 * (feature is selected - this is a drilldown to its screens)
		 * @param player
		 * @return  same player data without the nonactive sub features
		 */
		private function deleteNonactiveSubFeatures(player:XML):XML {
			var activeFeatures:XMLList = _featuresCollection.copy().(attribute("k_value") == "true");
			var activeFeatureFormXml:XML;
			var featureToRemove:XML;
			var activeFeatureName:String;
			var nonActiveFeatures:XMLList;
			var str:String;

			// handle buttons 
			for each (activeFeatureFormXml in activeFeatures) {
				activeFeatureName = activeFeatureFormXml.attribute("id")[0].toString();
				// drill down the feature and find which screens are not active
				nonActiveFeatures = activeFeatureFormXml.descendants("CheckBox").(attribute("k_value") == "false");
				for each (featureToRemove in nonActiveFeatures) {
					str = activeFeatureName + featureToRemove.@id.toString();
					delete(player.descendants().(attribute("id") == str)[0]);
				}
			}
			return player;
		}


		/**
		 * delete all features that are not active at all for the given player
		 * (not selected from the main accordion screen, feature selected=false)
		 * @param player	player data
		 * @return 		same player data without the nonactive features
		 */
		private function deleteNonactiveFeatures(player:XML):XML {
			var allFeatures:XML = <allFeatures/>;
			allFeatures.appendChild(_featuresCollection.copy());
			var nonActiveFeatures:XMLList = allFeatures..feature.(attribute("selected") == "false");
			var nonActivePlayerFeatures:XMLList;
			for each (var featureFormXml:XML in nonActiveFeatures) {
				// search for a matching item in the player and delete it (search in all screens)
				var featureName:String = featureFormXml.attribute("id")[0].toString();
				// get all related features, based on their ids. (i.e. fullscreen button in controller, start screen, hover, etc)
				nonActivePlayerFeatures = getElementsWhereIdStartsWith(player, featureName);
				for each (var featureToDelete:XML in nonActivePlayerFeatures) {
					var nameOfFeatureToDelete:String = featureToDelete.attribute("id").toString();
					delete(player.descendants().(attribute("id") == nameOfFeatureToDelete)[0]);
				}
				// if a special feature has a plugin - remove it from the UI xml
				if (featureFormXml.attribute("pluginId").length()) {
					var nameOfPluginToDelete:String = featureFormXml.attribute("pluginId")[0].toString();
					delete(player.descendants().(attribute("id") == nameOfPluginToDelete)[0]);
				}
			}
			return player;
		}


		/**
		 * creates the "real" uiconf.xml
		 * @param playerName	the player's name
		 * @param templateType 	the player's type
		 * @param advo 			advertising data
		 * @param style			styling data
		 * @param template		template data
		 * @param genFeatures	general uivars and features data
		 * @param content		playlist data (for multiplaylist players)
		 * @return uiconf.xml
		 */
		public function getPlayerUIConf(playerName:String, templateType:String, advo:AdvertizingVo,
						style:StyleVo, template:TemplateVo, genFeatures:XML, content:ApsWizardContent):XML {
			
			var fullPlayerCopy:XML = _fullPlayer.copy();
			fullPlayerCopy.@name = playerName;
			delete(fullPlayerCopy.features);

			fullPlayerCopy = deleteNonactiveFeatures(fullPlayerCopy);
			fullPlayerCopy = deleteNonactiveSubFeatures(fullPlayerCopy);

			var activeFeatures:XMLList = _featuresCollection.copy().(attribute("k_value") == "true");
			var featureXml:XML;
			var activeFeatureName:String;
			var attributeToWrite:String;
			var attributeValue:String;

			var param:XML, element:XML;

			// setting k_param. a general kapram that is defined as changable 
			for each (featureXml in activeFeatures) {
				// skip radio buttons, they are there for the ui and their relevant valueis taken from their group
				if (featureXml.localName() == "RadioButton") {
					continue;
				}

				activeFeatureName = featureXml.attribute("id")[0].toString();
				// first take only the ones that have no "applyTo" and put values on feature element

				// get all parameters
				var attributesToUpdate:XMLList = featureXml.descendants().(attribute("k_param").toString().length != 0 && attribute("applyTo").toString().length == 0);
				// get the matching elements in the real player XML 
				var playerElements:XMLList = getElementsWhereIdStartsWith(fullPlayerCopy, activeFeatureName);

				for each (element in playerElements) {
					for each (param in attributesToUpdate) {
						// save data to the player :
						attributeToWrite = param.attribute("k_param").toString();
						attributeValue = param.attribute("k_value").toString();
						element.attribute(attributeToWrite)[0] = attributeValue;
					}
				}

				// then take the ones that have "applyTo", for each one get relevant node and apply attributes to the node
				// get all parameters
				attributesToUpdate = featureXml.descendants().(attribute("k_param").toString().length != 0 && attribute("applyTo").toString().length > 0);
				// search the matching feature in the real player XML
				for each (param in attributesToUpdate) {
					playerElements = fullPlayerCopy.descendants().(attribute("id") == param.@applyTo);
					// (Atar: I think there should only be one)				
					for each (element in playerElements) {
						// save data to the player:
						attributeToWrite = param.attribute("k_param").toString();
						attributeValue = param.attribute("k_value").toString();
						element.attribute(attributeToWrite)[0] = attributeValue;
					}
				}
			}

			// Handling the buttons. 
			var contButton:XML;

			for each (featureXml in activeFeatures) {
				activeFeatureName = featureXml.attribute("id")[0].toString();
				var controllerButtons:XMLList = featureXml.descendants().(attribute("k_param") == "k_buttonType" &&
					(attribute("k_value") == "buttonIconControllerArea" || attribute("k_value") == "buttonControllerArea"
						|| attribute("k_value") == "falconButtonIconControllerArea"));
				// controller buttons
				if (controllerButtons.length() > 0) {
					var featureNameToLookFor:String = featureXml.@id.toString() + "ControllerScreen"
					contButton = (fullPlayerCopy.descendants().(attribute("id") == featureNameToLookFor)[0]);
					if (contButton)
						clearIconsOrLabels(contButton, controllerButtons.@k_value, style);
				}
				//screen buttons
				var onScreenButtonsList:XMLList = featureXml.descendants().((attribute("id") == "StartScreen") 
														|| (attribute("id") == "EndScreen") 
														|| (attribute("id") == "PauseScreen") 
														|| (attribute("id") == "PlayScreen"));
				for each (var onscreenXML:XML in onScreenButtonsList) {
					if (onscreenXML.@k_value.toString() == "true") {
						contButton = (fullPlayerCopy.descendants().(attribute("id") == (featureXml.@id.toString() + onscreenXML.@id.toString()))[0]);
						//TODO add buttonType attribute on the checkboxes, with default value for old template (buttonVideoArea)
						// and for new template (falconButtonVideoArea)
						if (contButton) {
							if (onscreenXML.@k_buttonType == "falconButtonVideoArea") {
								clearIconsOrLabels(contButton, "falconButtonVideoArea", style);
							}
							else {
								clearIconsOrLabels(contButton, "buttonVideoArea", style);
							}
						}
					}
				}
			}

			if (style) {
				fullPlayerCopy = colorSpecificUiElements(fullPlayerCopy, style);
			}

			// ADVERTISING
			fullPlayerCopy = setAdvertisingData(fullPlayerCopy, advo, style);

			//handle the gigya uiConf: take the uiconf from the feature to the gigya layer
			var gigyaFeature:XML = activeFeatures.(@id.toString() == "shareBtn")[0];
			if (gigyaFeature) {
				var gigyaLayer:XML = fullPlayerCopy.descendants().(attribute("id").toString() == 'gigya')[0];
				//set the uiconfId only if there is a value
				if (gigyaFeature.descendants().(attribute("id").toString() == 'uiconfId')[0].@k_value.toString())
					gigyaLayer.@uiconfId = gigyaFeature.descendants().(attribute("id").toString() == 'uiconfId')[0].@k_value.toString();
			}

			if (style) {
				// GIGYA THEME (if no style > is 508 > no gigya anyway)
				fullPlayerCopy = selectGigyaTheme(fullPlayerCopy, style.themeId);

				// skin path:
				fullPlayerCopy.@skinPath = style.skinPath;
			}


			// delete all "selected" attributes from the player
			// (k_param = selcted)
			delete fullPlayerCopy.descendants().@selected
			//switching the theme to the current theme
			delete fullPlayerCopy..theme[0];

			// PLAYLIST RENDERER
			// set the rowHeight of the item renderer 
			var listPlugin:XML = fullPlayerCopy.descendants("Plugin").(attribute("id") == "list")[0];
			if (listPlugin){
				//set the vbox height calculated. if more than 4 items add 19 pixels for each one
				//this is bad but no time
				if (fullPlayerCopy.renderers && fullPlayerCopy.renderers.renderer) {
					var renderer:XML = fullPlayerCopy.renderers.renderer[0];
					if (renderer) {
						var labelsXml:XML = renderer..VBox.(attribute("id")[0].toString() == "labelsHolder")[0];
						var labels:XMLList = labelsXml.children();
	
						// check if there is an Image
						var imgNode:XML = renderer..Image.(attribute("id")[0].toString() == "irImageIrScreen")[0];
	
						var rowHeight:Number;
						// if we have an image and less then 3 labels
						if (labels.length() < 3 && imgNode) {
							rowHeight = imgNode.@height;
							// at least picture height, and no less than 70 pixels.
							rowHeight = Math.max(rowHeight, 70);
						}
						else if (labels.length() > 0) {
							// number of labels * 20 (which is the height of label + padding etc), plus 10 for cell padding
							rowHeight = labels.length() * 20 + 10;
							if (imgNode && imgNode.@height) {
								// if the image is taller than the labels, use image height (added for falcon skin)
								rowHeight = Math.max(rowHeight, (parseInt(imgNode.@height) + 10));
							}
						}
						else {
							rowHeight = 30; // min value for item renderer with no image
						}
	
						listPlugin.@rowHeight = rowHeight;
	
						//set the font to the itemRenderer labels
						var allLabels:XMLList = renderer..Label;
						for each (var lab:XML in allLabels) {
							// burried assumption - 508 players (no style) are not playlist players
							lab.@font = style.fontName;
						}
					}
				}
			}

			// color all the marked plugins
			if (style) {
				fullPlayerCopy = colorMarkedPlugins(activeFeatures, fullPlayerCopy, style);
			}


			// UIVARS:
			// delete previous uiVars elements
			var uiVarsList:XMLList = fullPlayerCopy.children().child("uiVars");
			var listLength:uint = uiVarsList.length();
			for (var k:uint = 0; k < listLength; k++) {
				delete uiVarsList[0];
			}

			// for multiplaylist players, we have content as part of the player
			var contentXml:XML;
			if (content) {
				contentXml = content.getWidgetPlaylistXML();
			}

			// build the uiVars section
			var uiVars:XML = getUiVarsXml(templateType, template, genFeatures, contentXml);
			fullPlayerCopy.appendChild(uiVars);

			return fullPlayerCopy;
		}

		
		/**
		 * handle the coloring of ui components that require specific treatment
		 * @param fullPlayerCopy	the player being edited
		 * @param style				color definitions
		 * @return 					adapted player
		 * 
		 */
		protected function colorSpecificUiElements(fullPlayerCopy:XML, style:StyleVo):XML {
			// handle the volume bar
			var uiElementXml:XML;
			uiElementXml = fullPlayerCopy.descendants().(attribute("id").toString() == 'volumeBar')[0];
			if (uiElementXml) {
				colorElement(uiElementXml, style);
				uiElementXml.@font = style.fontName;
			}
			
			// handle the movie title
			uiElementXml = fullPlayerCopy.descendants().(attribute("id").toString() == 'movieName')[0];
			if (uiElementXml) {
				uiElementXml.@dynamicColor = "true";
				if (style.color1 != int.MAX_VALUE) {
					uiElementXml.@color1 = style.color1;
				}
				uiElementXml.@font = style.fontName;
			}
			
			// handle the tab bar if available 
			uiElementXml = fullPlayerCopy.descendants().(attribute("id").toString() == 'tabBar')[0];
			if (uiElementXml) {
				colorElement(uiElementXml, style);
				uiElementXml.@dynamicColor = "true";
				uiElementXml.@font = style.fontName;
			}
			
			// handle scrubber colors
			uiElementXml = fullPlayerCopy.descendants().(attribute("id").toString() == 'scrubber')[0];
			if (uiElementXml && style.color1 != int.MAX_VALUE) {
				uiElementXml.@color1 = style.color1;
				uiElementXml.@color2 = style.color1;
			}
			
			// handle timer1 colors
			uiElementXml = fullPlayerCopy.descendants().(attribute("id").toString() == 'timerControllerScreen1')[0];
			if (uiElementXml && style.color1 != int.MAX_VALUE) {
				uiElementXml.@color1 = style.color1;
			}
			
			// handle timer2 colors
			uiElementXml = fullPlayerCopy.descendants().(attribute("id").toString() == 'timerControllerScreen2')[0];
			if (uiElementXml && style.color1 != int.MAX_VALUE) {
				uiElementXml.@color1 = style.color1;
			}
			
			// handle flavorComboControllerScreen colors
			uiElementXml = fullPlayerCopy.descendants().(attribute("id").toString() == 'flavorComboControllerScreen')[0];
			if (uiElementXml && style.color1 != int.MAX_VALUE) {
				uiElementXml.@color1 = style.color1;
			}
			
			return fullPlayerCopy;
		}
		
		
		/**
		 * delete irrelevant gigya themes and leave only the selected one. 
		 * @param fullPlayerCopy	the created player after removing nodes of unused features
		 * @param currentThemeId	id of required theme
		 * @return adapted player
		 */
		protected function selectGigyaTheme(fullPlayerCopy:XML, currentThemeId:String):XML {
			// remove all pre-given themes
			var themesToDelete:XMLList = fullPlayerCopy.descendants("theme").(attribute("id").toString() != "currentTheme");
			var defaultThemeXml:XML = new XML(fullPlayerCopy.descendants().(attribute("id") == currentThemeId)[0] as XML);
			for each (var themeXML:XML in themesToDelete) {
				var themeId:String = themeXML.@id;
				delete(fullPlayerCopy.descendants().(attribute("id") == themeId)[0]);
			}
			
			var availabelsGigyasTheme:XMLList = fullPlayerCopy..extraData.GigyaUI;
			var gigyaXml:XML;
			//get the current style from stylePage and get the matching data of gigya :
			defaultThemeXml.@id = currentThemeId;
			
			for (var i:uint = 0; i < availabelsGigyasTheme.length(); i++) {
				if (XML(availabelsGigyasTheme[i]).@theme.toString() == currentThemeId) {
					//found a matching gigya section 
					gigyaXml = new XML(availabelsGigyasTheme[i]);
				}
			}
			if (gigyaXml) {
				// delete existing themes
				var gigyaThemesNumber:uint = availabelsGigyasTheme.length();
				var allGigyasTheme:XMLList = fullPlayerCopy..extraData..GigyaUI;
				for (var j:uint = 0; j < gigyaThemesNumber; j++) {
					delete(allGigyasTheme[0]);
				}
			}
			else {
				gigyaXml = fullPlayerCopy.extraData.GigyaUI[0] as XML;
				delete(fullPlayerCopy.extraData..GigyaUI);
			}
			// add selected theme
			fullPlayerCopy.extraData[0].appendChild(gigyaXml);
			return fullPlayerCopy;
		}

		/**
		 * color plugins that are marked for coloring on the player uiconf or in the features file.
		 * @param activeFeatures	the set of features which are active on the created player (in features.xml)
		 * @param fullPlayerCopy	the created player after removing nodes of unused features
		 * @param colorObj			color definitions for teh created player
		 * @return adapted player
		 * 
		 * @internal this function was added for a specific usecase which is not part of SaaS templates. 
		 */
		protected function colorMarkedPlugins(activeFeatures:XMLList, fullPlayerCopy:XML, colorObj:StyleVo):XML {
			var pluginId:String;
			var targetPlugin:XML;
			// get the list of plugins that are marked as setColors="true" (need to be colored)
			var coloredPlugins:XMLList = activeFeatures.(attribute("setColors").toString() == "true");
			if (coloredPlugins.length()) {
				for each (var colored:XML in coloredPlugins) {
					pluginId = colored.attribute("id").toString();
					var pluginTarget:String = colored.attribute("colorPlugin")[0].toString()
					targetPlugin = fullPlayerCopy..descendants().(attribute("id") == pluginTarget)[0];
					if (targetPlugin)
						colorElement(targetPlugin, colorObj);
				}
			}
			
			// set colors to static plugins
			//			   <colorPlugins>
			//			   <plugin id='fdt' />
			//			   </colorPlugins>
			if (_colorPlugins) {
				var pluginsList:XMLList = _colorPlugins.children();
				for each (var coloredFromList:XML in pluginsList) {
					pluginId = coloredFromList.attribute("id").toString();
					targetPlugin = fullPlayerCopy..descendants().(attribute("id") == pluginId)[0];
					if (targetPlugin)
						colorElement(targetPlugin, colorObj);
				}
			}
			return fullPlayerCopy;
		} 
		
		
		
		/**
		 * Add all colors from the color Object to the given xml
		 * @param plugin	xml node describing the plugin to be colored
		 * @param colorObject	color definitions to apply
		 * @return
		 *
		 */
		protected function colorElement(element:XML, colorObject:StyleVo):void {
			if (colorObject.color1 != int.MAX_VALUE) {
				element.@color1 = colorObject.color1;
			}
			if (colorObject.color2 != int.MAX_VALUE) {
				element.@color2 = colorObject.color2;
			}
			if (colorObject.color3 != int.MAX_VALUE) {
				element.@color3 = colorObject.color3;
			}
			if (colorObject.color4 != int.MAX_VALUE) {
				element.@color4 = colorObject.color4;
			}
			if (colorObject.color5 != int.MAX_VALUE) {
				element.@color5 = colorObject.color5;
			}
		}

		/**
		 * sets the advertising related pieces of the given player
		 * @param player	(uiconf.xml)
		 * @return
		 */
		protected function setAdvertisingData(player:XML, advo:AdvertizingVo, style:StyleVo):XML {
			var i:int, l:int;
			if (advo.adsEnabled) {
				// BUMPER
				if (advo.bumperEnabled) {
					var bumper:XML = player..Plugin.(@id == "bumper")[0];
					bumper.@bumperEntryID = advo.bumperEntry;
					if (advo.bumperUrl != "") {
						bumper.@clickurl = advo.bumperUrl;
					}
					else {
						delete bumper.attribute("clickurl")[0];
					}
//					bumper.@lockUI = "true";
//					bumper.@playOnce = "false";	// don't touch, leave current values
					if (advo.adSource.id == "vastAdServer") {
						bumper.@preSequence = advo.preroll.enabled ? 2 : 1;
					}
					else if (advo.adSource.id == "bumperOnly") {
						bumper.@preSequence = 1;
						// remove vast
						delete player..Plugin.(@id == "vast")[0];
						delete player..Plugin.(@id == "overlay")[0];
						delete player..Button.(@id == "skipBtn")[0];
						delete player..Label.(@id == "noticeMessage")[0];
						// remove customAd
						delete player..Plugin.(@id == "customAd")[0];
					}
					else {
						// custom swf
						/* custom swfs always have the first timeslot for prerolls,
						 * so in this case the bumper takes order 2.	*/
						bumper.@preSequence = 2;
					}
					// post bumper will not be configurable via appstudio at this time.
					delete bumper.attribute("postSequence")[0];
				}
				else {
					// delete bumper plugin
					delete player..Plugin.(@id == "bumper")[0];
				}

				// VAST
				if (advo.adSource.id == "vastAdServer") {
					// remove customAd
					delete player..Plugin.(@id == "customAd")[0];
					// set vast attributes
					var vast:XML = player..Plugin.(@id == "vast")[0];
					vast.@timeout = advo.timeout;
					vast.@trackCuePoints = advo.trackCuePoints;
					// preroll
					if (advo.preroll.enabled) {
						vast.@numPreroll = advo.preroll.nAds;
						vast.@prerollInterval = advo.preroll.frequency;
						vast.@prerollStartWith = advo.preroll.start;
						vast.@prerollUrl = advo.preroll.url;
						vast.@preSequence = "1";
					}
					else {
						delete vast.attribute("numPreroll")[0];
						delete vast.attribute("prerollInterval")[0];
						delete vast.attribute("prerollStartWith")[0];
						delete vast.attribute("prerollUrl")[0];
						delete vast.attribute("preSequence")[0];
					}
					// overlay
					var overlay:XML;
					if (advo.overlay.enabled) {
						vast.@overlayInterval = advo.overlay.frequency;
						vast.@overlayStartAt = advo.overlay.start;
						vast.@overlayUrl = advo.overlay.url;
						overlay = player..Plugin.(@id == "overlay")[0];
						overlay.@displayDuration = advo.overlay.nAds;
						overlay.@trackCuePoints = advo.trackCuePoints;
					}
					else {
						delete vast.attribute("overlayInterval")[0];
						delete vast.attribute("overlayStartAt")[0];
						delete vast.attribute("overlayUrl")[0];

						// overlay plugin is not needed for vast purposes.
						if (advo.trackCuePoints) {
							overlay = player..Plugin.(@id == "overlay")[0];
							delete overlay.attribute("displayDuration")[0];
							delete overlay.attribute("swfUrls")[0];
							delete overlay.attribute("overlayStartAt")[0];
							delete overlay.attribute("overlayInterval")[0];
							overlay.@trackCuePoints = advo.trackCuePoints;

						}
						// delete overlay plugin if not required for cuepoints or vast
						else {
							delete player..Plugin.(@id == "overlay")[0];
						}
					}
					// postroll
					if (advo.postroll.enabled) {
						vast.@numPostroll = advo.postroll.nAds;
						vast.@postrollInterval = advo.postroll.frequency;
						vast.@postrollStartWith = advo.postroll.start;
						vast.@postrollUrl = advo.postroll.url;
						vast.@postSequence = "1";
					}
					else {
						delete vast.attribute("numPostroll")[0];
						delete vast.attribute("postrollInterval")[0];
						delete vast.attribute("postrollStartWith")[0];
						delete vast.attribute("postrollUrl")[0];
						delete vast.attribute("postSequence")[0];
					}
					// flash companion ads
					var companions:Array = advo.companions;
					if (companions != null && companions.length > 0) {
						// separate flash and html companions
						var flashAds:Array = new Array();
						var htmlAds:Array = new Array();
						l = companions.length;
						for (i = 0; i < l; i++) {
							if (companions[i].type == "flash") {
								flashAds.push(companions[i]);
							}
							else {
								htmlAds.push(companions[i]);
							}
						}

						var comps:String;
						var ca:CompanionAdVo;
						// flash companion ads
						l = flashAds.length;
						if (l > 0) {
							comps = "";
							for (i = 0; i < l; i++) {
								ca = flashAds[i];
								comps += ca.relativeTo + ":" + ca.position + ":" + ca.width + ":" + ca.height + ";";
							}
							vast.@flashCompanions = comps;
						}
						// html companion ads
						l = htmlAds.length;
						if (l > 0) {
							comps = "";
							for (i = 0; i < l; i++) {
								ca = htmlAds[i];
								comps += ca.elementid + ":" + ca.width + ":" + ca.height + ";";
							}
							vast.@htmlCompanions = comps;
						}
					}
					else {
						// no companion ads of any type. remove attributes.
						delete vast.attribute("htmlCompanions")[0];
						delete vast.attribute("flashCompanions")[0];
					}

					// skip button
					if (advo.skipEnabled) {
						var skip:XML = player..Button.(@id == "skipBtn")[0];
						skip.@label = advo.skipText;
						if (style) {
							// 508 players don't have style
							if (style.color1 != int.MAX_VALUE)
								skip.@color1 = style.color1.toString();
							if (style.color2 != int.MAX_VALUE)
								skip.@color2 = style.color2.toString();
						}
					}
					else {
						delete player..Button.(@id == "skipBtn")[0];
					}

					// notice message 
					if (advo.noticeEnabled) {
						var notice:XML = player..Label.(@id == "noticeMessage")[0];
//						var s:String = advo.noticeText;
//						s = s.split("$(remainingSeconds)").join("{SequenceProxy.timeRemaining}");
//						notice.@text = s;
						notice.@text = advo.noticeText;
						if (style) {
							notice.@color1 = style.color1.toString();
						}
					}
					else {
						delete player..Label.(@id == "noticeMessage")[0];
					}
				}
				else if (advo.adSource.id != "bumperOnly") {
					// CUSTOM SWF
					// remove vast
					delete player..Plugin.(@id == "vast")[0];
					delete player..Plugin.(@id == "overlay")[0];
					delete player..Button.(@id == "skipBtn")[0];
					delete player..Label.(@id == "noticeMessage")[0];

					// create a custom swf plugin:
					var plugin:XML = player..Plugin.(@id == "customAd")[0];
					plugin.@path = advo.adSource.url;
					/* custom swfs are supposed to handle the cases in which they are not required for one of
					 * the sequences by themselves.these funny conditionals are here for the day we realize this
					 * is not working well and we need to allow appstudio configure this, like in VAST.	*/
					if (true /*advo.preroll.enabled*/) {
						plugin.@preSequence = 1;
					}
					else {
						delete plugin.attribute("preSequence")[0];
					}
					if (true /*advo.postroll.enabled*/) {
						plugin.@postSequence = 1;
					}
					else {
						delete plugin.attribute("postSequence")[0];
					}
					// key-value pairs to attributes:
					if (advo.adSource.extra != null && advo.adSource.extra != "") {
						var pairs:Array = advo.adSource.extra.split(";");
						var pair:Array;
						for (i = 0; i < pairs.length; i++) {
							pair = pairs[i].split("=");
							plugin.attribute(pair[0])[0] = pair[1];
						}
					}
				}


			}
			else {
				// no ads, remove all relevant pieces.
				delete player..Plugin.(@id == "bumper")[0];
				delete player..Plugin.(@id == "customAd")[0];
				delete player..Plugin.(@id == "vast")[0];
				delete player..Plugin.(@id == "overlay")[0];
				delete player..Button.(@id == "skipBtn")[0];
				delete player..Label.(@id == "noticeMessage")[0];
			}
			return player;
		}


		/**
		 * create a snapshot of the features in the player XML. <br>
		 * (features part of features.xml)
		 * @return features data
		 */
		private function getFeaturesXML():XML {
			var featuresXml:XML = <featuresData/>;

			// a wrapper for _featuresCollection
			var dataFeaturesXml:XML = <xml></xml>
			for each (var xml:XML in _featuresCollection) {
				dataFeaturesXml.appendChild(xml);
			}

			var dataFeatures:XMLList = dataFeaturesXml.descendants().(attribute("k_param").toString().length != 0);
			for each (var dataFeature:XML in dataFeatures) {
				var fullName:String = dataFeature.@id;
				if (!fullName)
					continue;
				var k_value:String = dataFeature.@k_value;
				while (dataFeature = dataFeature.parent()) {
					if (dataFeature.@id[0])
						fullName = dataFeature.@id + "." + fullName;
				}
				var node:XML = <feature/>;
				node.@k_fullName = fullName;
				node.@k_value = k_value;
				featuresXml.appendChild(node);
			}
			return featuresXml;
		}


		/**
		 * selects a skin path according to selected theme
		 * @param skinPath current skin path
		 * @param theme	theme name
		 * @return 	updated skin path
		 */
		private function updateSkinPath(skinPath:String, theme:String):String {
			if (theme == "light") {
				var currentSkinPath:String = skinPath;
				var noSwfPath:String = currentSkinPath.split(".swf")[0];
				var dirtyNum:String = currentSkinPath.split("?")[1];
				if (noSwfPath.indexOf("_light") == -1)
					currentSkinPath = noSwfPath + "_light.swf?" + dirtyNum;
				return currentSkinPath;
			}
			return skinPath;
		}


		/**
		 * creates the advertising node of features.xml based on given data
		 * @param ads	advertising data
		 * @return advertising data as XML
		 */
		private function getAdvertisingXML(adVo:AdvertizingVo):XML {
			var adData:XML =
				<advertising>
					<adSources/>
					<playerConfig>
						<notice/>
						<skip/>
						<companion>
							<elements/>
						</companion>
					</playerConfig>
					<timeline>
						<preroll/>
						<bumper/>
						<postroll/>
						<overlay/>
						<values/>
					</timeline>
				</advertising>;

			adData.@enabled = adVo.adsEnabled.toString();

			// AD SOURCES
			var xml:XML
			var att:String;
			var src:AdSourceVo;
			var attsLst:Array;
			var i:int, l:int = adVo.adSources.length;
			for (i = 0; i < l; i++) {
				xml = <source/>;
				src = adVo.adSources[i] as AdSourceVo;
				attsLst = ObjectUtil.getObjectAllKeys(src);
				for (att in attsLst) {
					if (attsLst[att] != "extra") {
						xml.attribute(attsLst[att])[0] = src[attsLst[att]];
					}
				}
				if (src == adVo.adSource) {
					// selected source
					if (src.extra != "") {
						// add extra data id any
						xml.appendChild(src.extra);
					}
					xml.@selected = "true";
				}
				adData.adSources[0].appendChild(xml);
			}

			// PLAYER CONFIG
			xml = adData.playerConfig[0];
			xml.@timeout = adVo.timeout;
			xml.@trackCuePoints = adVo.trackCuePoints;
			// notice
			xml = xml.notice[0];
			xml.@enabled = adVo.noticeEnabled;
			xml.appendChild(adVo.noticeText);
			// skip
			xml = xml.parent().skip[0];
			xml.@enabled = adVo.skipEnabled;
			xml.@label = adVo.skipText;
			// companion ads
			var customAds:Array = new Array();
			if (adVo.companions != null) {
				l = adVo.companions.length;
				var ca:CompanionAdVo;
				for (i = 0; i < l; i++) {
					ca = adVo.companions[i];
					xml = <ad/>;
					attsLst = ObjectUtil.getObjectAllKeys(ca);
					for (att in attsLst) {
						if (attsLst[att] != "dp") {
							// don't save dp (combobox.dataprovider for flash ads)
							xml.attribute(attsLst[att])[0] = ca[attsLst[att]];
						}
					}
					adData.playerConfig.companion[0].appendChild(xml);
					// new custom companion locations:
					if (ca.elementid == CUSTOM) {
						xml = <element />;
						xml.@elementid = ca.elementid + i; //UIDUtil.createUID();
						xml.@relativeTo = ca.relativeTo;
						xml.@position = ca.position;
						customAds.push(xml);
					}
				}

			}
			// normal companion locations:
			l = adVo.flashCompanionLocations.length;
			var o:Object;
			for (i = 0; i < l; i++) {
				xml = <element />;
				o = adVo.flashCompanionLocations.getItemAt(i);
				// don't take custom ads, already taken care of.
				if (o.elementid.indexOf(CUSTOM) == -1) {
					xml.@elementid = o.elementid;
					xml.@relativeTo = o.relativeTo;
					xml.@position = o.position;
					adData.playerConfig.companion.elements[0].appendChild(xml);
				}
			}
			// add the "template" custom ad
			xml = <element />;
			xml.@elementid = CUSTOM;
			xml.@relativeTo = "";
			xml.@position = "";
			adData.playerConfig.companion.elements[0].appendChild(xml);
			// ad the saved custom ads
			l = customAds.length;
			for (i = 0; i < l; i++) {
				(adData.playerConfig.companion.elements[0] as XML).appendChild(customAds[i]);
			}


			// TIMELINE
			// bumper
			adData.timeline.bumper.@enabled = adVo.bumperEnabled.toString();
			if (adVo.bumperEnabled) {
				adData.timeline.bumper[0].@entryid = adVo.bumperEntry;
				adData.timeline.bumper[0].@clickurl = adVo.bumperUrl;
			}
			// preroll
			var ipa:InPlayerAdVo = adVo.preroll;
			xml = adData.timeline.preroll[0];
			xml.@enabled = ipa.enabled;
			xml.@nads = ipa.nAds;
			xml.@frequency = ipa.frequency;
			xml.@start = ipa.start;
			xml.@url = ipa.url;
			// postroll
			ipa = adVo.postroll;
			xml = adData.timeline.postroll[0];
			xml.@enabled = ipa.enabled;
			xml.@nads = ipa.nAds;
			xml.@frequency = ipa.frequency;
			xml.@start = ipa.start;
			xml.@url = ipa.url;
			// overlay
			ipa = adVo.overlay;
			xml = adData.timeline.overlay[0];
			xml.@enabled = ipa.enabled;
			xml.@nads = ipa.nAds;
			xml.@frequency = ipa.frequency;
			xml.@start = ipa.start;
			xml.@url = ipa.url;
			// linear ad values
			adData.timeline.values = adVo.linearAdsValues;

			return adData;
		}



		/**
		 * create XML with selected style definitions
		 * @param style		vo with selected style values
		 * @return	XML with selected values
		 */
		private function getStyleXML(style:StyleVo):XML {
			var styleXml:XML = <theme />
			styleXml.@id = style.themeId;
			styleXml.@name = style.themeFriendlyName;
			styleXml.appendChild(new XML("<themeSkinPath>" + style.skinPath + "</themeSkinPath>"));
			for (var i:int = 1; i <= 5; i++) {
				styleXml.appendChild(new XML("<color" + i + ">" + style["color" + i].toString() + "</color" + i + ">"));
			}
			styleXml.appendChild(new XML("<font>" + style.fontName + "</font>"));
			return styleXml;
		}


		/**
		 * creates a list of general uivars
		 * @param templateType		template type
		 * @param template			template data
		 * @param generalUiVarsAndPlugins	features data
		 * @param wpl				widget playlist xml
		 * */
		private function getUiVarsXml(templateType:String, template:TemplateVo, generalUiVarsAndPlugins:XML, wpl:XML):XML {
			var uiVars:XML = <uiVars/>;
			if (wpl != null) {
				uiVars.appendChild(wpl.children());
			}

			var param:XML;
			// stretch behaviour: 
			param = <var></var>;
			param.@key = "video.keepAspectRatio";
			if (template.keepAspectRatio) {
				param.@value = "true";
			}
			else {
				param.@value = "false";
			}
			uiVars.appendChild(param);

			//playlist params:
			param = <var></var>;
			param.@key = "playlistAPI.autoContinue";
			param.@value = template.playlistAutoContinue.toString();
			uiVars.appendChild(param);
			param = <var></var>;
			param.@key = "imageDefaultDuration";
			param.@value = template.imageDefaultDuration.toString();
			uiVars.appendChild(param);
			param = <var></var>;

			// autoplay:

			if (templateType == "playlist")
				param.@key = "playlistAPI.autoPlay";
			else
				param.@key = "autoPlay";
			param.@value = template.autoPlay.toString();
			uiVars.appendChild(param);

			// automute:
			param = <var></var>;
			param.@key = "autoMute";
			param.@value = template.autoMute;
			uiVars.appendChild(param);

			// plugins:
			if (generalUiVarsAndPlugins) {
				for each (var uiVar:XML in generalUiVarsAndPlugins.children()) {
					uiVars.appendChild(uiVar);
				}
			}

			return uiVars;
		}



		/**
		 * @copy #_fullPlayer
		 */
		public function set fullPlayer(value:XML):void {
			_fullPlayer = value;
		}


		/**
		 * @copy #_featuresCollection
		 */
		public function set featuresCollection(value:XMLListCollection):void {
			_featuresCollection = value;
		}


		/**
		 * @private
		 */
		public function get featuresCollection():XMLListCollection {
			return _featuresCollection;
		}


		/**
		 * An xml with nodes that list static plugins that needs to be colored
		 */
		public function get colorPlugins():XML {
			return _colorPlugins;
		}


		/**
		 * @private
		 */
		public function set colorPlugins(value:XML):void {
			_colorPlugins = value;
		}




	}
}