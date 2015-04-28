package com.shrimp.editor.comps
{
	import com.shrimp.framework.ui.container.HBox;
	import com.shrimp.framework.ui.controls.Label;
	
	import flash.display.DisplayObjectContainer;
	
	public class HTextInput extends HBox
	{
		// 属性名字
		private var lblPropertyName:Label;
		
		// 文字输入
		private var tiPromptInput:PromptTextInput;
		
		public function HTextInput(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			lblPropertyName = new Label(this);
			//为 了 美观
			lblPropertyName.width = 100;
			lblPropertyName.fontSize = 18;
			lblPropertyName.bold = true;
			
			tiPromptInput = new PromptTextInput(this);
			tiPromptInput.width = 100;
			tiPromptInput.background = true;
			tiPromptInput.backgroundColor = 0xc0c0c0;
			tiPromptInput.showBorder(0x0C0C0C);
		}
		
		/**
		 *	设置属性名字 
		 * @param value
		 * 
		 */		
		public function set propertyName(value:String):void
		{
			lblPropertyName.text = value;
		}
		
		/**
		 *	设置属性数值 
		 * @param value
		 * 
		 */		
		public function set propertyValue(value:String):void
		{
			tiPromptInput.text = value
		}
	}
}