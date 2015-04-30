package com.shrimp.editor.comps
{
	import appkit.responders.NResponder;
	
	import com.shrimp.AppCMD;
	import com.shrimp.framework.ui.container.HBox;
	import com.shrimp.framework.ui.controls.Label;
	import com.shrimp.framework.ui.controls.RadioButton;
	import com.shrimp.framework.ui.controls.box.RadioButtonGroup;
	import com.shrimp.framework.ui.layout.HorizontalLayout;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 *	 
	 * @author Sol
	 * 
	 */	
	public class HRadio extends HBox
	{
		// 属性名字
		private var lblPropertyName:Label;
		
		private var rbgPropertyValue:RadioButtonGroup;
		
		public function HRadio(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
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
			
			rbgPropertyValue = new RadioButtonGroup("",this);
			rbgPropertyValue.layout = new HorizontalLayout();
			rbgPropertyValue.addEventListener(Event.CHANGE,onChanged);
		}
		
		/**
		 *	设置属性名字 
		 * @param value
		 * 
		 */		
		public function set propertyName(value:String):void
		{
			lblPropertyName.text = value;
			
			//同时设置 单选框组名称
			rbgPropertyValue.groupName = value;
		}
		
		/**
		 *	设置属性预选值 
		 * @param value
		 * 
		 */		
		public function set propertyValue(value:Array):void
		{
			rbgPropertyValue.dataProvider = value;
			rbgPropertyValue.validateNow();
		}
		
		/**
		 *	设置默认属性索引
		 * @param index
		 * 
		 */		
		public function set propertyDefaultValue(index:int):void
		{
			rbgPropertyValue.selectedIndex = index;
		}
		
		protected function onChanged(event:Event):void
		{
			var rbg:RadioButtonGroup = event.target as RadioButtonGroup;
			var property:String = rbg.selectedItem.label;
			NResponder.dispatch(AppCMD.COMP_PROPERTY_CHANGED,[lblPropertyName.text,property]);
		}
	}
}