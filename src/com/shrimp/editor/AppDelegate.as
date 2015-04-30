package com.shrimp.editor
{
	import appkit.responders.NResponder;
	
	import com.shrimp.AppCMD;
	import com.shrimp.framework.managers.StageManager;
	import com.shrimp.framework.ui.controls.core.Component;
	
	import flash.errors.IllegalOperationError;

	public class AppDelegate
	{
		
		private static var _instance:AppDelegate;
		
		public static function getInstance():AppDelegate
		{
			if(!_instance)
			{
				_instance = new AppDelegate();
			}
			
			return _instance;
		}
		
		public function AppDelegate()
		{
			if(_instance)
			{
				throw new IllegalOperationError("不可实例化单例 类 AppDelegate");
				return;
			}
			
			_instance = this;
			NResponder.add(AppCMD.COMP_PROPERTY_CHANGED,targetPropertyChanged);
		}
		
		private var _target:*;
		/**	
		 * 当前操作的对象
		 * <p/><b>target only inherit from Component</b>
		 */
		public function get target():*
		{
			return _target;
		}
		
		public function set target(value:*):void
		{
			_target = value;
		}
		
		private function targetPropertyChanged(property:String,value:*):void
		{
			if(target == null)
			{
				return;
			}
			
			if(target[property]!=null)
			{
				target[property] = value;
			}
			
//			(target as Component).invalidateProperties();
//			(target as Component).invalidateSize();
//			(target as Component).invalidateDisplayList();
			
			StageManager.stage.invalidate();
		}
		
	}
}