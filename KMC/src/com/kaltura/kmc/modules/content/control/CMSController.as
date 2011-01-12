package com.kaltura.kmc.modules.content.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.events.AccessControlProfileEvent;
	import com.kaltura.kmc.modules.content.commands.*;
	import com.kaltura.kmc.modules.content.events.*;
	import com.kaltura.kmc.modules.content.events.MetadataProfileEvent;

	public class CMSController extends FrontController
	{
		public function CMSController()
		{
			initializeCommands();
		}
		
		public function initializeCommands() : void
		{
			//Search Event
			addCommand( SearchEvent.SEARCH_ENTRIES , ListEntriesCommand );	
			addCommand( SearchEvent.SEARCH_PLAYLIST , ListPlaylistCommand );
			
			//Entry Event
			addCommand( EntryEvent.GET_ENTRY , GetSingleEntryCommand );
			addCommand( EntryEvent.SET_SELECTED_ENTRY , SetSelectedEntryCommand );
			addCommand( EntryEvent.ADD_CHECKED_ENTRY , AddCheckedEntryCommand );
			addCommand( EntryEvent.REMOVE_CHECKED_ENTRY , RemoveCheckedEntryCommand   );	
			addCommand( EntryEvent.LIST_ENTRY_MODERATION , ListModerationCommand );
			addCommand( EntryEvent.GET_ALL_ENTRIES, GetAllEntriesCommand );
			addCommand( EntryEvent.ADD_PLAYLIST , AddEntryCommand );
			addCommand( EntryEvent.PREVIEW , PreviewCommand );
			addCommand( EntryEvent.GET_ENTRY_ROUGHCUTS , GetEntryRoughcutsCommand );
			//on the fly playlist event
			addCommand( SetPlaylistTypeEvent.MANUAL_PLAYLIST , SetPlaylistTypeCommand );
			addCommand( SetPlaylistTypeEvent.RULE_BASED_PLAYLIST , SetPlaylistTypeCommand );
			//execute playlist to see current entries
			addCommand( EntryEvent.GET_PLAYLIST , GetPlaylistCommand );
			addCommand( RuleBasedTypeEvent.MULTY_RULES, SetPreviewTypeCommand);
			addCommand( RuleBasedTypeEvent.ONE_RULE, SetPreviewTypeCommand);
			//execute playlist to see current entries in a rule based running
			addCommand( EntryEvent.GET_RULE_BASED_PLAYLIST , GetRuleBasedPlaylistCommand);
			addCommand( EntryEvent.GET_FLAVOR_ASSETS, ListFlavorAssetsByEntryIdCommand);
			addCommand( EntryEvent.GET_FLAVOR_ASSETS_FOR_PREVIEW, ListFlavorAssetsByEntryIdForPreviewCommand);
			
			addCommand( EntryEvent.RESET_RULE_BASED_DATA, ResetRuleBasedDataCommand);
			
			addCommand( SetCurrentListableEvent.SET_NEW_LIST_TO_MODEL, SetCurrentListableCommand);
			
			//Entries Event
			addCommand( EntriesEvent.SET_SELECTED_ENTRIES_FOR_PLAYLIST , SetSelectedEntriesForPlaylistCommand );
			addCommand( EntriesEvent.SET_SELECTED_ENTRIES , SetSelectedEntriesCommand );
			addCommand( EntriesEvent.UPDATE_ENTRIES , UpdateEntriesCommand );
			addCommand( EntriesEvent.UPDATE_PLAYLISTS ,  UpdateEntriesCommand );
			addCommand( EntriesEvent.DELETE_ENTRIES , DeleteEntriesCommand );
			//selection Event
			addCommand( SelectionEvent.SELECTION_CHANGED , SelectionCommand);
			 
		    //Window Event
			addCommand( WindowEvent.CLOSE , CloseWindowCommand );
			addCommand( WindowEvent.OPEN , OpenWindowCommand );	
			//stream
			addCommand( AddStreamEvent.ADD_STREAM , AddStreamCommand ); 	
			//uploadThumbnail
			addCommand( UploadEntryEvent.UPLOAD_THUMBNAIL, UploadThumbnailCommand);	
			
			//Moderation Event
			addCommand( ModerationsEvent.UPDATE_ENTRY_MODERATION , UpdateEntryModerationCommand );
			
			//Download Event 
			addCommand( DownloadEvent.DOWNLOAD_ENTRY , AddDownloadCommand );
			
			//Bulk Upload Event
			addCommand(BulkEvent.LIST_BULK_UPLOAD , ListBulkUplaodCommand );
			addCommand(BulkEvent.ADD_BULK_UPLOAD , AddBulkUploadCommand);
			
			//Profile Event
			addCommand(ProfileEvent.LIST_CONVERSION_PROFILE , ListConversionProfilesCommand);
			
			// flavor params
			addCommand( ConversionSettingsEvent.LIST_FLAVOR_PARAMS, ListFlavorsParamsCommand);
			
			//FilterEvent
			addCommand(FilterEvent.SET_FILTER_TO_MODEL , SetFilterToModelCommand );
			
			//Category Event
			addCommand(CategoryEvent.ADD_CATEGORY, AddCategoryCommand );
			addCommand(CategoryEvent.DELETE_CATEGORY, DeleteCategoriesCommand );
			addCommand(CategoryEvent.LIST_CATEGORIES, ListCategoriesCommand );
			addCommand(CategoryEvent.UPDATE_CATEGORY, UpdateCategoryCommand );
			
			//User Events
			addCommand(UserEvent.BAN_USER , BanUserCommand );
			
			// Access Control Events
			addCommand(AccessControlProfileEvent.ADD_NEW_ACCESS_CONTROL_PROFILE, AddNewAccessControlProfileCommand);
			addCommand(AccessControlProfileEvent.LIST_ACCESS_CONTROLS_PROFILES, ListAccessControlsCommand);
			
			// Flavor Asset Events
			addCommand(FlavorAssetEvent.CREATE_FLAVOR_ASSET, ConvertFlavorAssetCommand);
			addCommand(FlavorAssetEvent.DELETE_FLAVOR_ASSET, DeleteFlavorAssetCommand);
			addCommand(FlavorAssetEvent.DOWNLOAD_FLAVOR_ASSET, DownloadFlavorAsset);
			addCommand(FlavorAssetEvent.PREVIEW_FLAVOR_ASSET, PreviewFlavorAsset);
			
			// External Syndication Events
			addCommand(ExternalSyndicationEvent.ADD_NEW_EXTERNAL_SYNDICATION, AddNewExternalSyndicationCommand);
			addCommand(ExternalSyndicationEvent.DELETE_EXTERNAL_SYNDICATION, DeleteExternalSyndicationCommand);
			addCommand(ExternalSyndicationEvent.LIST_EXTERNAL_SYNDICATIONS, ListExternalSyndicationsCommand);
			addCommand(ExternalSyndicationEvent.MARK_EXTERNAL_SYNDICATION, MarkExternalSyndicationCommand);
			addCommand(ExternalSyndicationEvent.UPDATE_EXTERNAL_SYNDICATION_CHANGES, UpdateExternalSyndicationCommand);
			addCommand(ExternalSyndicationEvent.SET_SYNDICATION_FEED_FILTER_ORDER, ChangeSyndicationFeedsFilterOrderCommand);
			
			// UI CONF
			addCommand(UIConfEvent.LIST_UI_CONFS, ListUIConfCommand);
			
			// Partner Events
			addCommand( PartnerEvent.GET_PARTNER_INFO  , GetPartnerInfoCommand );
			
			//metadata Events
			addCommand(MetadataProfileEvent.LIST, ListMetadataProfileCommand);
			addCommand(MetadataDataEvent.LIST, ListMetadataDataCommand);
			
			//distribution
			addCommand(DistributionProfileEvent.LIST, ListDistributionProfilesCommand);
			//addCommand(DistributionProfileEvent.UPDATE, UpdateDistributionProfilesCommand);
			addCommand(EntryDistributionEvent.LIST, ListEntryDistributionCommand);
			addCommand(EntryDistributionEvent.UPDATE_LIST, UpdateEntryDistributionsCommand);
			addCommand(EntryDistributionEvent.SUBMIT, SubmitEntryDistributionCommand);
			addCommand(EntryDistributionEvent.UPDATE, UpdateEntryDistributionCommand);
			addCommand(EntryDistributionEvent.RETRY, RetryEntryDistributionCommand);
			
			//thumb asset
			addCommand(ThumbnailAssetEvent.LIST, ListThumbnailAssetCommand);
			addCommand(ThumbnailAssetEvent.DELETE, DeleteThumbnailAssetCommand);
			addCommand(ThumbnailAssetEvent.SET_AS_DEFAULT, SetAsDefaultThumbnailAsset);
			addCommand(UploadFromImageThumbAssetEvent.ADD_FROM_IMAGE, AddFromImageThumbnailAssetCommand);
			addCommand(GenerateThumbAssetEvent.GENERATE, GenerateThumbAssetCommand);
			addCommand(ThumbnailAssetEvent.GET, GetThumbAssetCommand);
			
			//roles and permissions stuff
			addCommand(ChangeModelEvent.SET_EMBED_STATUS, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_CUSTOM_METADATA, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_DISTRIBUTION, ChangeModelValueCommand);
		}
	}
}

