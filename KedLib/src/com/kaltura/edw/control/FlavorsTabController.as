package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.*;
	import com.kaltura.edw.control.commands.dropFolder.*;
	import com.kaltura.edw.control.commands.flavor.*;
	import com.kaltura.edw.control.events.DropFolderEvent;
	import com.kaltura.edw.control.events.DropFolderFileEvent;
	import com.kaltura.edw.control.events.FlavorAssetEvent;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.edw.control.events.ProfileEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class FlavorsTabController extends KMvCController {
		
		public function FlavorsTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(ProfileEvent.LIST_CONVERSION_PROFILES_AND_FLAVOR_PARAMS, ListConversionProfilesAndFlavorParams);
			addCommand(ProfileEvent.LIST_STORAGE_PROFILES, ListStorageProfilesCommand);
			
			addCommand(KedEntryEvent.GET_REPLACEMENT_ENTRY, GetSingleEntryCommand);
			addCommand(KedEntryEvent.GET_FLAVOR_ASSETS, ListFlavorAssetsByEntryIdCommand);
			addCommand(KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS, GetSingleEntryCommand);
			addCommand(KedEntryEvent.UPDATE_SINGLE_ENTRY, UpdateSingleEntry);
			
			addCommand(MediaEvent.APPROVE_REPLACEMENT, ApproveMediaEntryReplacementCommand);
			addCommand(MediaEvent.CANCEL_REPLACEMENT, CancelMediaEntryReplacementCommand);
			addCommand(MediaEvent.UPDATE_SINGLE_FLAVOR, UpdateFlavorCommand);	
			addCommand(MediaEvent.ADD_SINGLE_FLAVOR, AddFlavorCommand);
			addCommand(MediaEvent.UPDATE_MEDIA, UpdateMediaCommand);
			
			addCommand(DropFolderEvent.LIST_FOLDERS, ListDropFolders);
			addCommand(DropFolderEvent.SET_SELECTED_FOLDER, SetSelectedFolder);	// matchFromDF win
			addCommand(DropFolderFileEvent.RESET_DROP_FOLDERS_AND_FILES, ResetDropFoldersAndFiles); // matchFromDF win
			addCommand(DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_HIERCH, ListDropFoldersFilesCommand);	// matchFromDF win
			addCommand(DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_FLAT, ListDropFoldersFilesCommand);	// matchFromDF win
			
			addCommand(FlavorAssetEvent.CREATE_FLAVOR_ASSET, ConvertFlavorAssetCommand);
			addCommand(FlavorAssetEvent.DELETE_FLAVOR_ASSET, DeleteFlavorAssetCommand);
			addCommand(FlavorAssetEvent.DOWNLOAD_FLAVOR_ASSET, DownloadFlavorAsset);
			addCommand(FlavorAssetEvent.PREVIEW_FLAVOR_ASSET, PreviewFlavorAsset);
			addCommand(FlavorAssetEvent.VIEW_WV_ASSET_DETAILS, ViewWVAssetDetails);
			
		}
	}
}