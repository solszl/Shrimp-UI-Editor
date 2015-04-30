package com.shrimp.editor.comps
{
	import appkit.responders.NResponder;
	
	import com.shrimp.AppCMD;
	import com.shrimp.framework.ui.container.HBox;
	import com.shrimp.framework.ui.controls.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	
	public class HTextInput extends HBox
	{
		// 属性名字
		private var lblPropertyName:Label;
		
		// 文字输入
		private var tiPromptInput:PromptTextInput;
		
		private var _propertyName:String;
		
		private var _propertyValue:String;
		
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
			tiPromptInput.restrict = '[0-9]'
			
			//添加  接入焦点,失去焦点,点击按钮的事件
			tiPromptInput.addEventListener(FocusEvent.FOCUS_IN,onInputFocusIn);
			tiPromptInput.addEventListener(FocusEvent.FOCUS_OUT,onInputFocusOut);
			tiPromptInput.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		
		/**
		 *	设置属性名字 
		 * @param value
		 * 
		 */		
		public function set propertyName(value:String):void
		{
			lblPropertyName.text = value;
			//记录属性名字
			_propertyName = lblPropertyName.text;
		}
		
		/**
		 *	设置属性数值 
		 * @param value
		 * 
		 */		
		public function set propertyValue(value:String):void
		{
			tiPromptInput.text = value
			_propertyValue = value;
		}
		
		//记录临时变量值,防止过度刷新
		private var tempValue:String;
		protected function onInputFocusIn(event:FocusEvent=null):void
		{
			tempValue = tiPromptInput.text;
		}
		
		protected function onInputFocusOut(event:FocusEvent=null):void
		{
			if(tempValue == tiPromptInput.text)
			{
				return;
			}
			
			tempValue = tiPromptInput.text;
			_propertyValue = tiPromptInput.text;
			dispatchProperty();
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.ENTER)
			{
				onInputFocusOut();
			}
		}
		
		/** 派发属性*/
		private function dispatchProperty():void
		{
			//派发 属性名字 和 属性值
			NResponder.dispatch(AppCMD.COMP_PROPERTY_CHANGED,[_propertyName,_propertyValue]);
		}
	}
}