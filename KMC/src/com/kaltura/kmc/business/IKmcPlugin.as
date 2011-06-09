package com.kaltura.kmc.business
{
	import com.kaltura.KalturaClient;

	public interface IKmcPlugin {
		
		function set client(value:KalturaClient):void;
		function get client():KalturaClient;
		
	}
}