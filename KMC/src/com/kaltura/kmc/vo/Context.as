package com.kaltura.kmc.vo
{
	/**
	 * this is a dummy class until we create the real
	 * one that will work with all the modules. 
	 * @author Atar
	 */	
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	public class Context implements IValueObject
	{
		private var _ks:String;
		private var _partner_id:String;
		private var _uid:String;
		private var _subp_id:String;
		private var _servicesPath:String;
		private var _serverPath:String;
		private var _widget_id:String;
		
		public function Context(ksParam:String,
								partnerParam:String,
								uidParam:String,
								subpIdParam:String,
								serverPathP:String,
								servicesPathP:String,
								widgetId:String)
		{
			_ks = ksParam;	
			_partner_id = partnerParam;	
			_uid = uidParam;	
			_subp_id = subpIdParam;	
			_servicesPath = servicesPathP;	
			_serverPath = serverPathP;	
			_widget_id = widgetId;	
		}
		
		public function get ks():String
		{
			return _ks;
		} 
		public function get uid():String
		{
			return _uid;
		} 
		public function get partner_id():String
		{
			return _partner_id;
		} 
		public function get subp_id():String
		{
			return _subp_id;
		} 
		public function get servicesPath():String
		{
			return _servicesPath;
		} 
		public function get serverPath():String
		{
			return _serverPath;
		} 
		public function get fullPath():String
		{
			return _serverPath+_servicesPath;
		} 
		public function get widget_id():String
		{
			return _widget_id;
		} 
		
	}
}