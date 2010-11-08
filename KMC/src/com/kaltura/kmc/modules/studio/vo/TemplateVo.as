package com.kaltura.kmc.modules.studio.vo
{
	[Bindable]
	/**
	 * TemplateVo holds data relevant to the selected player template
	 * and is used as the data object to ApsWizTemplate. 
	 * @author Atar
	 */	
	public class TemplateVo {
		
		/**
		 * player should start muted 
		 */		
		public var autoMute:Boolean;
		
		/**
		 * start playing media automatically 
		 */		
		public var autoPlay:Boolean;
		
		/**
		 * duration to show image on playlist 
		 */		
		public var imageDefaultDuration:Number;
		
		/**
		 * move to next playlist item automatically 
		 */		
		public var playlistAutoContinue:Boolean;
		
		/**
		 * keep video aspect ratio 
		 * @default	true
		 */		
		public var keepAspectRatio:Boolean = true;
		
		/**
		 * player name 
		 */		
		public var playerName:String;
		
	}
}