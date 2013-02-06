package com.kaltura.kmc.modules.content.vo
{
	public class StreamVo
	{
		public static const STREAM_TYPE_UNIVERSAL:String = 'universal';
		public static const STREAM_TYPE_LEGACY:String = 'legacy';
		public static const STREAM_TYPE_MANUAL:String = 'manual';
		
		public var streamType:String = STREAM_TYPE_LEGACY;
		
		/**
		 * live stream name 
		 */
		public var streamName:String;
		
		/**
		 * live stream description 
		 */
		public var description:String;
		
		
		/* rtmp, hls/hds specific fields */
		/**
		 * primary ip for rtmp stream (legacy) and hls/hds stream (universal)   
		 */
		public var primaryIp:String;
		
		/**
		 * secondary ip for rtmp stream (legacy) and hls/hds stream (universal)   
		 */
		public var secondaryIp:String;
		
		/**
		 * broadcast password for rtmp stream (legacy) and hls/hds stream (universal)   
		 */
		public var password:String;
		
		
		/* manual stream specific fields */
		public var flashHDSURL:String;
		public var mobileHLSURL:String; 

		
		public function StreamVo() {
		}
		
		

	}
}