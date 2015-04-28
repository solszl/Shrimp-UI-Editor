package com.shrimp.editor.comps
{
	import com.shrimp.framework.ui.controls.TextInput;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	
	/**
	 *	带有提示问题的输入框 
	 * @author Sol
	 * 
	 */	
	public class PromptTextInput extends TextInput
	{
		
		// 没有文字的时候  prompt 文字颜色
		private const NONE_TEXT_ALPHA:Number = 0.6;
		public function PromptTextInput(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_textField.addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
			_textField.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
		}
		
		protected function onFocusOut(event:FocusEvent=null):void
		{
			if (_text.length == 0 || _text == promote)
			{
				_textField.textColor=promoteColor;
				_textField.alpha = NONE_TEXT_ALPHA;
				text=promote;
			}
		}
		
		protected function onFocusIn(event:FocusEvent=null):void
		{
			if (_text == promote)
			{
				_textField.textColor=color as uint;
				_textField.alpha = 1;
				text='';
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (_promoteChanged)
			{
				_promoteChanged=false;
				if (_text.length == 0)
				{
					_textField.textColor=promoteColor;
					_textField.alpha = NONE_TEXT_ALPHA;
					_textField.text=_promote;
					_text=_promote;
				}
			}
		}
		
		//默认文本
		private var _promote:String="promote";
		//默认文本颜色
		private var promoteColor:uint=0x86A0A8;
		
		public function get promote():String
		{
			return _promote;
		}
		
		private var _promoteChanged:Boolean;
		public function set promote(value:String):void
		{
			if(_promote == value)
				return;
			
			_promote = value;
			
			_promoteChanged = true;
			invalidateProperties();
			invalidateSize();
		}
		
		override public function get text():String
		{
			if (_text == _promote)
				return '';
			return _text;
		}
	}
}