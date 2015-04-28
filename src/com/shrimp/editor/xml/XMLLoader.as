package com.shrimp.editor.xml
{
	import com.shrimp.framework.load.LoaderManager;
	import com.shrimp.framework.load.ResourceType;
	
	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;

	/**
	 *	xml加载器 ,加载完成后,缓存起来 
	 * @author Sol
	 * 
	 */	
	public class XMLLoader
	{
		public function XMLLoader()
		{
		}
		
		private var _urls:Array = [];
		
		/**	设置xml 集合的路径*/
		public function set urls(value:Array):void
		{
			_urls = value;
		}
		
		public function get urls():Array
		{
			return _urls;
		}
		
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
			for each(var url:String in urls)
			{
				obj = {url:url,type:ResourceType.TXT};
				loadList.push(obj);
			}
			
			LoaderManager.loadAssets(loadList,onItemComplete);
		}
		
		private function onItemComplete(item:Object, content:Object, domain:ApplicationDomain):void
		{
			//			switch(item)
			trace(content);
		}
	}
}