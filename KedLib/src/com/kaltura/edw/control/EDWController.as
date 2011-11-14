package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.*;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.kmvc.control.KMvCController;

	public class EDWController extends KMvCController {
		
		public function EDWController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			// model event
//			addCommand(ModelEvent.DUPLICATE_ENTRY_DETAILS_MODEL, DuplicateEntryDetailsModelCommand);
			
			
			//Search Event
//			addCommand(SearchEvent.SEARCH_ENTRIES, ListEntriesCommand);
//			addCommand(SearchEvent.SEARCH_PLAYLIST, ListPlaylistCommand);
			
			//Entry Event
//			addCommand(KedEntryEvent.GET_ENTRY_AND_DRILLDOWN, GetSingleEntryCommand);
//			addCommand(KedEntryEvent.GET_REPLACEMENT_ENTRY, GetSingleEntryCommand);
//			addCommand(KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS, GetSingleEntryCommand);
			addCommand(KedEntryEvent.DELETE_ENTRY, DeleteBaseEntryCommand);
			addCommand(KedEntryEvent.SET_SELECTED_ENTRY, SetSelectedEntryCommand);
//			addCommand(EntryEvent.LIST_ENTRY_MODERATION, ListModerationCommand);
//			addCommand(EntryEvent.ADD_PLAYLIST, AddEntryCommand);
//			addCommand(EntryEvent.PREVIEW, PreviewCommand);
//			addCommand(KedEntryEvent.GET_ALL_ENTRIES, GetAllEntriesCommand);
//			addCommand(KedEntryEvent.GET_ENTRY_ROUGHCUTS, GetEntryRoughcutsCommand);
			
			
			addCommand(KedEntryEvent.UPDATE_SINGLE_ENTRY, UpdateSingleEntry);
			
			//on the fly playlist event
//			addCommand(SetPlaylistTypeEvent.MANUAL_PLAYLIST, SetPlaylistTypeCommand);
//			addCommand(SetPlaylistTypeEvent.RULE_BASED_PLAYLIST, SetPlaylistTypeCommand);
//			addCommand(SetPlaylistTypeEvent.NONE_PLAYLIST, SetPlaylistTypeCommand);
			
//			addCommand(KedEntryEvent.GET_PLAYLIST, GetPlaylistCommand);
//			addCommand(KedEntryEvent.GET_FLAVOR_ASSETS, ListFlavorAssetsByEntryIdCommand);
			addCommand(KedEntryEvent.LIST_ENTRIES_BY_REFID, ListEntriesByRefidCommand);
			
			//Entries Event
//			addCommand(EntriesEvent.SET_SELECTED_ENTRIES_FOR_PLAYLIST, SetSelectedEntriesForPlaylistCommand);
//			addCommand(EntriesEvent.SET_SELECTED_ENTRIES, SetSelectedEntriesCommand);
//			addCommand(EntriesEvent.UPDATE_ENTRIES, UpdateEntriesCommand);
//			addCommand(EntriesEvent.UPDATE_PLAYLISTS, UpdateEntriesCommand);
//			addCommand(EntriesEvent.DELETE_ENTRIES, DeleteEntriesCommand);
			//media Event
//			addCommand(MediaEvent.ADD_ENTRY, AddMediaEntryCommand);
//			addCommand(MediaEvent.UPDATE_MEDIA, UpdateMediaCommand);
//			addCommand(MediaEvent.UPDATE_SINGLE_FLAVOR, UpdateFlavorCommand);
//			addCommand(MediaEvent.ADD_SINGLE_FLAVOR, AddFlavorCommand);
//			addCommand(MediaEvent.APPROVE_REPLACEMENT, ApproveMediaEntryReplacementCommand);
//			addCommand(MediaEvent.CANCEL_REPLACEMENT, CancelMediaEntryReplacementCommand);
			
			//selection Event
//			addCommand(SelectionEvent.SELECTION_CHANGED, SelectionCommand);
			
			//uploadThumbnail
//			addCommand(UploadEntryEvent.UPLOAD_THUMBNAIL, UploadThumbnailCommand);
			
			//Profile Event
//			addCommand(ProfileEvent.LIST_CONVERSION_PROFILE, ListConversionProfilesCommand);
//			addCommand(ProfileEvent.LIST_CONVERSION_PROFILES_AND_FLAVOR_PARAMS, ListConversionProfilesAndFlavorParams);
//			addCommand(ProfileEvent.LIST_STORAGE_PROFILES, ListStorageProfilesCommand);
			
			// Load Events
//			addCommand(LoadEvent.LOAD_FILTER_DATA, LoadFilterDataCommand);
//			addCommand(LoadEvent.LOAD_ENTRY_DATA, LoadEntryDrilldownDataCommand);		// not used at all?
			
			//Category Event
//			addCommand(CategoryEvent.ADD_CATEGORY, AddCategoryCommand);
//			addCommand(CategoryEvent.DELETE_CATEGORY, DeleteCategoriesCommand);
//			addCommand(CategoryEvent.LIST_CATEGORIES, ListCategoriesCommand);
//			addCommand(CategoryEvent.UPDATE_CATEGORY, UpdateCategoryCommand);
			
			// Access Control Events
//			addCommand(AccessControlProfileEvent.ADD_NEW_ACCESS_CONTROL_PROFILE, AddNewAccessControlProfileCommand);
//			addCommand(AccessControlProfileEvent.LIST_ACCESS_CONTROLS_PROFILES, ListAccessControlsCommand);
			
			// Flavor Asset Events
//			addCommand(FlavorAssetEvent.CREATE_FLAVOR_ASSET, ConvertFlavorAssetCommand);
//			addCommand(FlavorAssetEvent.DELETE_FLAVOR_ASSET, DeleteFlavorAssetCommand);
//			addCommand(FlavorAssetEvent.DOWNLOAD_FLAVOR_ASSET, DownloadFlavorAsset);
//			addCommand(FlavorAssetEvent.PREVIEW_FLAVOR_ASSET, PreviewFlavorAsset);
			
			// UI CONF
//			addCommand(GeneralUiconfEvent.GET_METADATA_UICONF, GetMetadataUIConfCommand);
			
			//metadata Events
//			addCommand(MetadataProfileEvent.LIST, ListMetadataProfileCommand);
//			addCommand(MetadataProfileEvent.GET, GetMetadataProfileCommand);
//			addCommand(MetadataDataEvent.LIST, ListMetadataDataCommand);
			
			//distribution
//			addCommand(DistributionProfileEvent.LIST, ListDistributionProfilesCommand);	// not used?
//			addCommand(EntryDistributionEvent.LIST, ListEntryDistributionCommand);
//			addCommand(EntryDistributionEvent.UPDATE_LIST, UpdateEntryDistributionsCommand);
//			addCommand(EntryDistributionEvent.SUBMIT, SubmitEntryDistributionCommand);
//			addCommand(EntryDistributionEvent.SUBMIT_UPDATE, SubmitUpdateEntryDistributionCommand);
//			addCommand(EntryDistributionEvent.UPDATE, UpdateEntryDistributionCommand);
//			addCommand(EntryDistributionEvent.RETRY, RetryEntryDistributionCommand);
//			addCommand(EntryDistributionEvent.GET_SENT_DATA, GetSentDataEntryDistributionCommand);
//			addCommand(EntryDistributionEvent.GET_RETURNED_DATA, GetReturnedDataEntryDistributionCommand);
			
			//thumb asset
//			addCommand(ThumbnailAssetEvent.LIST, ListThumbnailAssetCommand);
//			addCommand(ThumbnailAssetEvent.DELETE, DeleteThumbnailAssetCommand);
//			addCommand(ThumbnailAssetEvent.SET_AS_DEFAULT, SetAsDefaultThumbnailAsset);
//			addCommand(UploadFromImageThumbAssetEvent.ADD_FROM_IMAGE, AddFromImageThumbnailAssetCommand);
//			addCommand(GenerateThumbAssetEvent.GENERATE, GenerateThumbAssetCommand);
//			addCommand(ThumbnailAssetEvent.GET, GetThumbAssetCommand);	// not used?
			
			// drop folder stuff
//			addCommand(DropFolderEvent.LIST_FOLDERS_AND_FILES, 	ListDropFoldersAndFiles);	// dropFolders panel
//			addCommand(DropFolderFileEvent.LIST_ALL, 			ListDropFoldersFilesCommand);	// dropFolders panel
//			addCommand(DropFolderFileEvent.DELETE_FILES, 		DeleteDropFolderFilesCommand);	// dropFolders panel
			
//			addCommand(DropFolderEvent.LIST_FOLDERS, ListDropFolders);	// entry flavors
//			addCommand(DropFolderEvent.SET_SELECTED_FOLDER, SetSelectedFolder);	// matchFromDF win
//			addCommand(DropFolderFileEvent.RESET_DROP_FOLDERS_AND_FILES, ResetDropFoldersAndFiles); // matchFromDF win
//			addCommand(DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_HIERCH, ListDropFoldersFilesCommand);	// matchFromDF win
//			addCommand(DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_FLAT, ListDropFoldersFilesCommand);	// matchFromDF win
			
			//upload token
//			addCommand(UploadTokenEvent.UPLOAD_TOKEN, UploadTokenCommand);
			
			//captions
//			addCommand(CaptionsEvent.LIST_CAPTIONS, ListCaptionsCommand);
//			addCommand(CaptionsEvent.SAVE_ALL, SaveCaptionsCommand);
//			addCommand(CaptionsEvent.UPDATE_CAPTION, GetCaptionDownloadUrl);
			
			// cuepoints
//			addCommand(CuePointEvent.COUNT_CUEPOINTS, CountCuePoints);
//			addCommand(CuePointEvent.RESET_CUEPOINTS_COUNT, ResetCuePointsCount);
//			addCommand(CuePointEvent.DOWNLOAD_CUEPOINTS, DownloadCuePoints);
//			addCommand(CuePointEvent.UPLOAD_CUEPOINTS, UploadCuePoints);
			
			//related files
//			addCommand(RelatedFileEvent.LIST_RELATED_FILES, ListRelatedFilesCommand);
//			addCommand(RelatedFileEvent.SAVE_ALL_RELATED, SaveRelatedFilesCommand);
//			addCommand(RelatedFileEvent.UPDATE_RELATED_FILE, UpdateRelatedFileCommand);
			
//			// clips
//			addCommand(ClipEvent.GET_ENTRY_CLIPS, GetEntryClipsCommand);
//			addCommand(ClipEvent.RESET_MODEL_ENTRY_CLIPS, ResetEntryClipsCommand);
			
			
		}
	}
}