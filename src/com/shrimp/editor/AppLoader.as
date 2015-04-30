package com.shrimp.editor
{
	import appkit.responders.NResponder;
	
	import com.shrimp.AppCMD;
	import com.shrimp.editor.xml.XMLLoader;
	import com.shrimp.framework.log.Logger;
	import com.shrimp.framework.ui.controls.Alert;
	import com.shrimp.utils.FileUtils;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.filesystem.File;

	/**
	 *	程序 加载器 
	 * @author Sol
	 * 
	 */	
	public class AppLoader
	{
		/** 具体的加载器*/
		private var xmlLoader:XMLLoader;
		
		/**	appLoader 加载器初始化状态*/
		private var initialized:Boolean=false;
		public function AppLoader()
		{
		}
		
		public function init():void
		{
			xmlLoader = new XMLLoader();
			NResponder.add(AppCMD.LOAD_ONE_COMPLETE,onOneComplete);
			NResponder.add(AppCMD.LOAD_FOLDER_ALL_COMPLETE,onAllComplete);
			initialized = true;
		}
		
		public function start():void
		{
			//加载器还没有初始化
			if(initialized == false)
			{
				Alert.show("AppLoader 加载器还没有初始化,请调用init函数");
				return;
			}
			
			
			var obj:Object = EditorConfig.configFolder.shift();
			//全部取完了
			if(obj == null)
			{
				
				trace("所有配置文件全部加载完成");
				NResponder.dispatch(AppCMD.LOAD_ALL_COMPLETE);
				return;
			}
			//配置文件 存放目录
			var path:String = obj.folder;
			var type:String = obj.type;
			
			//获取到配置文件夹
			var f:File = new File(File.applicationDirectory.nativePath+"/"+path);
			if(!f.exists)
			{
				Logger.getLogger("APPLOADER").info("bin目录不存在:"+path+"的文件夹");
				return;
			}
			
			FileUtils.clearCache();
			FileUtils.getFileArr(f.nativePath);
			var files:Array = FileUtils.getAllFiles();
			
			//加载配置文件目录长度为空
			if(files.length == 0)
			{
				Logger.getLogger("APPLOADER").info("加载器内容长度为0,全部加载完成");
				return;
			}
			
			xmlLoader.urls = files;
			xmlLoader.type = type;
			
			xmlLoader.startLoad();
		}
		
		/**
		 *	单个文件加载我那称 
		 * @param item	加载对象
		 * @param content	加载对象的内容
		 * @param type	加载的对象的类型.会根据此类型进行相关的解析工作
		 * 
		 */		
		private function onOneComplete(item:Object,content:Object,type:String):void
		{
			trace(item,type);
		}
		
		private function onAllComplete():void
		{
			start();
		}
	}
}