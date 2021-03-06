package com.lylib.components.containers
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 布局面板的基类
	 * 
	 * @author	刘渊
	 * @version	1.0.1
	 */	
	public class BasePane extends Sprite
	{
		private var _paddingLeft:Number = 0;
		private var _paddingRight:Number = 0;
		private var _paddingTop:Number = 0;
		private var _paddingBottom:Number = 0;
		private var _horizontalGap:Number = 0;
		private var _verticalGap:Number = 0;
		private var _width:Number = 100;
		private var _height:Number = 100;
		private var _autoSize:Boolean = true;
		
		protected var _tempX:Number = 0;
		protected var _tempY:Number = 0;
		
		protected var _content:Sprite;
		protected var _mask:Sprite;
		
		public function BasePane()
		{
			super();
			
			_content = new Sprite();
			super.addChild(_content);
			
			_mask = new Sprite();
			super.addChild(_mask);
			
			_content.mask = _mask;

			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
			
			_mask.x = paddingLeft;
			_mask.y = paddingTop;
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0, 0, width - paddingLeft - paddingRight, height - paddingTop - paddingBottom);
			_mask.graphics.endFill();
		}

		
		
		/**
		 * 进行布局
		 */		
		public function doLayout():void
		{
			
		}
		
		
		protected function draw():void
		{
			if(!_autoSize)
			{
				return;
			}
			else
			{
				this.graphics.clear();
				this.graphics.beginFill(0x000000, 0);
				this.graphics.drawRect(0, 0, _content.width + _paddingLeft + _paddingRight, _content.height + _paddingTop + _paddingBottom);
				this.graphics.endFill();
				
				_mask.x = paddingLeft;
				_mask.y = paddingTop;
				_mask.graphics.clear();
				_mask.graphics.beginFill(0xff0000);
				_mask.graphics.drawRect(0, 0, _content.width, _content.height);
				_mask.graphics.endFill();
			}
		}
		
		public function removeAll():void
		{
			while(_content.numChildren>0){
				_content.removeChildAt(0)
			}
			_tempX = 0;
			_tempY = 0;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return addChildAt(child, _content.numChildren);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			child.x = child.y = 0;
			return _content.addChildAt(child, index);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			return _content.removeChildAt(index);
		}
		
		override public function getChildAt(index:int):DisplayObject
		{
			return _content.getChildAt(index);;
		}
		
		override public function getChildIndex(child:DisplayObject):int
		{
			return _content.getChildIndex(child);
		}
		
		override public function get numChildren():int
		{
			return _content.numChildren;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return _content.removeChild(child);
		}
		
		
		override public function getChildByName(name:String):DisplayObject
		{
			return _content.getChildByName(name);
		}
		
		override public function setChildIndex(child:DisplayObject, index:int):void
		{
			_content.setChildIndex(child, index);
		}
		
		
		//----------------------------- getter & setter ---------------------------
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		public function set paddingLeft(value:Number):void
		{
			_paddingLeft = value;
		}

		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		public function set paddingRight(value:Number):void
		{
			_paddingRight = value;
		}

		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		public function set paddingTop(value:Number):void
		{
			_paddingTop = value;
		}

		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		public function set paddingBottom(value:Number):void
		{
			_paddingBottom = value;
		}

		public function get horizontalGap():Number
		{
			return _horizontalGap;
		}
		public function set horizontalGap(value:Number):void
		{
			_horizontalGap = value;
		}

		public function get verticalGap():Number
		{
			return _verticalGap;
		}
		public function set verticalGap(value:Number):void
		{
			_verticalGap = value;
		}

		override public function get width():Number
		{
			return _width;
		}
		override public function set width(value:Number):void
		{
			_width = value;
		}

		override public function get height():Number
		{
			return _height;
		}
		override public function set height(value:Number):void
		{
			_height = value;
		}

		
		/**
		 * 是否自适应内容的尺寸
		 * @return 
		 */		
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		public function set autoSize(value:Boolean):void
		{
			_autoSize = value;
			
			if(_autoSize == false)
			{
				this.graphics.clear();
				this.graphics.beginFill(0x000000, 0.5);
				this.graphics.drawRect(0, 0, width, height);
				this.graphics.endFill();
				
				_mask.x = paddingLeft;
				_mask.y = paddingTop;
				_mask.graphics.clear();
				_mask.graphics.beginFill(0xff0000);
				_mask.graphics.drawRect(0, 0, width - paddingLeft - paddingRight, height - paddingTop - paddingBottom);
				_mask.graphics.endFill();
			}
			else
			{
				this.graphics.clear();
				this.graphics.beginFill(0x000000, 0.5);
				this.graphics.drawRect(0, 0, _content.width + _paddingLeft + _paddingRight, _content.height + _paddingTop + _paddingBottom);
				this.graphics.endFill();
				
				_mask.x = paddingLeft;
				_mask.y = paddingTop;
				_mask.graphics.clear();
				_mask.graphics.beginFill(0xff0000);
				_mask.graphics.drawRect(0, 0, _content.width, _content.height);
				_mask.graphics.endFill();
			}
		}


	}
}