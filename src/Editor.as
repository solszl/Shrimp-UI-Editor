package
{
	import com.shrimp.editor.comps.HRadio;
	import com.shrimp.editor.comps.HTextInput;
	import com.shrimp.editor.comps.PromptTextInput;
	import com.shrimp.editor.xml.XMLLoader;
	import com.shrimp.framework.core.ApplicationBase;
	import com.shrimp.framework.load.LoaderManager;
	import com.shrimp.framework.load.ResourceLoader;
	import com.shrimp.framework.managers.StageManager;
	import com.shrimp.framework.ui.controls.Button;
	import com.shrimp.utils.FileUtils;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.system.ApplicationDomain;
	
	[SWF(frameRate="60",width="1280",height="800",backgroundColor="#c7EDCC")]
	public class Editor extends ApplicationBase
	{
		public function Editor()
		{
			addEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		private var recentDocuments:Array =  
			new Array(new File("app-storage:/GreatGatsby.pdf"),  
				new File("app-storage:/WarAndPeace.pdf"),  
				new File("app-storage:/Iliad.pdf")); 
		
		protected function onEnter(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME,onEnter);
			
			//初始化舞台基类
			StageManager.init(this);
			
			var ht:HTextInput = new HTextInput();
			ht.propertyName = "x";
			ht.propertyValue = "120";
			addChild(ht);
			
			var hr:HRadio = new HRadio();
			hr.propertyName = "algin";
			hr.propertyValue = ["left","center","right"];
			hr.propertyDefaultValue = 1;
			hr.y = 25;
			addChild(hr);
			
			var btn:Button = new Button(this);
			btn.label = "浏览...";
			btn.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var file:File=new File();
			file.browseForDirectory("浏览文件夹");
			file.addEventListener(Event.SELECT,onFileSelect);
		}
		
		protected function onFileSelect(event:Event):void
		{
			var f:File = event.target as File;
			FileUtils.getFileArr(f.url);
			
			
			var loader:XMLLoader = new XMLLoader();
			loader.urls = FileUtils.getAllFiles();
			loader.startLoad();
			
//			var url:String = FileUtils.getAllFiles()[0];
//			LoaderManager.loadBYTE(url,onItemComplete);
//				
//			trace(FileUtils.getAllFiles().length);
		}
		
		private function onItemComplete(item:Object, content:Object, domain:ApplicationDomain):void
		{
//			switch(item)
			trace(content);
		}
	}
}