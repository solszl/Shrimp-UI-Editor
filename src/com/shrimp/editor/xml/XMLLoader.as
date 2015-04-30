package com.shrimp.editor.xml
{
	import appkit.responders.NResponder;
	
	import com.shrimp.AppCMD;
	import com.shrimp.framework.load.LoaderManager;
	import com.shrimp.framework.load.ResourceType;
	import com.shrimp.utils.FileUtils;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.system.ApplicationDomain;

	/**
	 *	xml加载器 ,加载完成后,缓存起来 
	 * @author Sol
	 * 
	 */	
	public class XMLLoader extends EventDispatcher
	{
		public function XMLLoader()
		{
		}
		
		private var _urls:Array = [];
		
		/**	类型*/
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		/**	设置xml 集合的路径*/
		public function set urls(value:Array):void
		{
			_urls = value;
		}
		
		public function get urls():Array
		{
			return _urls;
		}
		
		private var _type:String;
		
		/**	开始加载xml集合*/
		public function startLoad():void
		{
			if(urls.length == 0)
			{
				throw new IllegalOperationError("xml 集合 路径为 空,无法继续进行下去了.");
				return;
			}
			
			var loadList:Array = [];
			var obj:Object;
			//构建加载对象
			for each(var url:String in urls)
			{
				//{id:"Button",url:"e:\\workspace\\shrimp\\xxxx,type:3"}
				var f:File = FileUtils.getFile(url);
				if(f==null)
					continue;
				
				//文件 Component.xml   去掉扩展名
				var name:String = f.name.replace(/\.[^\.]*$/,"");
				obj = {url:url,type:ResourceType.TXT,key:name};
				loadList.push(obj);
			}
			
			LoaderManager.loadAssets(loadList,onItemComplete,null,allComplete,null,false);
		}
		
		//单个文件加载完成的回调
		private function onItemComplete(item:Object, content:Object, domain:ApplicationDomain):void
		{
			NResponder.dispatch(AppCMD.LOAD_ONE_COMPLETE,[item,content,type]);
		}
		
		//列表内所有文件加载完成的回调
		private function allComplete():void
		{
			NResponder.dispatch(AppCMD.LOAD_FOLDER_ALL_COMPLETE);
		}
	}
}