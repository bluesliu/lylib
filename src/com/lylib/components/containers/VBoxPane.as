package com.lylib.components.containers
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 垂直方向布局容器
	 * 
	 * @author	刘渊
	 * @version	1.0.1
	 */	
	public class VBoxPane extends BasePane
	{
		
		
		public function VBoxPane()
		{
			super();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			/*super.addChild( child );
			
			if(_content.numChildren == 1)
			{
				child.y = paddingTop + _tempY - child.getRect(_content).top;
			}
			else
			{
				child.y = _tempY - child.getRect(_content).top;
			}

			_tempY = child.getRect(_content).top + child.getRect(_content).height + verticalGap;
			
			child.x = paddingLeft - child.getRect(_content).left;
			
			draw();
			
			return child;*/
			
			return addChildAt(child, _content.numChildren);
		}
		
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			super.addChildAt(child,index);
			
			if(_content.numChildren == 1)
			{
				child.y = paddingTop + _tempY - child.getRect(_content).top;
			}
			else
			{
				child.y = _tempY - child.getRect(_content).top;
			}
			
			_tempY = child.getRect(_content).top + child.getRect(_content).height + verticalGap;
			
			child.x = paddingLeft - child.getRect(_content).left;
			
			draw();
			
			return child;
		}
	}
}