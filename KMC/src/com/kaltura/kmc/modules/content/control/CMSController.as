package com.kaltura.kmc.modules.content.control {
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.edw.control.commands.*;
	import com.kaltura.edw.control.commands.customData.*;
	import com.kaltura.edw.control.events.*;
	import com.kaltura.kmc.modules.content.commands.*;
	import com.kaltura.kmc.modules.content.commands.bulk.*;
	import com.kaltura.kmc.modules.content.commands.cat.*;
	import com.kaltura.kmc.modules.content.commands.dropfolder.*;
	import com.kaltura.kmc.modules.content.events.*;

	public class CMSController extends FrontController {
		public function CMSController() {
			initializeCommands();
		}


		public function initializeCommands():void {
			
			//Search Event
			addCommand(KMCSearchEvent.DO_SEARCH_ENTRIES, DoSearchSequenceCommand);
			addCommand(KMCSearchEvent.SEARCH_PLAYLIST, ListPlaylistCommand);

			//Entry Event
			addCommand(KMCEntryEvent.LIST_ENTRY_MODERATION, ListModerationCommand);
			addCommand(KMCEntryEvent.ADD_PLAYLIST, AddEntryCommand);
			addCommand(KMCEntryEvent.GET_PLAYLIST, GetPlaylistCommand);
			addCommand(KMCEntryEvent.PREVIEW, PreviewCommand);

			//on the fly playlist event
			addCommand(SetPlaylistTypeEvent.MANUAL_PLAYLIST, SetPlaylistTypeCommand);
			addCommand(SetPlaylistTypeEvent.RULE_BASED_PLAYLIST, SetPlaylistTypeCommand);
			addCommand(SetPlaylistTypeEvent.NONE_PLAYLIST, SetPlaylistTypeCommand);
			//execute playlist to see current entries
			addCommand(RuleBasedTypeEvent.MULTY_RULES, SetPreviewTypeCommand);
			addCommand(RuleBasedTypeEvent.ONE_RULE, SetPreviewTypeCommand);
			//execute playlist to see current entries in a rule based running
			addCommand(KMCEntryEvent.GET_RULE_BASED_PLAYLIST, GetRuleBasedPlaylistCommand);
			addCommand(KMCEntryEvent.GET_FLAVOR_ASSETS_FOR_PREVIEW, ListFlavorAssetsByEntryIdForPreviewCommand);

			addCommand(KMCEntryEvent.RESET_RULE_BASED_DATA, ResetRuleBasedDataCommand);

			addCommand(SetListableEvent.SET_NEW_LIST_TO_MODEL, SetCurrentListableCommand);

			//Entries Event
			addCommand(EntriesEvent.SET_SELECTED_ENTRIES_FOR_PLAYLIST, SetSelectedEntriesForPlaylistCommand);
			addCommand(EntriesEvent.SET_SELECTED_ENTRIES, SetSelectedEntriesCommand);
			addCommand(EntriesEvent.UPDATE_ENTRIES, UpdateEntriesCommand);
			addCommand(EntriesEvent.UPDATE_PLAYLISTS, UpdateEntriesCommand);
			addCommand(EntriesEvent.DELETE_ENTRIES, DeleteEntriesCommand);
			addCommand(EntriesEvent.SET_ENTRIES_OWNER, SetEntriesOwnerCommand);
			addCommand(EntriesEvent.GET_SELECTED_ENTRIES_CATEGORIES, ListEntriesCategoriesCommand);
			addCommand(EntriesEvent.REMOVE_CATEGORIES_ENTRIES, RemoveCategoriesEntriesCommand);
			addCommand(EntriesEvent.ADD_CATEGORIES_ENTRIES, AddCategoriesEntriesCommand);
			addCommand(EntriesEvent.ADD_ENTRY, AddMediaEntryCommand);

			//selection Event
			addCommand(SelectionEvent.ENTRIES_SELECTION_CHANGED, SelectionCommand);
			addCommand(SelectionEvent.CATEGORIES_SELECTION_CHANGED, SelectionCommand);

			//Window Event
			addCommand(WindowEvent.CLOSE, CloseWindowCommand);
			addCommand(WindowEvent.OPEN, OpenWindowCommand);
			//stream
			addCommand(AddStreamEvent.ADD_STREAM, AddStreamCommand);

			//Moderation Event
			addCommand(ModerationsEvent.UPDATE_ENTRY_MODERATION, UpdateEntryModerationCommand);

			//Download Event 
			addCommand(DownloadEvent.DOWNLOAD_ENTRY, AddDownloadCommand);

			//Bulk Upload Event
			addCommand(BulkEvent.LIST_BULK_UPLOAD, ListBulkUploadCommand);
			addCommand(BulkEvent.ADD_BULK_UPLOAD, AddBulkUploadCommand);
			addCommand(BulkEvent.DELETE_BULK_UPLOAD, DeleteBulkUploadCommand);

			// flavor params
			addCommand(ConversionSettingsEvent.LIST_FLAVOR_PARAMS, ListFlavorsParamsCommand);

			//FilterEvent
			addCommand(KMCFilterEvent.SET_FILTER_TO_MODEL, SetFilterToModelCommand);

			//User Events
			addCommand(UserEvent.BAN_USER, BanUserCommand);

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
			addCommand(PartnerEvent.GET_PARTNER_INFO, GetPartnerInfoCommand);

			//roles and permissions stuff
			addCommand(ChangeModelEvent.SET_SINGLE_ENTRY_EMBED_STATUS, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_PLAYLIST_EMBED_STATUS, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_CUSTOM_METADATA, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_UPDATE_CUSTOM_DATA, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_DISTRIBUTION, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_REMOTE_STORAGE, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_ENABLE_THUMB_RESIZE, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_ENABLE_THUMBS_LIST, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_LOTS_OF_CATEGORIES_FLAG, ChangeModelValueCommand);
			addCommand(ChangeModelEvent.SET_CONFIRM_MODERATION, ChangeModelValueCommand);


			// drop folder stuff
			addCommand(KMCDropFolderEvent.LIST_FOLDERS_AND_FILES, ListDropFoldersAndFiles);
			addCommand(KMCDropFolderEvent.LIST_ALL_FILES, ListDropFoldersFilesCommand);
			addCommand(KMCDropFolderEvent.DELETE_FILES, DeleteDropFolderFilesCommand);

			// things that come from the EDW
			addCommand(UpdateEntryEvent.UPDATE_ENTRY_IN_LIST, UpdateEntryInListCommand);
			
			
			// categories
			addCommand(CategoryEvent.LIST_CATEGORIES, ListCategoriesCommand);
			addCommand(CategoryEvent.DELETE_CATEGORIES, DeleteCategoriesCommand);
			addCommand(CategoryEvent.MOVE_CATEGORIES, ReparentCategoriesCommand);
			addCommand(CategoryEvent.GET_SUB_CATEGORIES, GetSubCategoriesCommand);
			addCommand(CategoryEvent.RESET_SUB_CATEGORIES, GetSubCategoriesCommand);
			addCommand(CategoryEvent.UPDATE_SUB_CATEGORIES, UpdateSubCategoriesCommand);
			addCommand(CategoryEvent.LIST_METADATA_PROFILES, ListCategoryMetadataProfileCommand);
			addCommand(CategoryEvent.LIST_METADATA_INFO, ListCategoryMetadataDataCommand);
			addCommand(CategoryEvent.UPDATE_CATEGORY, UpdateCategoryCommand);
			addCommand(CategoryEvent.ADD_CATEGORY, AddCategoryCommand);
			addCommand(CategoryEvent.UPDATE_CATEGORY_METADATA_DATA, UpdateCategoryMetadataDataCommand);
			addCommand(CategoryEvent.GET_PARENT_CATEGORY, ManageParentCategoryCommand);
			addCommand(CategoryEvent.CLEAR_PARENT_CATEGORY, ManageParentCategoryCommand);
			addCommand(CategoryEvent.SET_SELECTED_CATEGORY, SetSelectedCategoryCommand);
			addCommand(CategoryEvent.LIST_CATEGORY_USERS, ListCategoryUsersCommand);
			addCommand(CategoryEvent.INHERIT_USERS_FROM_PARENT, inheritUsersCommand);
			addCommand(CategoryEvent.ADD_CATEGORY_USERS, addUsersCommand);
			
			// category users
			addCommand(CategoryUserEvent.ACTIVATE_CATEGORY_USER, ToggleCategoryUserStatusCommand);
			addCommand(CategoryUserEvent.DEACTIVATE_CATEGORY_USER, ToggleCategoryUserStatusCommand);
			addCommand(CategoryUserEvent.DELETE_CATEGORY_USERS, DeleteCategoryUserCommand);
			addCommand(CategoryUserEvent.SET_CATEGORY_USERS_AUTO_UPDATE, SetCategoryUserUpdateMethod);
			addCommand(CategoryUserEvent.SET_CATEGORY_USERS_MANUAL_UPDATE, SetCategoryUserUpdateMethod);
			addCommand(CategoryUserEvent.SET_CATEGORY_USERS_PERMISSION_LEVEL, SetCategoryUsersPermLevel);
			addCommand(CategoryUserEvent.SET_SELECTED_CATEGORY_USERS, SetSelectedCategoryUsersCommand);
			
		}
	}
}

