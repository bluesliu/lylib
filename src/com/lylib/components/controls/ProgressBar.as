package com.lylib.components.controls
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * 进度条
	 */	
	public class ProgressBar extends Sprite
	{
		private var _backgroundSkin:Shape;
		private var _secondarySkin:Shape;
		private var _progressSkin:Shape;
		
		private var _width:Number;
		private var _height:Number;
		
		private var _maxValue:Number = 1;
		private var _progressValue:Number = 0;
		private var _ratio:Number = 0;						//第一进度条比率
		private var _secondaryProgressValue:Number = 0;
		private var _secondaryRatio:Number = 0;				//第二进度条比率
		
		/**
		 * @param width				宽度
		 * @param height			高度
		 * @param backgroundSkin	进度条背景皮肤
		 * @param progressSkin		第一进度条皮肤
		 * @param secondarySkin		第二进度条皮肤
		 */		
		public function ProgressBar(width:Number=400, height:Number=20, 
									backgroundSkin:Shape=null, progressSkin:Shape=null, secondarySkin:Shape=null)
		{
			this._width = width;
			this._height = height;
			
			if(backgroundSkin){
				_backgroundSkin = backgroundSkin;
				_backgroundSkin.width = width;
				_backgroundSkin.height = height;
			}else{
				this._backgroundSkin = getSkin(width,height,0x343434);
			}
			addChild(_backgroundSkin);
			
			if(secondarySkin){
				_secondarySkin = secondarySkin; 
				_secondarySkin.height = height;
				_secondarySkin.width = width;
			}else{
				this._secondarySkin = getSkin(width,height,0x666666);
			}
			addChild(_secondarySkin);
			setSecondaryProgressValue(0);
			
			if(progressSkin){
				_progressSkin = progressSkin; 
				_progressSkin.height = height;
				_progressSkin.width = width;
			}else{
				this._progressSkin = getSkin(width,height,0xff6600);
			}
			addChild(_progressSkin);
			setProgressValue(0);
		}
		
		
		
		/**
		 * 设置第一进度条的值，在现实列表中第一进度条在第二进度条的上面，
		 * 所以当它的值比第二进度条大时，用户就看不见第二进度条了
		 * @param value		进度值
		 * @return 			进度值
		 */		
		public function setProgressValue(value:Number):Number
		{
			_progressValue = value;
			_ratio = _progressValue / _maxValue;
			
			if(_ratio <= 0)
			{
				_progressValue = 0;
				_ratio = 0;
				_progressSkin.width = 0;
				_progressSkin.visible = false;
			}
			else if(_progressValue >= _maxValue)
			{
				_progressValue = _maxValue;
				_ratio = 1;
				_progressSkin.visible = true;
				_progressSkin.width = _width;
			}
			else
			{
				_progressSkin.visible = true;
				_progressSkin.width = _ratio * _width;
			}
			
			return _progressValue;
		}
		
		

		/**
		 * 设置第二进度条的值
		 * @param value		进度值
		 * @return 			进度值
		 */		
		public function setSecondaryProgressValue(value:Number):Number
		{
			_secondaryProgressValue = value;
			_secondaryRatio = _secondaryProgressValue / _maxValue;
			
			if(_secondaryRatio <= 0)
			{
				_secondaryProgressValue = 0;
				_secondaryRatio = 0;
				_secondarySkin.width = 0;
				_secondarySkin.visible = false;
			}
			else if(_secondaryProgressValue >= _maxValue)
			{
				_secondaryProgressValue = _maxValue;
				_secondaryRatio = 1;
				_secondarySkin.visible = true;
				_secondarySkin.width = _width;
			}
			else
			{
				_secondarySkin.visible = true;
				_secondarySkin.width = _secondaryRatio * _width;
			}
			
			return _secondaryProgressValue;
		}
		
		
		/**
		 * 设置第一进度条的比率值
		 * @param ratio		比率（0 ~ 1 之间的小数）
		 * @return 			比率（0 ~ 1 之间的小数）
		 */
		public function setRatio(ratio:Number):Number
		{
			_ratio = ratio;
			
			if(_ratio < 0)
			{
				_ratio = 0;
			}
			else if(_ratio > 1)
			{
				_ratio = 1;
			}
			
			setProgressValue( _ratio * _maxValue );
			
			return _ratio;
		}
		
		
		/**
		 * 设置第二进度条比率值
		 * @param rotio
		 * @return 
		 * 
		 */		
		public function setSecondaryRotio(rotio:Number):Number
		{
			_secondaryRatio = rotio;
			
			if(_secondaryRatio < 0)
			{
				_secondaryRatio = 0;
			}
			else if(_secondaryRatio > 1)
			{
				_secondaryRatio = 1;
			}
			
			setSecondaryProgressValue( _secondaryRatio * _maxValue );
			
			return _secondaryRatio;
		}
		
		
		
		/**
		 * 第一进度条的进度值
		 * @return 
		 * 
		 */		
		public function getPprogressValue():Number
		{
			return _progressValue;
		}
		
		
		/**
		 * 第二进度条的进度值
		 * @return 
		 * 
		 */		
		public function getSecondaryProgressValue():Number
		{
			return _secondaryProgressValue;
		}
		
		
		/**
		 * 第一进度条的比例值
		 * @return 
		 * 
		 */		
		public function getRatio():Number
		{
			return _ratio;
		}
		
		
		/**
		 * 第二进度条的比例值
		 * @return 
		 * 
		 */		
		public function getSecondaryRatio():Number
		{
			return _secondaryRatio;
		}
		
		
		
		
		protected function getSkin(width:Number, height:Number, color:uint):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(0,0,width,height);
			shape.graphics.endFill();
			return shape;
		}

		
		//-----------------------------------  getter & setter -------------------------------------//
		
		/**
		 * 最大值
		 * @return 
		 */		
		public function get maxValue():Number
		{
			return _maxValue;
		}
		public function set maxValue(value:Number):void
		{
			_maxValue = value;
		}
		
		override public function get height():Number
		{
			return this._height;
		}
		override public function set height(value:Number):void
		{
			this._height = value;
			
			this._backgroundSkin.height = value;
			this._secondarySkin.height = value;
			this._progressSkin.height = value;
		}
		
		override public function get width():Number
		{
			return this._width;
		}
		override public function set width(value:Number):void
		{
			this._width = value;
			
			this._backgroundSkin.width = value;
			this._secondarySkin.width = value;
			this._progressSkin.width = value;
		}

		
		/**
		 * 进度条背景皮肤
		 * @return 
		 * 
		 */		
		public function get backgroundSkin():Shape
		{
			return _backgroundSkin;
		}
		public function set backgroundSkin(value:Shape):void
		{
			_backgroundSkin = value;
		}

		/**
		 * 第二进度条皮肤
		 * @return 
		 * 
		 */		
		public function get secondarySkin():Shape
		{
			return _secondarySkin;
		}
		public function set secondarySkin(value:Shape):void
		{
			_secondarySkin = value;
		}

		
		/**
		 * 第一进度条皮肤
		 * @return 
		 * 
		 */		
		public function get progressSkin():Shape
		{
			return _progressSkin;
		}
		public function set progressSkin(value:Shape):void
		{
			_progressSkin = value;
		}


	}
}