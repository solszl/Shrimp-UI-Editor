package
{
	import com.shrimp.editor.AppDelegate;
	import com.shrimp.editor.AppLoader;
	import com.shrimp.editor.comps.HRadio;
	import com.shrimp.editor.comps.HTextInput;
	import com.shrimp.editor.xml.XMLLoader;
	import com.shrimp.framework.core.ApplicationBase;
	import com.shrimp.framework.managers.StageManager;
	import com.shrimp.framework.ui.controls.Button;
	import com.shrimp.framework.ui.controls.Image;
	import com.shrimp.utils.FileUtils;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
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
		private var btn1:Button;
		protected function onEnter(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME,onEnter);
			StageManager.init(this);
			
//			btn1 = new Button(this);
//			btn1.label = "hello....";
//			StageManager.stage.addEventListener(MouseEvent.CLICK,onStageClick);
//			
//			return;
			
			//初始化舞台基类
			
			var ht:HTextInput = new HTextInput();
			ht.propertyName = "x";
			ht.propertyValue = "120";
			addChild(ht);
			
			var ht4:HTextInput = new HTextInput();
			ht4.propertyName = "y";
			ht4.propertyValue = "120";
			ht4.y = 25;
			addChild(ht4);
			
			var ht2:HTextInput = new HTextInput();
			ht2.propertyName = "width";
			ht2.propertyValue = "120";
			ht2.y = 50;
			addChild(ht2);
			
			var ht3:HTextInput = new HTextInput();
			ht3.propertyName = "height";
			ht3.propertyValue = "120";
			ht3.y = 75;
			addChild(ht3);
			
			var hr:HRadio = new HRadio();
			hr.propertyName = "labelAlign";
			hr.propertyValue = ["top-left","top-center","top-right","middle-left","middle-center","middle-right","bottom-left","bottom-center","bottom-right"];
			hr.propertyDefaultValue = 1;
			hr.y = 100;
//			addChild(hr);
			
			
			var app_loader:AppLoader = new AppLoader();
			app_loader.init();
			app_loader.start();
			
			var img:Image = new Image(this);
			img.source = "http://bbs.9ria.com/static/image/common/pn_reply.png";
			
//			var btn:Button = new Button(this);
//			btn.label = "浏览...";
//			btn.addEventListener(MouseEvent.CLICK,onClick);
			
			AppDelegate.getInstance().target = img;
		}
		
		protected function onStageClick(event:MouseEvent):void
		{
			var w:int = Math.floor(Math.random()*200)+30;
			btn1.width = w;
			btn1.label = w.toString();
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
		}
	}
}