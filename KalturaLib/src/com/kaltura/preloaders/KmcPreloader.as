package com.kaltura.preloaders
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    
    import mx.events.*;
    import mx.preloaders.*;
    import mx.utils.StringUtil;
    
    public class KmcPreloader extends Sprite implements IPreloaderDisplay
    {
    	[Embed(source="/com/kaltura/assets/flash/preloader/kmcPreloader.swf")]
		private static const preLoaderSwf:Class;
    	
        // Define a Loader control to load the SWF file.
        private var myLoader :Loader;
        
        private var dso:DisplayObject;
     	
        public function KmcPreloader() {   
            super();        
        }
        
        // Specify the event listeners.
        public function set preloader(preloader:Sprite):void {
            // Listen for the relevant events
            preloader.addEventListener( ProgressEvent.PROGRESS, handleProgress); 
            preloader.addEventListener( Event.COMPLETE, handleComplete);
  
            preloader.addEventListener( FlexEvent.INIT_PROGRESS, handleInitProgress);
            preloader.addEventListener( FlexEvent.INIT_COMPLETE, handleInitComplete);
        }
        
        // Initialize the Loader control in the override 
        // of IPreloaderDisplay.initialize().
        public function initialize():void {
           
           
            //TBD - loading path from flash vars, current expect to full path, but it might change...
            if((loaderInfo.parameters.preloader != null) && (StringUtil.trim(loaderInfo.parameters.preloader) != ''))
            {
            	myLoader = new flash.display.Loader();       
        	    myLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, loader_completeHandler );
            	myLoader.load( new URLRequest( loaderInfo.parameters.preloader) );
            }
            else
            {
            	dso = new preLoaderSwf();
				addChild(dso);
				dso.x = stage.stageWidth/2 - dso.width/2;
        		dso.y = stage.stageHeight/2 - dso.height/2;
            }
        }
        
        private function onAdded2Stage( event : Event ) : void
        {
        	stage.addEventListener( Event.RESIZE , onStageResize );
        	onStageResize();
        }
        
        private function onStageResize( event : Event = null) :void
        {
        	if(myLoader && myLoader.content && stage)
        	{
        		myLoader.x = stage.stageWidth/2 - myLoader.content.width/2;
        		myLoader.y = stage.stageHeight/2 - myLoader.content.height/2;
        	}
        	else
        	{
        		dso.x = stage.stageWidth/2 - dso.width/2;
        		dso.y = stage.stageHeight/2 - dso.height/2;
        	}
        }

        // After the SWF file loads, set the size of the Loader control.
        private function loader_completeHandler(event:Event):void
        {
        	if(myLoader != null)
            {
	            myLoader.addEventListener( Event.ADDED_TO_STAGE , onAdded2Stage );            
	            addChild(myLoader);
            }
        }  
        
        // Define empty event listeners.
        private function handleProgress(event:ProgressEvent):void {
        	var cf : int = Math.floor((event.bytesLoaded*100/event.bytesTotal));
        	if(myLoader && myLoader.content)
        	{
        		var mc : MovieClip = MovieClip(myLoader.content);
        		mc.gotoAndStop( cf );
        	}
        	else
        	{
        		var mc2 : MovieClip = MovieClip(dso);
        		mc2.gotoAndStop( cf );
        	}
        	trace( cf );
        }	
        
        private function handleComplete(event:Event):void {
        }
        
        private function handleInitProgress(event:Event):void {
        }
        
        private function handleInitComplete(event:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
/*          var timer:Timer = new Timer(3000,1);
            timer.addEventListener(TimerEvent.TIMER, dispatchComplete);
            timer.start();     */  
        }
    
        private function dispatchComplete(event:TimerEvent):void {
            dispatchEvent(new Event(Event.COMPLETE));
        }

        // Implement IPreloaderDisplay interface
    
        public function get backgroundColor():uint {
            return 0;
        }
        
        public function set backgroundColor(value:uint):void {
        }
        
        public function get backgroundAlpha():Number {
            return 0;
        }
        
        public function set backgroundAlpha(value:Number):void {
        }
        
        public function get backgroundImage():Object {
            return undefined;
        }
        
        public function set backgroundImage(value:Object):void {
        }
        
        public function get backgroundSize():String {
            return "";
        }
        
        public function set backgroundSize(value:String):void {
        }
    
        public function get stageWidth():Number {
        	if(stage) return stage.stageWidth;
            return 200;
        }
        
        public function set stageWidth(value:Number):void {
        }
        
        public function get stageHeight():Number {
        	if(stage) return stage.stageHeight;
            return 200;
        }
        
        public function set stageHeight(value:Number):void {
        }
    }
}