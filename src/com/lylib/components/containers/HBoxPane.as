package com.lylib.components.containers
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 水平方向布局容器
	 * 
	 * @author	刘渊
	 * @version	1.0.1
	 */	
	public class HBoxPane extends BasePane
	{
		
		
		public function HBoxPane()
		{
			super();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			/*super.addChild( child );
			
			if(_content.numChildren == 1)
			{
				child.x = paddingLeft + _tempX - child.getRect(_content).left;
			}
			else
			{
				child.x = _tempX - child.getRect(_content).left;
			}

			_tempX = child.getRect(_content).left + child.getRect(_content).width + horizontalGap;
			
			child.y = paddingTop - child.getRect(_content).top;
			
			draw();
			
			return child;*/
			
			return addChildAt(child, _content.numChildren);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			super.addChildAt(child, index);
			
			if(_content.numChildren == 1)
			{
				child.x = paddingLeft + _tempX - child.getRect(_content).left;
			}
			else
			{
				child.x = _tempX - child.getRect(_content).left;
			}
			
			_tempX = child.getRect(_content).left + child.getRect(_content).width + horizontalGap;
			
			child.y = paddingTop - child.getRect(_content).top;
			
			draw();
			
			return child;
		}
	}
}