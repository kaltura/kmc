package com.kaltura.kmc.model.types {

	/**
	 * known API errors according to December 2010 (Dragonfly +-)
	 * @author Atar
	 */
	public class APIErrorCode {

		//
		/**
		 * Internal server error occured 
		 */
		public static const INTERNAL_SERVERL_ERROR:String = "INTERNAL_SERVERL_ERROR";

		//
		/**
		 * Missing KS, session not established
		 */
		public static const MISSING_KS:String = "MISSING_KS";

		 
		/**
		 * Invalid KS \"%s\", Error \"%s,%s\"
		 * %s - the ks string, %s - error code, %s - error description 
		 */
		public static const INVALID_KS:String = "INVALID_KS";

		//
		/**
		 * Service name was not specified, please specify one
		 */
		public static const SERVICE_NOT_SPECIFIED:String = "SERVICE_NOT_SPECIFIED";

		
		/**
		 * Service \"%s\" does not exists
		 * %s - service name 
		 */
		public static const SERVICE_DOES_NOT_EXISTS:String = "SERVICE_DOES_NOT_EXISTS";

		//
		/**
		 * Action name was not specified, please specify one 
		 */
		public static const ACTION_NOT_SPECIFIED:String = "ACTION_NOT_SPECIFIED";

		// 
		/**
		 * Action \"%s\" does not exists for service \"%s\"
		 * %s - action name, %s - service name
		 */
		public static const ACTION_DOES_NOT_EXISTS:String = "ACTION_DOES_NOT_EXISTS";

		// 
		/**
		 * Missing parameter \"%s\"
		 * %s - parameter name
		 */
		public static const MISSING_MANDATORY_PARAMETER:String = "MISSING_MANDATORY_PARAMETER";

		// 
		/**
		 * Invalid object type \"%s\"
		 * %s - invalid object type
		 */
		public static const INVALID_OBJECT_TYPE:String = "INVALID_OBJECT_TYPE";

		// 
		/**
		 * Invalid enumeration value \"%s\" for parameter \"%s\", expecting enumeration type \"%s\"
		 * %s - enum value, %s - parameter name, %s - enum type
		 */
		public static const INVALID_ENUM_VALUE:String = "INVALID_ENUM_VALUE";

		// 
		/**
		 * Invalid partner id \"%s\"
		 * %s - partner id
		 */
		public static const INVALID_PARTNER_ID:String = "INVALID_PARTNER_ID";

		// %s - service , %s - action
		/**
		 * Invalid service configuration. Unknown service [%s:%s].
		 */
		public static const INVALID_SERVICE_CONFIGURATION:String = "INVALID_SERVICE_CONFIGURATION";

		/**
		 * The property \"%s\" cannot be NULL
		 */
		public static const PROPERTY_VALIDATION_CANNOT_BE_NULL:String = "PROPERTY_VALIDATION_CANNOT_BE_NULL";

		/**
		 * The property \"%s\" must have a min length of %s characters
		 */
		public static const PROPERTY_VALIDATION_MIN_LENGTH:String = "PROPERTY_VALIDATION_MIN_LENGTH";

		/**
		 * The property \"%s\" cannot have more than %s characters
		 */
		public static const PROPERTY_VALIDATION_MAX_LENGTH:String = "PROPERTY_VALIDATION_MAX_LENGTH";

		/**
		 * The property \"%s\" cannot be updated
		 */
		public static const PROPERTY_VALIDATION_NOT_UPDATABLE:String = "PROPERTY_VALIDATION_NOT_UPDATABLE";

		/**
		 * The property \"%s\" is updatable with admin session only
		 */
		public static const PROPERTY_VALIDATION_ADMIN_PROPERTY:String = "PROPERTY_VALIDATION_ADMIN_PROPERTY";

		/**
		 * Invalid user id
		 */
		public static const INVALID_USER_ID:String = "INVALID_USER_ID";

		/*
		 * Service Oriented Errors
		 *
		 */

		/*
		 * Media Service
		 */

		/**
		 * 
		 * Entry id \"%s\" not found
		 * Media Service
		 */
		public static const ENTRY_ID_NOT_FOUND:String = "ENTRY_ID_NOT_FOUND";

		/**
		 * Entry type \"%s\" not suppported
		 * Media Service
		 */
		public static const ENTRY_TYPE_NOT_SUPPORTED:String = "ENTRY_TYPE_NOT_SUPPORTED";

		/**
		 * Entry media type \"%s\" not suppported
		 * Media Service
		 */
		public static const ENTRY_MEDIA_TYPE_NOT_SUPPORTED:String = "ENTRY_MEDIA_TYPE_NOT_SUPPORTED";

		/**
		 * The uploaded file was not found by the given token id, or was already used
		 * Media Service
		 */
		public static const UPLOADED_FILE_NOT_FOUND_BY_TOKEN:String = "UPLOADED_FILE_NOT_FOUND_BY_TOKEN";

		/**
		 * The recorded webcam file was not found by the given token id, or was already used
		 * Media Service
		 */
		public static const RECORDED_WEBCAM_FILE_NOT_FOUND:String = "RECORDED_WEBCAM_FILE_NOT_FOUND";

		/**
		 * User can update only the entries he own, otherwise an admin session must be used
		 * Media Service
		 */
		public static const PERMISSION_DENIED_TO_UPDATE_ENTRY:String = "PERMISSION_DENIED_TO_UPDATE_ENTRY";

		/**
		 * Invalid rank value, rank should be between 1 and 5
		 * Media Service
		 */
		public static const INVALID_RANK_VALUE:String = "INVALID_RANK_VALUE";

		/**
		 * Entry can be linked with a maximum of \"%s\" categories
		 * Media Service
		 */
		public static const MAX_CATEGORIES_FOR_ENTRY_REACHED:String = "MAX_CATEGORIES_FOR_ENTRY_REACHED";

		/**
		 * Invalid entry schedule dates
		 * Media Service
		 */
		public static const INVALID_ENTRY_SCHEDULE_DATES:String = "INVALID_ENTRY_SCHEDULE_DATES";

		/**
		 * Invalid entry status
		 * Media Service
		 */
		public static const INVALID_ENTRY_STATUS:String = "INVALID_ENTRY_STATUS";

		/**
		 * Entry cannot be flagged
		 * Media Service
		 */
		public static const ENTRY_CANNOT_BE_FLAGGED:String = "ENTRY_CANNOT_BE_FLAGGED";

		/**
		 * Notification Service
		 * Notification for entry id \"%s\" not found
		 */
		public static const NOTIFICATION_FOR_ENTRY_NOT_FOUND:String = "NOTIFICATION_FOR_ENTRY_NOT_FOUND";

		/**
		 * Bulk Upload Service
		 * Bulk upload id \"%s\" not found
		 */

		public static const BULK_UPLOAD_NOT_FOUND:String = "BULK_UPLOAD_NOT_FOUND";

		/**
		 * Widget Service
		 * SourceWidgetId or UiConfId id are required
		 */
		public static const SOURCE_WIDGET_OR_UICONF_REQUIRED:String = "SOURCE_WIDGET_OR_UICONF_REQUIRED";

		/**
		 * Source widget id \"%s\" not found
		 * Widget Service
		 */
		public static const SOURCE_WIDGET_NOT_FOUND:String = "SOURCE_WIDGET_NOT_FOUND";

		/**
		 * Ui conf id \"%s\" not found
		 * UiConf Service
		 */
		public static const UICONF_ID_NOT_FOUND:String = "UICONF_ID_NOT_FOUND";

		/**
		 * Access control id \"%s\" not found
		 * AccessControl Service
		 */
		public static const ACCESS_CONTROL_ID_NOT_FOUND:String = "ACCESS_CONTROL_ID_NOT_FOUND";

		/**
		 * Max number of \"%s\" access controls was reached
		 * AccessControl Service
		 */
		public static const MAX_NUMBER_OF_ACCESS_CONTROLS_REACHED:String = "MAX_NUMBER_OF_ACCESS_CONTROLS_REACHED";

		/**
		 * Default access control cannot be deleted
		 * AccessControl Service
		 */
		public static const CANNOT_DELETE_DEFAULT_ACCESS_CONTROL:String = "CANNOT_DELETE_DEFAULT_ACCESS_CONTROL";

		/**
		 * Conversion profile id \"%s\" not found
		 * ConversionProfile Service
		 */
		public static const CONVERSION_PROFILE_ID_NOT_FOUND:String = "CONVERSION_PROFILE_ID_NOT_FOUND";

		/**
		 * Default conversion profile cannot be deleted
		 * ConversionProfile Service
		 */
		public static const CANNOT_DELETE_DEFAULT_CONVERSION_PROFILE:String = "CANNOT_DELETE_DEFAULT_CONVERSION_PROFILE";

		/**
		 * Flavor params id \"%s\" not found
		 * FlavorParams Service
		 */
		public static const FLAVOR_PARAMS_ID_NOT_FOUND:String = "FLAVOR_PARAMS_ID_NOT_FOUND";

		/**
		 * 
		 * FlavorParams Service
		 */
		public static const FLAVOR_PARAMS_NOT_FOUND:String = "FLAVOR_PARAMS_NOT_FOUND,Flavor params not found";

		/**
		 * Flavor params [%s] defined more than once
		 * FlavorParams Service
		 */
		public static const FLAVOR_PARAMS_DUPLICATE:String = "FLAVOR_PARAMS_DUPLICATE";

		/**
		 * More than onc source flavor defined
		 * FlavorParams Service
		 */
		public static const FLAVOR_PARAMS_SOURCE_DUPLICATE:String = "FLAVOR_PARAMS_SOURCE_DUPLICATE";

		/**
		 * Flavor asset id \"%s\" not found
		 * FlavorAsset Service
		 */
		public static const FLAVOR_ASSET_ID_NOT_FOUND:String = "FLAVOR_ASSET_ID_NOT_FOUND";

		/**
		 * Cannot reconvert original flavor asset
		 * FlavorAsset Service
		 */
		public static const FLAVOR_ASSET_RECONVERT_ORIGINAL:String = "FLAVOR_ASSET_RECONVERT_ORIGINAL";

		/**
		 * The original flavor asset is missing
		 * FlavorAsset Service
		 */
		public static const ORIGINAL_FLAVOR_ASSET_IS_MISSING:String = "ORIGINAL_FLAVOR_ASSET_IS_MISSING";

		/**
		 * The original flavor asset could not be created [%s]
		 * FlavorAsset Service
		 */
		public static const ORIGINAL_FLAVOR_ASSET_NOT_CREATED:String = "ORIGINAL_FLAVOR_ASSET_NOT_CREATED";

		/**
		 * No flavors found
		 * FlavorAsset Service
		 */
		public static const NO_FLAVORS_FOUND:String = "NO_FLAVORS_FOUND";

		/**
		 * The Thumbnail asset id \"%s\" not found
		 * ThumbAsset Service
		 */
		public static const THUMB_ASSET_ID_NOT_FOUND:String = "THUMB_ASSET_ID_NOT_FOUND";

		/**
		 * The Thumbnail asset not found for params id \"%s\"
		 * ThumbAsset Service
		 */
		public static const THUMB_ASSET_PARAMS_ID_NOT_FOUND:String = "THUMB_ASSET_ID_NOT_FOUND";

		/**
		 * The thumbnail asset is not ready
		 * ThumbAsset Service
		 */
		public static const THUMB_ASSET_IS_NOT_READY:String = "THUMB_ASSET_IS_NOT_READY";

		/**
		 * Category id \"%s\" not found
		 * Category Service
		 */
		public static const CATEGORY_NOT_FOUND:String = "CATEGORY_NOT_FOUND";

		/**
		 * Parent category id \"%s\" not found
		 * Category Service
		 */
		public static const PARENT_CATEGORY_NOT_FOUND:String = "PARENT_CATEGORY_NOT_FOUND";

		/**
		 * The category \"%s\" already exists
		 * Category Service
		 */
		public static const DUPLICATE_CATEGORY:String = "DUPLICATE_CATEGORY";

		/**
		 * The parent category \"%s\" is one of the childs for category \"%s\"
		 * Category Service
		 */
		public static const PARENT_CATEGORY_IS_CHILD:String = "PARENT_CATEGORY_IS_CHILD";

		/**
		 * Category can have a max depth of \"%s\" levels
		 * Category Service
		 */
		public static const MAX_CATEGORY_DEPTH_REACHED:String = "MAX_CATEGORY_DEPTH_REACHED";

		/**
		 * Max number of \"%s\" categories was reached
		 * Category Service
		 */
		public static const MAX_NUMBER_OF_CATEGORIES_REACHED:String = "MAX_NUMBER_OF_CATEGORIES_REACHED";

		/**
		 * Categories are locked, lock will be automatically released in \"%s\" seconds
		 * Category Service
		 */
		public static const CATEGORIES_LOCKED:String = "CATEGORIES_LOCKED";

		/**
		 *  Scheduler id \"%s\" conflicts between hosts: \"%s\" and \"%s\"
		 * Batch Service
		 */

		public static const SCHEDULER_HOST_CONFLICT:String = "SCHEDULER_HOST_CONFLICT";

		/**
		 *  Scheduler id \"%s\" not found
		 * Batch Service
		 */
		public static const SCHEDULER_NOT_FOUND:String = "SCHEDULER_NOT_FOUND";

		/**
		 *  Worker id \"%s\" not found
		 * Batch Service
		 */
		public static const WORKER_NOT_FOUND:String = "WORKER_NOT_FOUND";

		/**
		 *  Command id \"%s\" not found
		 * Batch Service
		 */
		public static const COMMAND_NOT_FOUND:String = "COMMAND_NOT_FOUND";

		/**
		 *  Command already pending
		 * Batch Service
		 */
		public static const COMMAND_ALREADY_PENDING:String = "COMMAND_ALREADY_PENDING";

		/**
		 * Partner not set
		 * Batch Service
		 */
		public static const PARTNER_NOT_SET:String = "PARTNER_NOT_SET";

		/**
		 * Invalid upload token id
		 * Upload Service
		 */
		public static const INVALID_UPLOAD_TOKEN_ID:String = "INVALID_UPLOAD_TOKEN_ID";

		/**
		 * File was uploaded partially
		 * Upload Service
		 */
		public static const UPLOAD_PARTIAL_ERROR:String = "UPLOAD_PARTIAL_ERROR";

		/**
		 * Upload failed
		 * Upload Service
		 */
		public static const UPLOAD_ERROR:String = "UPLOAD_ERROR";

		/**
		 * Uploaded file not found [%s]
		 * Upload Service
		 */
		public static const UPLOADED_FILE_NOT_FOUND:String = "UPLOADED_FILE_NOT_FOUND";

		/**
		 * Unable to create file sync object for bulk upload csv
		 * Upload Service
		 */
		public static const BULK_UPLOAD_CREATE_CSV_FILE_SYNC_ERROR:String = "BULK_UPLOAD_CREATE_CSV_FILE_SYNC_ERROR";

		/**
		 * Unable to create file sync object for bulk upload result
		 * Upload Service
		 */
		public static const BULK_UPLOAD_CREATE_RESULT_FILE_SYNC_ERROR:String = "BULK_UPLOAD_CREATE_RESULT_FILE_SYNC_ERROR";

		/**
		 * Unable to create file sync object for flavor conversion
		 * Upload Service
		 */
		public static const BULK_UPLOAD_CREATE_CONVERT_FILE_SYNC_ERROR:String = "BULK_UPLOAD_CREATE_CONVERT_FILE_SYNC_ERROR";

		/**
		 * Upload token not found
		 * Upload Token Service
		 */
		public static const UPLOAD_TOKEN_NOT_FOUND:String = "UPLOAD_TOKEN_NOT_FOUND";

		/**
		 *Upload token is in an invalid status for uploading a file, maybe the file was already uploaded
		 * Upload Token Service 
		 */
		public static const UPLOAD_TOKEN_INVALID_STATUS_FOR_UPLOAD:String = "UPLOAD_TOKEN_INVALID_STATUS_FOR_UPLOAD";

		/**
		 * Upload token is in an invalid status for adding entry, maybe the a file was not uploaded or the token was used
		 * Upload Token Service
		 */
		public static const UPLOAD_TOKEN_INVALID_STATUS_FOR_ADD_ENTRY:String = "UPLOAD_TOKEN_INVALID_STATUS_FOR_ADD_ENTRY";

		/**
		 * Cannot resume the upload, original file was not found
		 * Upload Token Service
		 */
		public static const UPLOAD_TOKEN_CANNOT_RESUME:String = "UPLOAD_TOKEN_CANNOT_RESUME";

		/**
		 * Resuming not allowed when file size was not specified
		 * Upload Token Service
		 */
		public static const UPLOAD_TOKEN_RESUMING_NOT_ALLOWED:String = "UPLOAD_TOKEN_RESUMING_NOT_ALLOWED";

		/**
		 * Resuming not allowed after end of file
		 * Upload Token Service
		 */
		public static const UPLOAD_TOKEN_RESUMING_INVALID_POSITION:String = "UPLOAD_TOKEN_RESUMING_INVALID_POSITION";

		/*
		 * Partenrs service
		 * %s - the parent partner_id
		 */
		/**
		 * Partner id [%s] is not a VAR/GROUP, but is attempting to create child partner
		 * Partenrs service
		 * %s - the parent partner_id
		 */
		public static const NON_GROUP_PARTNER_ATTEMPTING_TO_ASSIGN_CHILD:String = "NON_GROUP_PARTNER_ATTEMPTING_TO_ASSIGN_CHILD";


		/**
		 * Invalid object id [%s]
		 * Partenrs service
		 * %s - the parent partner_id
		 */
		public static const INVALID_OBJECT_ID:String = "INVALID_OBJECT_ID";

		/**
		 * User was not found
		 * Partenrs service
		 * %s - the parent partner_id
		 */
		public static const USER_NOT_FOUND:String = "USER_NOT_FOUND";

		/**
		 * Wrong password supplied
		 * Partenrs service
		 * %s - the parent partner_id
		 */
		public static const USER_WRONG_PASSWORD:String = "USER_WRONG_PASSWORD";

		/**
		 * User is already allowed to login
		 * Partenrs service
		 * %s - the parent partner_id
		 */
		public static const USER_LOGIN_ALREADY_ENABLED:String = 'USER_LOGIN_ALREADY_ENABLED';

		/**
		 * User is already not allowed to login
		 * Partenrs service
		 * %s - the parent partner_id
		 */
		public static const USER_LOGIN_ALREADY_DISABLED:String = 'USER_LOGIN_ALREADY_DISABLED';

	}
}