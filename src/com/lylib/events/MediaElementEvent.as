package com.lylib.events
{
	import flash.events.Event;
	
	public class MediaElementEvent extends Event
	{
		static public const TIMER:String = "timer";
		
		/**
		 * 当前媒体的时间总长度（以毫秒为单位）。
		 */		
		public var timeTotal:Number;
		
		/**
		 * 当播放媒体时，position 属性指示媒体文件中当前播放的位置（以毫秒为单位）。当停止或暂停播放媒体时，position 属性指示媒体文件中上次播放的位置。 
		 */		
		public var position:Number;
		
		/**
		 * 此媒体对象中当前可用的字节数。
		 */		
		public var bytesLoaded:Number;
		
		/**
		 * 此媒体对象中总的字节数。
		 */		
		public var bytesTotal:Number;
		
		/**
		 * 此媒体对象缓冲字节比。（0~1之间的小数）
		 */		
		public var percentBuffered:Number;
		
		/**
		 * 此媒体对象已播放的时间比。（0~1之间的小数）
		 */		
		public var percentPlayed:Number;
		
		public function MediaElementEvent(type:String)
		{
			super(type, false, false);
		}
	}
}