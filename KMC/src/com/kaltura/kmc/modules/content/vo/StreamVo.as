package com.kaltura.kmc.modules.content.vo
{
	public class StreamVo
	{
		
		public var streamName:String;
		public var primaryIp:String;
		public var secondaryIp:String;
		public var password:String;
		public var description:String;
		
		public function StreamVo(streamName:String , primaryIp:String ,secondaryIp:String ,password:String, description:String = '' )
		{
			this.streamName = streamName ; 
			this.primaryIp = primaryIp ; 
			this.secondaryIp = secondaryIp ; 
			this.password = password; 
			this.description = description ; 
		}
		
		

	}
}