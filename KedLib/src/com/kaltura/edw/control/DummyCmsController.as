package com.kaltura.edw.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.edw.control.commands.*;
	import com.kaltura.edw.control.commands.captions.*;
	import com.kaltura.edw.control.commands.cat.*;
	import com.kaltura.edw.control.commands.clips.*;
	import com.kaltura.edw.control.commands.cuepoints.*;
	import com.kaltura.edw.control.commands.customData.*;
	import com.kaltura.edw.control.commands.dist.*;
	import com.kaltura.edw.control.commands.dropFolder.*;
	import com.kaltura.edw.control.commands.flavor.*;
	import com.kaltura.edw.control.commands.relatedFiles.*;
	import com.kaltura.edw.control.commands.thumb.*;
	import com.kaltura.edw.control.events.*;
	import com.kaltura.events.AccessControlProfileEvent;

	public class DummyCmsController extends FrontController{
		
		public function DummyCmsController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			// model event
			addCommand(ModelEvent.DUPLICATE_ENTRY_DETAILS_MODEL, DuplicateEntryDetailsModelCommand);
			
			
			//Search Event
			addCommand(SearchEvent.SEARCH_ENTRIES, ListEntriesCommand);
//			addCommand(SearchEvent.SEARCH_PLAYLIST, ListPlaylistCommand);
			
			//Entry Event
			addCommand(EntryEvent.GET_ENTRY_AND_DRILLDOWN, GetSingleEntryCommand);
			addCommand(EntryEvent.GET_REPLACEMENT_ENTRY, GetSingleEntryCommand);
			addCommand(EntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS, GetSingleEntryCommand);
			addCommand(EntryEvent.DELETE_ENTRY, DeleteBaseEntryCommand);
			addCommand(EntryEvent.SET_SELECTED_ENTRY, SetSelectedEntryCommand);
			addCommand(EntryEvent.ADD_CHECKED_ENTRY, AddCheckedEntryCommand);
			addCommand(EntryEvent.REMOVE_CHECKED_ENTRY, RemoveCheckedEntryCommand);
//			addCommand(EntryEvent.LIST_ENTRY_MODERATION, ListModerationCommand);
			addCommand(EntryEvent.GET_ALL_ENTRIES, GetAllEntriesCommand);
			addCommand(EntryEvent.ADD_PLAYLIST, AddEntryCommand);
			addCommand(EntryEvent.PREVIEW, PreviewCommand);
			addCommand(EntryEvent.GET_ENTRY_ROUGHCUTS, GetEntryRoughcutsCommand);
			addCommand(EntryEvent.UPDATE_SINGLE_ENTRY, UpdateSingleEntry);
			
			//on the fly playlist event
			addCommand(SetPlaylistTypeEvent.MANUAL_PLAYLIST, SetPlaylistTypeCommand);
			addCommand(SetPlaylistTypeEvent.RULE_BASED_PLAYLIST, SetPlaylistTypeCommand);
			addCommand(SetPlaylistTypeEvent.NONE_PLAYLIST, SetPlaylistTypeCommand);
			
			addCommand(EntryEvent.GET_PLAYLIST, GetPlaylistCommand);
			addCommand(EntryEvent.GET_FLAVOR_ASSETS, ListFlavorAssetsByEntryIdCommand);
			addCommand(EntryEvent.LIST_ENTRIES_BY_REFID, ListEntriesByRefidCommand);
			addCommand(SetRefreshRequiredEvent.SET_REFRESH_REQUIRED, SetRefreshRequiredCommand);
			
			//Entries Event
//			addCommand(EntriesEvent.SET_SELECTED_ENTRIES_FOR_PLAYLIST, SetSelectedEntriesForPlaylistCommand);
//			addCommand(EntriesEvent.SET_SELECTED_ENTRIES, SetSelectedEntriesCommand);
			addCommand(EntriesEvent.UPDATE_ENTRIES, UpdateEntriesCommand);
			addCommand(EntriesEvent.UPDATE_PLAYLISTS, UpdateEntriesCommand);
//			addCommand(EntriesEvent.DELETE_ENTRIES, DeleteEntriesCommand);
			//media Event
//			addCommand(MediaEvent.ADD_ENTRY, AddMediaEntryCommand);
			addCommand(MediaEvent.UPDATE_MEDIA, UpdateMediaCommand);
			addCommand(MediaEvent.UPDATE_SINGLE_FLAVOR, UpdateFlavorCommand);
			addCommand(MediaEvent.ADD_SINGLE_FLAVOR, AddFlavorCommand);
			addCommand(MediaEvent.APPROVE_REPLACEMENT, ApproveMediaEntryReplacementCommand);
			addCommand(MediaEvent.CANCEL_REPLACEMENT, CancelMediaEntryReplacementCommand);
			
			//selection Event
			addCommand(SelectionEvent.SELECTION_CHANGED, SelectionCommand);
			
			//Window Event
			addCommand(WindowEvent.CLOSE, CloseWindowCommand);
			addCommand(WindowEvent.OPEN, OpenWindowCommand);
			//uploadThumbnail
//			addCommand(UploadEntryEvent.UPLOAD_THUMBNAIL, UploadThumbnailCommand);
			
			//Profile Event
			addCommand(ProfileEvent.LIST_CONVERSION_PROFILE, ListConversionProfilesCommand);
			addCommand(ProfileEvent.LIST_CONVERSION_PROFILES_AND_FLAVOR_PARAMS, ListConversionProfilesAndFlavorParams);
			addCommand(ProfileEvent.LIST_STORAGE_PROFILES, ListStorageProfilesCommand);
			
			// Load Events
			addCommand(LoadEvent.LOAD_FILTER_DATA, LoadFilterDataCommand);
			addCommand(LoadEvent.LOAD_ENTRY_DATA, LoadEntryDrilldownDataCommand);
			
			//Category Event
			addCommand(CategoryEvent.ADD_CATEGORY, AddCategoryCommand);
			addCommand(CategoryEvent.DELETE_CATEGORY, DeleteCategoriesCommand);
			addCommand(CategoryEvent.LIST_CATEGORIES, ListCategoriesCommand);
			addCommand(CategoryEvent.UPDATE_CATEGORY, UpdateCategoryCommand);
			
			// Access Control Events
			addCommand(AccessControlProfileEvent.ADD_NEW_ACCESS_CONTROL_PROFILE, AddNewAccessControlProfileCommand);
			addCommand(AccessControlProfileEvent.LIST_ACCESS_CONTROLS_PROFILES, ListAccessControlsCommand);
			
			// Flavor Asset Events
			addCommand(FlavorAssetEvent.CREATE_FLAVOR_ASSET, ConvertFlavorAssetCommand);
			addCommand(FlavorAssetEvent.DELETE_FLAVOR_ASSET, DeleteFlavorAssetCommand);
			addCommand(FlavorAssetEvent.DOWNLOAD_FLAVOR_ASSET, DownloadFlavorAsset);
			addCommand(FlavorAssetEvent.PREVIEW_FLAVOR_ASSET, PreviewFlavorAsset);
			
			// UI CONF
			addCommand(GeneralUiconfEvent.GET_METADATA_UICONF, GetMetadataUIConfCommand);
			
			//metadata Events
			addCommand(MetadataProfileEvent.LIST, ListMetadataProfileCommand);
			addCommand(MetadataProfileEvent.GET, GetMetadataProfileCommand);
			addCommand(MetadataDataEvent.LIST, ListMetadataDataCommand);
			
			//distribution
			addCommand(DistributionProfileEvent.LIST, ListDistributionProfilesCommand);
			addCommand(EntryDistributionEvent.LIST, ListEntryDistributionCommand);
			addCommand(EntryDistributionEvent.UPDATE_LIST, UpdateEntryDistributionsCommand);
			addCommand(EntryDistributionEvent.SUBMIT, SubmitEntryDistributionCommand);
			addCommand(EntryDistributionEvent.SUBMIT_UPDATE, SubmitUpdateEntryDistributionCommand);
			addCommand(EntryDistributionEvent.UPDATE, UpdateEntryDistributionCommand);
			addCommand(EntryDistributionEvent.RETRY, RetryEntryDistributionCommand);
			addCommand(EntryDistributionEvent.GET_SENT_DATA, GetSentDataEntryDistributionCommand);
			addCommand(EntryDistributionEvent.GET_RETURNED_DATA, GetReturnedDataEntryDistributionCommand);
			
			//thumb asset
			addCommand(ThumbnailAssetEvent.LIST, ListThumbnailAssetCommand);
			addCommand(ThumbnailAssetEvent.DELETE, DeleteThumbnailAssetCommand);
			addCommand(ThumbnailAssetEvent.SET_AS_DEFAULT, SetAsDefaultThumbnailAsset);
			addCommand(UploadFromImageThumbAssetEvent.ADD_FROM_IMAGE, AddFromImageThumbnailAssetCommand);
			addCommand(GenerateThumbAssetEvent.GENERATE, GenerateThumbAssetCommand);
			addCommand(ThumbnailAssetEvent.GET, GetThumbAssetCommand);
			
			// drop folder stuff
			addCommand(DropFolderEvent.LIST_FOLDERS, ListDropFolders);
			addCommand(DropFolderEvent.LIST_FOLDERS_AND_FILES, ListDropFoldersAndFiles);
			addCommand(DropFolderEvent.SET_SELECTED_FOLDER, SetSelectedFolder);
			addCommand(DropFolderFileEvent.RESET_DROP_FOLDERS_AND_FILES, ResetDropFoldersAndFiles);
			addCommand(DropFolderFileEvent.LIST_ALL, ListDropFoldersFilesCommand);
			addCommand(DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_HIERCH, ListDropFoldersFilesCommand);
			addCommand(DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_FLAT, ListDropFoldersFilesCommand);
			addCommand(DropFolderFileEvent.DELETE_FILES, DeleteDropFolderFilesCommand);
			
			//upload token
			addCommand(UploadTokenEvent.UPLOAD_TOKEN, UploadTokenCommand);
			
			//captions
			addCommand(CaptionsEvent.LIST_CAPTIONS, ListCaptionsCommand);
			addCommand(CaptionsEvent.SAVE_ALL, SaveCaptionsCommand);
			addCommand(CaptionsEvent.UPDATE_CAPTION, GetCaptionDownloadUrl);
			
			// cuepoints
			addCommand(CuePointEvent.COUNT_CUEPOINTS, CountCuePoints);
			addCommand(CuePointEvent.RESET_CUEPOINTS_COUNT, ResetCuePointsCount);
			addCommand(CuePointEvent.DOWNLOAD_CUEPOINTS, DownloadCuePoints);
			addCommand(CuePointEvent.UPLOAD_CUEPOINTS, UploadCuePoints);
			
			//related files
			addCommand(RelatedFileEvent.LIST_RELATED_FILES, ListRelatedFilesCommand);
			addCommand(RelatedFileEvent.SAVE_ALL_RELATED, SaveRelatedFilesCommand);
			addCommand(RelatedFileEvent.UPDATE_RELATED_FILE, UpdateRelatedFileCommand);
			
			// clips
			addCommand(ClipEvent.GET_ENTRY_CLIPS, GetEntryClipsCommand);
			addCommand(ClipEvent.RESET_MODEL_ENTRY_CLIPS, ResetEntryClipsCommand);
			
			
		}
	}
}