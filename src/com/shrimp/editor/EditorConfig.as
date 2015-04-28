package com.shrimp.editor
{
	import com.shrimp.framework.log.Logger;
	
	import flash.utils.Dictionary;

	/**
	 *	配置文件 
	 * @author Sol
	 * 
	 */	
	public class EditorConfig
	{
		private var componentConfig:Dictionary = new Dictionary();
		public function EditorConfig()
		{
		}
		
		/**
		 *	存配置文件, 根据组件名字进行存取 
		 * @param key
		 * @param value
		 * 
		 */		
		public function set ComponentsConfig(key:String,value:Object):void
		{
			//如果已经存在该名字组件,跳过
			if(componentConfig[key]!=null)
			{
				Logger.getLogger("Config").warning("already exist key:",key);
				return;
			}
			
			componentConfig[key] = value;
		}
		
		/**
		 *	根据组件名字找到相关的配置 
		 * @param key
		 * 
		 */		
		public function get configByKey(key:String):Object
		{
			if(componentConfig[key] == null)
			{
				Logger.getLogger("Config").warning("no exist key:",key);
				return null;
			}
			
			return componentConfig[key];
		}
	}
}