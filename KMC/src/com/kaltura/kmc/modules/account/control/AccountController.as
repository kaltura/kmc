package com.kaltura.kmc.modules.account.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.kmc.modules.account.command.*;
	import com.kaltura.kmc.modules.account.events.*;
	
	
	public class AccountController extends FrontController
	{
		public function AccountController()
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
			// user events
			addCommand( UserEvent.LIST_USERS, ListUsersCommand );
			
			
			// Kaltura Events
			 addCommand( ContactEvent.CONTACT_US , ContactSalesForceCommand );
			 
			
			// Partner Usage Event
			addCommand(UsageGraphEvent.USAGE_GRAPH, GetUsageGraphCommand);
			
			// Access Control Events
			addCommand(AccessControlProfileEvent.ACCOUNT_ADD_NEW_ACCESS_CONTROL_PROFILE, AddNewAccessControlProfileCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_DELETE_ACCESS_CONTROL_PROFILES, DeleteAccessControlProfilesCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_LIST_ACCESS_CONTROLS_PROFILES, ListAccessControlsCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_MARK_PROFILES, MarkAccessControlProfilesCommand);
			addCommand(AccessControlProfileEvent.ACCOUNT_UPDATE_ACCESS_CONTROL_PROFILE, UpdateAccessControlProfileCommand);
			
			// Conversion Profile Events
			addCommand(ConversionSettingsAccountEvent.ADD_NEW_CONVERSION_PROFILE, AddNewConversionProfileCommand);
			addCommand(ConversionSettingsAccountEvent.DELETE_CONVERSION_PROFILE, DeleteConversionProfileCommand);
			addCommand(ConversionSettingsAccountEvent.LIST_CONVERSION_PROFILES_AND_FLAVOR_PARAMS, ListConversionProfilesAndFlavorParamsCommand);
			addCommand(ConversionSettingsAccountEvent.LIST_CONVERSION_PROFILES, ListConversionProfilesCommand);
			addCommand(ConversionSettingsAccountEvent.LIST_FLAVOR_PARAMS, ListFlavorsParamsCommand);
			addCommand(ConversionSettingsAccountEvent.MARK_FLAVORS, MarkFlavorsCommand);
			addCommand(ConversionSettingsAccountEvent.MARK_CONVERSION_PROFILES, MarkTranscodingProfilesCommand);
			addCommand(ConversionSettingsAccountEvent.UPDATE_CONVERSION_PROFILE_CHANGES, UpdateConversionProfileCommand);
			addCommand(ConversionSettingsAccountEvent.SET_AS_DEFAULT_CONVERSION_PROFILE, SetAsDefaultConversionProfileCommand);
			
			//metadata profile events
			addCommand(MetadataProfileEvent.LIST , ListMetadataProfileCommand);
			addCommand(MetadataProfileEvent.ADD , AddMetadataProfileCommand);
			addCommand(MetadataProfileEvent.UPDATE , UpdateMetadataProfileCommand);
			addCommand(MetadataProfileEvent.SELECT , UpdateSelectedMetadataProfileCommand);
			addCommand(MetadataProfileEvent.DELETE , DeleteMetadataProfileCommand);
			//metadata field events
			addCommand(MetadataFieldEvent.ADD , AddMetadataFieldCommand);
			addCommand(MetadataFieldEvent.DELETE , DeleteMetadataFieldCommand);
			addCommand(MetadataFieldEvent.EDIT , EditMetadataFieldCommand);
			addCommand(MetadataFieldEvent.REORDER , ReorderMetadataFieldCommand );
		}
	}
}