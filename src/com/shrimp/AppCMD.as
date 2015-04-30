package com.shrimp
{
	import flash.errors.IllegalOperationError;

	/**
	 *	程序常量类 
	 * @author Sol
	 * 
	 */	
	public class AppCMD
	{
		public function AppCMD()
		{
			throw new IllegalOperationError("常量类不可初始化");
		}
		
		private static const app:String = "app_";
		
		//加载器  常量  段
		private static const loader:String = app+"loader_";
		
		//加载一个完成
		public static const LOAD_ONE_COMPLETE:String = loader + "load_one_complete";
		
		//文件夹内文件加载完成
		public static const LOAD_FOLDER_ALL_COMPLETE:String = loader + "load_folder_all_complete";
		
		//所有配置文件加载完成
		public static const LOAD_ALL_COMPLETE:String = loader + "load_all_complete";
		
		private static const comp:String = app+"comp_";
		/**	组件属性变更*/
		public static const COMP_PROPERTY_CHANGED:String = comp + "property_changed";
	}
}