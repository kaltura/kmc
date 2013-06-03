package  com.kaltura.kmc.modules.analytics.view.core
{
	import com.kaltura.kmc.modules.analytics.view.window.ProgressWin;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	public class FileManager
	{
		public var fr : FileReference;
		private var _progWin : ProgressWin;
		private var _uploadUrl : String = "";
		private var _strParams : Object;
		private var _newFileName : String;
		private var _uploadAfterBrowse : Boolean = true;
		private var _request : URLRequest;
		
		public function FileManager( uploadUrl : String = "" )
		{
			_uploadUrl = uploadUrl;	
		}
	
		public function downloadFile( pathURL : String , title : String , fileName : String) : void
		{
			if(!_progWin)
				_progWin = new ProgressWin();
			else
				_progWin.init();
			
			_progWin.title = title;	
			
			if(!fr) fr = new FileReference();	
			
			_progWin.fr = fr;
			_progWin.downloadContext = true;	
			
			fr.addEventListener( Event.OPEN, _progWin.openHandler );
        	fr.addEventListener( ProgressEvent.PROGRESS, _progWin.progressHandler);
        	fr.addEventListener( Event.COMPLETE, _progWin.completeHandler);
			fr.addEventListener( Event.CANCEL  , _progWin.cancelDownload );
			fr.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _progWin.cancelDownload );
			fr.addEventListener( IOErrorEvent.IO_ERROR , _progWin.cancelDownload );
			PopUpManager.addPopUp( _progWin , Application.application as DisplayObjectContainer );
			PopUpManager.centerPopUp( _progWin );
				
        	var request:URLRequest = new URLRequest();
        	request.url = pathURL;
        			
       		fr.download(request, fileName);	
		}
		
		public function uploadFile( strParams : Object , 
									uploadCompleateCallBack : Function ,
									fileType : String = "*",  
									fileTypeTxt : String ="", 
									uploadAfterBrowse : Boolean = true) : void
		{
			_uploadAfterBrowse = uploadAfterBrowse;
			_strParams = strParams;
			
			fr.addEventListener( Event.SELECT, selectHandler);
			fr.addEventListener( DataEvent.UPLOAD_COMPLETE_DATA   , uploadCompleateCallBack );
			
    		var docFilter:FileFilter = new FileFilter(fileTypeTxt, fileType);
    		fr.browse( [docFilter] );
		}
		
		public function uplaodFile( uploadCompleateCallBack : Function = null) : void
		{
			_progWin = new ProgressWin();
    		_progWin.fr = fr;
			_progWin.title = "Upload CSV";
			_progWin.downloadContext = false;
			
			
    		fr.addEventListener( Event.OPEN, _progWin.openHandler);
    		fr.addEventListener( ProgressEvent.PROGRESS, _progWin.progressHandler);
    		fr.addEventListener( Event.CANCEL  , _progWin.cancelDownload );
    		fr.addEventListener( Event.COMPLETE, _progWin.completeHandler);
    		if( uploadCompleateCallBack != null )
    			fr.addEventListener( DataEvent.UPLOAD_COMPLETE_DATA   , uploadCompleateCallBack );
    		fr.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _progWin.cancelDownload );
    		fr.addEventListener( IOErrorEvent.IO_ERROR , _progWin.cancelDownload );
    		
    		fr.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
    		
			PopUpManager.addPopUp( _progWin , Application.application as DisplayObjectContainer);
			PopUpManager.centerPopUp( _progWin );
			
			fr.upload(_request,"csv_file");
		}
		
		public function get progWin() : ProgressWin
		{
			return _progWin;
		}
		
		public function set progWin( progWin : ProgressWin ) : void
		{
			_progWin = progWin;
		}
		
		private function selectHandler( event : Event ) : void
		{
			_request = new URLRequest();
			_uploadUrl += "?";
			for( var str : String in _strParams )
			{
				_uploadUrl += str +'='+_strParams[str]+'&';
			}
    		_request.url = _uploadUrl;
    		
    		if(_uploadAfterBrowse)
    			uplaodFile();
		}
		
		private function httpStatusHandler( event : HTTPStatusEvent ) :void
		{
			trace("httpStatusHandler: " + event.status );
		}
		
		public function set uploadUrl( path : String ) : void
		{
			_uploadUrl = path;
		}
		
		public function get uploadUrl() : String
		{
			return _uploadUrl;
		}
		
	}
}