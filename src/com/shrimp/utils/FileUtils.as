package com.shrimp.utils
{
	import flash.filesystem.File;

	public class FileUtils
	{
		public function FileUtils()
		{
		}

		private static var sysFile:File; // = new File();
		private static var fileURLs:Array=[];
		private static var key:int; //递归结束标志

		public static function getFileArr(_url:String=""):void
		{
			key++;
			if (_url != "")
			{
				sysFile=new File(_url);
			}
			var arr:Array=sysFile.getDirectoryListing();
			var leg:int=arr.length;
			for (var i:int=0; i < leg; i++)
			{
				var file:File=arr[i] as File;
				if (file.isDirectory)
				{
					getFileArr(file.url);
				}
				else
				{
					fileURLs.push(decodeURI(file.nativePath));
				}
			}
			key--;
			if (key == 0)
			{
				//判断递归是否结束
				Idone();
			}
		}

		private static function Idone():void
		{
			trace(fileURLs.join("\n"));
		}
		
		public static function getAllFiles():Array
		{
			return fileURLs;
		}
		
		public static function clearCache():void
		{
			fileURLs = [];
		}
		/**
		 *	根据文件路径,返回file文件 
		 * @param path
		 * @return 
		 * 
		 */		
		public static function getFile(path:String):File
		{
			var f:File = new File(path);
			if(f.exists)
			{
				return f;
			}
			
			return null;
		}
	}
}
