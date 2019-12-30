package com.lylib.components.media
{
	/**
	 * 播放模式
	 */	
	public class PlayMode
	{
		private var _value:int;
		
		/**
		 * 单媒体播放
		 */		
		static public const SINGLE:PlayMode = new PlayMode(0);
		
		/**
		 * 单媒体循环
		 */		
		static public const REPEAT:PlayMode =  new PlayMode(1);
		
		/**
		 * 顺序播放
		 */		
		static public const ORDER:PlayMode = new PlayMode(2);
		
		/**
		 * 循环播放
		 */		
		static public const CYCLE:PlayMode = new PlayMode(3);
		
		/**
		 * 随机播放
		 */
		static public const RANDOM:PlayMode = new PlayMode(4);
		
		public function PlayMode(value:int)
		{
			_value = value;
		}

		
		
		public function toString() : String
		{
			switch(_value)
			{
				case 0:
				{
					return "单媒体播放";
				}
				case 1:
				{
					return "单媒体循环";
				}
				case 2:
				{
					return "顺序播放";
				}
				case 3:
				{
					return "循环播放";
				}
				case 4:
				{
					return "随机播放";
				}
				default:
				{
					break;
				}
			}
			return "End";
		}
		
		
		public function get value():int
		{
			return _value;
		}

		public function set value(value:int):void
		{
			_value = value;
		}

	}
}