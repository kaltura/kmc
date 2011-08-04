package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadataProfile.MetadataProfileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.content.utils.FormBuilder;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileFilter;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	import com.kaltura.vo.MetadataFieldVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	/**
	 * This command is being executed when the event MetadataProfileEvent.LIST is dispatched.
	 * @author Michal
	 *
	 */
	public class ListMetadataProfileCommand extends KalturaCommand {

		/**
		 * only if a metadata profile view contains layout with this name it will be used
		 */
		public static const KMC_LAYOUT_NAME:String = "KMC";


		/**
		 * This command requests the server for the last created metadata profile
		 * @param event the event that triggered this command
		 *
		 */
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaMetadataProfileFilter = new KalturaMetadataProfileFilter();
			filter.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
			filter.metadataObjectTypeEqual = KalturaMetadataObjectType.ENTRY;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			var listMetadataProfile:MetadataProfileList = new MetadataProfileList(filter, pager);
			listMetadataProfile.addEventListener(KalturaEvent.COMPLETE, result);
			listMetadataProfile.addEventListener(KalturaEvent.FAILED, fault);

			_model.context.kc.post(listMetadataProfile);
		}


		/**
		 * This function handles the response from the server. if a profile returned from the server then it will be
		 * saved into the model.
		 * @param data the data returned from the server
		 *
		 */
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();

			if (data.error) {
				var er:KalturaError = data.error as KalturaError;
				if (er) {
					// ignore service forbidden
					if (er.errorCode != APIErrorCode.SERVICE_FORBIDDEN) {
						Alert.show(er.errorMsg, "Error");
					}
				}
			}
			else {
				var response:KalturaMetadataProfileListResponse = data.data as KalturaMetadataProfileListResponse;
				var metadataProfiles:Array = new Array();
				var formBuilders:Array = new Array();
				for (var i:int = 0; i < response.objects.length; i++) {
					var recievedProfile:KalturaMetadataProfile = response.objects[i];
					if (recievedProfile) {
						var metadataProfile:KMCMetadataProfileVO = new KMCMetadataProfileVO();
						metadataProfile.profile = recievedProfile;
						metadataProfile.xsd = new XML(recievedProfile.xsd);
						metadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(metadataProfile.xsd);

						//set the displayed label of each label
						for each (var field:MetadataFieldVO in metadataProfile.metadataFieldVOArray) {
							var label:String = ResourceManager.getInstance().getString('customFields', field.defaultLabel);
							if (label) {
								field.displayedLabel = label;
							}
							else {
								field.displayedLabel = field.defaultLabel;
							}
						}

						//adds the profile to metadataProfiles, and its matching formBuilder to formBuilders
						metadataProfiles.push(metadataProfile);
						var fb:FormBuilder = new FormBuilder(metadataProfile);
						formBuilders.push(fb);
						var isViewExist:Boolean = false;

						if (recievedProfile.views) {
							try {
								var recievedView:XML = new XML(recievedProfile.views);
							}
							catch (e:Error) {
								//invalid view xmls
								continue;
							}
							for each (var layout:XML in recievedView.children()) {
								if (layout.@id == ListMetadataProfileCommand.KMC_LAYOUT_NAME) {
									metadataProfile.viewXML = layout;
									isViewExist = true;
									continue;
								}
							}
						}
						if (!isViewExist) {
							//if no view was retruned, or no view with "KMC" name, we will set the default uiconf XML
							if (_model.entryDetailsModel.metadataDefaultUiconfXML)
								metadataProfile.viewXML = _model.entryDetailsModel.metadataDefaultUiconfXML.copy();
							fb.buildInitialMxml();
						}
					}
				}
				_model.filterModel.metadataProfiles = new ArrayCollection(metadataProfiles);
				_model.filterModel.formBuilders = new ArrayCollection(formBuilders);
			}

		}


		/**
		 * This function will be called if the request failed
		 * @param info the info returned from the server
		 *
		 */
		override public function fault(info:Object):void {
			if (info && info.error && info.error.errorMsg && info.error.errorCode != APIErrorCode.SERVICE_FORBIDDEN) {
				Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
			}
			_model.decreaseLoadCounter();
		}
	}
}
