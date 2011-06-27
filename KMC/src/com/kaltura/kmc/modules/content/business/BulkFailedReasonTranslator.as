package com.kaltura.kmc.modules.content.business
{
	import com.kaltura.types.KalturaBatchJobErrorTypes;
	import com.kaltura.types.KalturaBatchJobStatus;
	import com.kaltura.vo.KalturaBulkUpload;
	
	import mx.resources.ResourceManager;

	public class BulkFailedReasonTranslator {
		
		
		private static var $curlDescriptions:Object =  {
			'0' : ResourceManager.getInstance().getString('bulkfailures', '0'),
			'1' : ResourceManager.getInstance().getString('bulkfailures', '1'),
			'2' : ResourceManager.getInstance().getString('bulkfailures', '2'),
			'3' : ResourceManager.getInstance().getString('bulkfailures', '3'),
			'5' : ResourceManager.getInstance().getString('bulkfailures', '5'),
			'6' : ResourceManager.getInstance().getString('bulkfailures', '6'),
			'7' : ResourceManager.getInstance().getString('bulkfailures', '7'),
			'8' : ResourceManager.getInstance().getString('bulkfailures', '8'),
			'9' : ResourceManager.getInstance().getString('bulkfailures', '9'),
			'11' : ResourceManager.getInstance().getString('bulkfailures', '11'),
			'13' : ResourceManager.getInstance().getString('bulkfailures', '13'),
			'14' : ResourceManager.getInstance().getString('bulkfailures', '14'),
			'84' : ResourceManager.getInstance().getString('bulkfailures', '84'),
			'15' : ResourceManager.getInstance().getString('bulkfailures', '15'),
			'17' : ResourceManager.getInstance().getString('bulkfailures', '17'),
			'18' : ResourceManager.getInstance().getString('bulkfailures', '18'),
			'19' : ResourceManager.getInstance().getString('bulkfailures', '19'),
			'21' : ResourceManager.getInstance().getString('bulkfailures', '21'),
			'22' : ResourceManager.getInstance().getString('bulkfailures', '22'),
			'23' : ResourceManager.getInstance().getString('bulkfailures', '23'),
			'25' : ResourceManager.getInstance().getString('bulkfailures', '25'),
			'26' : ResourceManager.getInstance().getString('bulkfailures', '26'),
			'27' : ResourceManager.getInstance().getString('bulkfailures', '27'),
			'28' : ResourceManager.getInstance().getString('bulkfailures', '28'),
			'30' : ResourceManager.getInstance().getString('bulkfailures', '30'),
			'31' : ResourceManager.getInstance().getString('bulkfailures', '31'),
			'33' : ResourceManager.getInstance().getString('bulkfailures', '33'),
			'34' : ResourceManager.getInstance().getString('bulkfailures', '34'),
			'35' : ResourceManager.getInstance().getString('bulkfailures', '35'),
			'36' : ResourceManager.getInstance().getString('bulkfailures', '36'),
			'37' : ResourceManager.getInstance().getString('bulkfailures', '37'),
			'38' : ResourceManager.getInstance().getString('bulkfailures', '38'),
			'39' : ResourceManager.getInstance().getString('bulkfailures', '39'),
			'41' : ResourceManager.getInstance().getString('bulkfailures', '41'),
			'42' : ResourceManager.getInstance().getString('bulkfailures', '42'),
			'43' : ResourceManager.getInstance().getString('bulkfailures', '43'),
			'45' : ResourceManager.getInstance().getString('bulkfailures', '45'),
			'47' : ResourceManager.getInstance().getString('bulkfailures', '47'),
			'48' : ResourceManager.getInstance().getString('bulkfailures', '48'),
			'49' : ResourceManager.getInstance().getString('bulkfailures', '49'),
			'51' : ResourceManager.getInstance().getString('bulkfailures', '51'),
			'52' : ResourceManager.getInstance().getString('bulkfailures', '52'),
			'53' : ResourceManager.getInstance().getString('bulkfailures', '53'),
			'54' : ResourceManager.getInstance().getString('bulkfailures', '54'),
			'55' : ResourceManager.getInstance().getString('bulkfailures', '55'),
			'56' : ResourceManager.getInstance().getString('bulkfailures', '56'),
			'58' : ResourceManager.getInstance().getString('bulkfailures', '58'),
			'59' : ResourceManager.getInstance().getString('bulkfailures', '59'),
			'60' : ResourceManager.getInstance().getString('bulkfailures', '60'),
			'61' : ResourceManager.getInstance().getString('bulkfailures', '61'),
			'62' : ResourceManager.getInstance().getString('bulkfailures', '62'),
			'63' : ResourceManager.getInstance().getString('bulkfailures', '63'),
			'64' : ResourceManager.getInstance().getString('bulkfailures', '64'),
			'65' : ResourceManager.getInstance().getString('bulkfailures', '65'),
			'66' : ResourceManager.getInstance().getString('bulkfailures', '66'),
			'67' : ResourceManager.getInstance().getString('bulkfailures', '67'),
			'68' : ResourceManager.getInstance().getString('bulkfailures', '68'),
			'69' : ResourceManager.getInstance().getString('bulkfailures', '69'),
			'70' : ResourceManager.getInstance().getString('bulkfailures', '70'),
			'71' : ResourceManager.getInstance().getString('bulkfailures', '71'),
			'72' : ResourceManager.getInstance().getString('bulkfailures', '72'),
			'73' : ResourceManager.getInstance().getString('bulkfailures', '73'),
			'74' : ResourceManager.getInstance().getString('bulkfailures', '74'),
			'75' : ResourceManager.getInstance().getString('bulkfailures', '75'),
			'76' : ResourceManager.getInstance().getString('bulkfailures', '76'),
			'77' : ResourceManager.getInstance().getString('bulkfailures', '77'),
			'78' : ResourceManager.getInstance().getString('bulkfailures', '78'),
			'79' : ResourceManager.getInstance().getString('bulkfailures', '79'),
			'80' : ResourceManager.getInstance().getString('bulkfailures', '80'),
			'81' : ResourceManager.getInstance().getString('bulkfailures', '81'),
			'82' : ResourceManager.getInstance().getString('bulkfailures', '82'),
			'83' : ResourceManager.getInstance().getString('bulkfailures', '83'),
			'-1' : ResourceManager.getInstance().getString('bulkfailures', '-1')
		};
		
		private static var $httpDescriptions:Object = {
			'100' : ResourceManager.getInstance().getString('bulkfailures', '100'), 
			'101' : ResourceManager.getInstance().getString('bulkfailures', '101'), 
			'102' : ResourceManager.getInstance().getString('bulkfailures', '102'), 
			'200' : ResourceManager.getInstance().getString('bulkfailures', '200'), 
			'201' : ResourceManager.getInstance().getString('bulkfailures', '201'), 
			'202' : ResourceManager.getInstance().getString('bulkfailures', '202'), 
			'203' : ResourceManager.getInstance().getString('bulkfailures', '203'), 
			'204' : ResourceManager.getInstance().getString('bulkfailures', '204'), 
			'205' : ResourceManager.getInstance().getString('bulkfailures', '205'), 
			'206' : ResourceManager.getInstance().getString('bulkfailures', '206'), 
			'207' : ResourceManager.getInstance().getString('bulkfailures', '207'), 
			'300' : ResourceManager.getInstance().getString('bulkfailures', '300'), 
			'301' : ResourceManager.getInstance().getString('bulkfailures', '301'), 
			'302' : ResourceManager.getInstance().getString('bulkfailures', '302'), 
			'303' : ResourceManager.getInstance().getString('bulkfailures', '303'), 
			'304' : ResourceManager.getInstance().getString('bulkfailures', '304'), 
			'305' : ResourceManager.getInstance().getString('bulkfailures', '305'), 
			'306' : ResourceManager.getInstance().getString('bulkfailures', '306'), 
			'307' : ResourceManager.getInstance().getString('bulkfailures', '307'), 
			'400' : ResourceManager.getInstance().getString('bulkfailures', '400'), 
			'401' : ResourceManager.getInstance().getString('bulkfailures', '401'), 
			'402' : ResourceManager.getInstance().getString('bulkfailures', '402'), 
			'403' : ResourceManager.getInstance().getString('bulkfailures', '403'), 
			'404' : ResourceManager.getInstance().getString('bulkfailures', '404'), 
			'405' : ResourceManager.getInstance().getString('bulkfailures', '405'), 
			'406' : ResourceManager.getInstance().getString('bulkfailures', '406'), 
			'407' : ResourceManager.getInstance().getString('bulkfailures', '407'), 
			'408' : ResourceManager.getInstance().getString('bulkfailures', '408'), 
			'409' : ResourceManager.getInstance().getString('bulkfailures', '409'), 
			'410' : ResourceManager.getInstance().getString('bulkfailures', '410'), 
			'411' : ResourceManager.getInstance().getString('bulkfailures', '411'), 
			'412' : ResourceManager.getInstance().getString('bulkfailures', '412'), 
			'413' : ResourceManager.getInstance().getString('bulkfailures', '413'), 
			'414' : ResourceManager.getInstance().getString('bulkfailures', '414'), 
			'415' : ResourceManager.getInstance().getString('bulkfailures', '415'), 
			'416' : ResourceManager.getInstance().getString('bulkfailures', '416'), 
			'417' : ResourceManager.getInstance().getString('bulkfailures', '417'), 
			'418' : ResourceManager.getInstance().getString('bulkfailures', '418'), 
			'422' : ResourceManager.getInstance().getString('bulkfailures', '422'), 
			'423' : ResourceManager.getInstance().getString('bulkfailures', '423'), 
			'424' : ResourceManager.getInstance().getString('bulkfailures', '424'), 
			'425' : ResourceManager.getInstance().getString('bulkfailures', '425'), 
			'426' : ResourceManager.getInstance().getString('bulkfailures', '426'), 
			'449' : ResourceManager.getInstance().getString('bulkfailures', '449'), 
			'450' : ResourceManager.getInstance().getString('bulkfailures', '450'), 
			'500' : ResourceManager.getInstance().getString('bulkfailures', '500'), 
			'501' : ResourceManager.getInstance().getString('bulkfailures', '501'), 
			'502' : ResourceManager.getInstance().getString('bulkfailures', '502'), 
			'503' : ResourceManager.getInstance().getString('bulkfailures', '503'), 
			'504' : ResourceManager.getInstance().getString('bulkfailures', '504'), 
			'505' : ResourceManager.getInstance().getString('bulkfailures', '505'), 
			'506' : ResourceManager.getInstance().getString('bulkfailures', '506'), 
			'507' : ResourceManager.getInstance().getString('bulkfailures', '507'), 
			'509' : ResourceManager.getInstance().getString('bulkfailures', '509'), 
			'510' : ResourceManager.getInstance().getString('bulkfailures', '510')
			};
		
		private static var $clientDescriptions:Object = {
			'-2' : ResourceManager.getInstance().getString('bulkfailures', '-2'),
			'-3' : ResourceManager.getInstance().getString('bulkfailures', '-3'),
			'-4' : ResourceManager.getInstance().getString('bulkfailures', '-4'),
			'-5' : ResourceManager.getInstance().getString('bulkfailures', '-5'),
			'-6' : ResourceManager.getInstance().getString('bulkfailures', '-6'),
			'-7' : ResourceManager.getInstance().getString('bulkfailures', '-7'),
			'-8' : ResourceManager.getInstance().getString('bulkfailures', '-8')
		};
		
		
		private static function enumTranslate(str1:String, err:int):String {
			//TODO extract to locale
			var res:String = '';
			if (str1 == 'Kaltura_Client_Enum_BatchJobErrorTypes') {
				switch (err) {
					case KalturaBatchJobErrorTypes.APP:
						res = 'Applicative Error';
						break;
					case KalturaBatchJobErrorTypes.RUNTIME: 
						res = 'Runtime Error';
						break;
					case KalturaBatchJobErrorTypes.HTTP: 
						res = 'HTTP Error';
						break;
					case KalturaBatchJobErrorTypes.CURL: 
						res = 'Curl Error';
						break;
					case KalturaBatchJobErrorTypes.KALTURA_API: 
						res = 'Kaltura API Error';
						break;
					
					case KalturaBatchJobErrorTypes.KALTURA_CLIENT: 
						res = 'Kaltura Client Error';
						break;
				}
			}
			else if (str1 == 'Kaltura_Client_Enum_BatchJobAppErrors') {
				switch (err) {
				case /*KalturaBatchJobAppErrors.OUTPUT_FILE_DOESNT_EXIST*/11: 
					res = 'Output file not created';
					break;
				case /*KalturaBatchJobAppErrors.OUTPUT_FILE_WRONG_SIZE*/12: 
					res = 'Output file has wrong size';
					break;
				case /*KalturaBatchJobAppErrors.NFS_FILE_DOESNT_EXIST*/21:
					res = 'File was not copied to the shared folder';
					break;
				case /*KalturaBatchJobAppErrors.EXTRACT_MEDIA_FAILED*/31: 
					res = 'Failed to extract media';
					break;
				case /*KalturaBatchJobAppErrors.CLOSER_TIMEOUT*/41: 
					res = 'Timed out';
					break;
				case /*KalturaBatchJobAppErrors.ENGINE_NOT_FOUND*/51: 
					res = 'Conversion engine not found';
					break;
				case /*KalturaBatchJobAppErrors.REMOTE_FILE_NOT_FOUND*/61: 
					res = 'Remote file not found';
					break;
				case /*KalturaBatchJobAppErrors.REMOTE_DOWNLOAD_FAILED*/62: 
					res = 'Failed to download remote file';
					break;
//				case /*KalturaBatchJobAppErrors.CSV_FILE_NOT_FOUND*/: 
//					res = 'CSV file not found';
//					break;
				case /*KalturaBatchJobAppErrors.CONVERSION_FAILED*/81: 
					res = 'Conversion failed';
					break;
				case /*KalturaBatchJobAppErrors.THUMBNAIL_NOT_CREATED*/91: 
					res = 'thumbnail file was not created';
					break;
				}
			}
			return res;
		}
		
		public static function getReason(bulk:KalturaBulkUpload):String
		{
			var $status:int = bulk.status; 
			var $errType:int = bulk.errorType;
			var $errNumber:int = bulk.errorNumber;
			var $message:String;
			if($status != KalturaBatchJobStatus.FAILED) {
				// no error
				return '';
			}
			
			var $errTypeDesc:String = enumTranslate('Kaltura_Client_Enum_BatchJobErrorTypes', $errType);
			var $ret:String = $errTypeDesc;
			var $title:String, $url:String;
			
			switch($errType)
			{
				case KalturaBatchJobErrorTypes.APP:
					$ret = enumTranslate('Kaltura_Client_Enum_BatchJobAppErrors', $errNumber);
					break;
				
				case KalturaBatchJobErrorTypes.HTTP:
					$ret = $httpDescriptions[$errNumber];
					break;
				
				case KalturaBatchJobErrorTypes.CURL:
					$title = $curlDescriptions[$errNumber];
					break;
				
				case KalturaBatchJobErrorTypes.RUNTIME:
					$ret = "<span title=\"$message\">$errTypeDesc ($errNumber)</span>";
					break;
				
				case KalturaBatchJobErrorTypes.KALTURA_API:
					$ret = "<span title=\"$message\">$errTypeDesc ($errNumber)</span>";
					break;
				
				case KalturaBatchJobErrorTypes.KALTURA_CLIENT:
					$ret = $clientDescriptions[$errNumber];
					break;
			}
			
			return $ret;
		}
		
	}
}