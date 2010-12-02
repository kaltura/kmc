package com.kaltura.kmc.modules.account.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.kmc.modules.account.command.*;
	import com.kaltura.kmc.modules.account.events.*;
	
	
	public class KMCController extends FrontController
	{
		public function KMCController()
		{
			initializeCommands();
		}
		
		
		/**
		 * add all commands 
		 */		
		public function initializeCommands() : void
		{
			// Partner Events
			addCommand( PartnerEvent.GET_PARTNER_INFO , GetPartnerInfoCommand );
			addCommand( PartnerEvent.UPDATE_PARTNER , UpdatePartnerCommand );
			
			// Admin Events
			addCommand( AdminEvent.UPDATE_ADMIN_PASSWORD , UpdateAdminPasswordCommand );
			
			// Package Events
			addCommand( PackageEvent.LIST_PARTNER_PACKAGE , ListPartnerPackagesCommand );
			addCommand( PackageEvent.PURCHASE_PARTNER_PACKAGE ,PurchasePackageCommand);
			
			// Kaltura Events
			 addCommand( ContactEvent.CONTACT_US , ContactSalesForceCommand );
			 
			// Modal Window Events
			addCommand( ModalWindowEvent.OPEN_PAYPAL_WINDOW , TogglePayPalWindowCommand );
			
			// Partner Usage Event
			addCommand(UsageGraphEvent.USAGE_GRAPH, GetUsageGraphCommand);
			
			// Access Control Events
			addCommand(AccessControlProfileEvent.ACCOUNT_ADD_NEW_ACCESS_CONTROL_PROFILE, AddNewAccessControlProfileCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_DELETE_ACCESS_CONTROL_PROFILES, DeleteAccessControlProfilesCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_LIST_ACCESS_CONTROLS_PROFILES, ListAccessControlsCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_MARK_PROFILES, MarkAccessControlProfilesCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_UPDATE_ACCESS_CONTROL_PROFILE, UpdateAccessControlProfileCommand);
			
		/* 	// External Syndication Events
			addCommand(ExternalSyndicationEvent.ADD_NEW_EXTERNAL_SYNDICATION, AddNewExternalSyndicationCommand);
			addCommand(ExternalSyndicationEvent.DELETE_EXTERNAL_SYNDICATION, DeleteExternalSyndicationCommand);
			addCommand(ExternalSyndicationEvent.GET_ALL_EXTERNAL_SYNDICATIONS, GetAllExternalSyndicationsCommand);
			addCommand(ExternalSyndicationEvent.MARK_EXTERNAL_SYNDICATION, MarkExternalSyndicationCommand);
			addCommand(ExternalSyndicationEvent.SAVE_EXTERNAL_SYNDICATION_CHANGES, SaveExternalSyndicationCommand); */
			
			
			// Conversion Profile Events
			addCommand(ConversionSettingsEvent.ADD_NEW_CONVERSION_PROFILE, AddNewConversionProfileCommand);
			addCommand(ConversionSettingsEvent.DELETE_CONVERSION_PROFILE, DeleteConversionProfileCommand);
			addCommand(ConversionSettingsEvent.LIST_CONVERSION_PROFILES_AND_FLAVOR_PARAMS, ListConversionProfilesAndFlavorParamsCommand);
			addCommand(ConversionSettingsEvent.LIST_CONVERSION_PROFILES, ListConversionProfilesCommand);
			addCommand(ConversionSettingsEvent.LIST_FLAVOR_PARAMS, ListFlavorsParamsCommand);
			addCommand(ConversionSettingsEvent.MARK_FLAVORS, MarkFlavorsCommand);
			addCommand(ConversionSettingsEvent.MARK_CONVERSION_PROFILES, MarkTranscodingProfilesCommand);
			addCommand(ConversionSettingsEvent.UPDATE_CONVERSION_PROFILE_CHANGES, UpdateConversionProfileCommand);
			
			//metadata profile events
			addCommand(MetadataProfileEvent.LIST , ListMetadataProfileCommand);
			addCommand(MetadataProfileEvent.ADD , AddMetadataProfileCommand);
			addCommand(MetadataProfileEvent.UPDATE , UpdateMetadataProfileCommand);
			//metadata field events
			addCommand(MetadataFieldEvent.ADD , AddMetadataFieldCommand);
			addCommand(MetadataFieldEvent.DELETE , DeleteMetadataFieldCommand);
			addCommand(MetadataFieldEvent.EDIT , EditMetadataFieldCommand);
			addCommand(MetadataFieldEvent.REORDER , ReorderMetadataFieldCommand );
		}
	}
}