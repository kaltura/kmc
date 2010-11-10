package com.kaltura.kmc.modules.content.view.interfaces
{
	import com.kaltura.vo.KalturaBaseSyndicationFeed;
	
	/**
	 * This interface declares the methods necessary for an external syndication feed. 
	 */	
	public interface IExternalSyndicationFeed
	{
		function get syndication():KalturaBaseSyndicationFeed
		function set syndication(syndication:KalturaBaseSyndicationFeed):void
		
		function validate():Boolean
	}
}