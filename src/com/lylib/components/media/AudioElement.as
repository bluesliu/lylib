package com.lylib.components.media
{
	import com.lylib.events.MediaElementEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	/**
	 * 当声音播放时，每隔一段时间会派发这个事件，用来检测声音的下载进度和播放进度
	 */
	[Event(name="timer", type="com.lylib.events.MediaElementEvent")]
	
	public class AudioElement extends EventDispatcher
	{
		private var _sound:Sound;
		private var _buffer:SoundLoaderContext;
		private var _channel:SoundChannel;
		private var _timer:Timer;
		
		private var _onProgressHandler:Function;
		private var _onTimerHandler:Function;
		
		//当前播放声音文件的地址
		private var _url:String;
		//缓冲时间（以毫秒为单位）。
		private var _bufferTime:int = 5000;
		
		//当前是否正在播放
		private var _playing:Boolean = false;
		
		//播放循环模式
		private var _playMode:PlayMode = PlayMode.SINGLE;
		//是否自动播放
		private var _autoPlay:Boolean = false;
		
		//获得声音文件的大小
		private var _bytesTotal:Number;
		private var _bytesLoaded:Number;
		//声音的时间长度（以毫秒为单位）。
		private var _timeTotal:Number;
		//声音文件中当前播放的位置（以毫秒为单位）。
		private var _position:Number;
		//缓冲比(0~1)		
		private var _percentBuffered:Number;
		//播放比(0~1)
		private var _percentPlayed:Number;
		
		//声音列表
		private var _playList:Array;
		
		public function AudioElement()
		{
			//_sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			//_sound.addEventListener(Event.OPEN, onOpen);
			//_sound.addEventListener(Event.COMPLETE, onComplete);
			
			_buffer = new SoundLoaderContext(_bufferTime);
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		/**
		 * 打开要加载的声音文件，这个方法并不会播放声音，只是准备播放
		 * @param url	声音文件的地址
		 */		
		public function open(url:String):void
		{
			_url = url;
			
			if(_sound!=null){
				try{
					_sound.close();	//关闭之前的下载流
				}catch(err:Error){
					
				}
			}
			_sound = new Sound();
			//_sound.addEventListener(ProgressEvent.PROGRESS, onProgress);
			
			_sound.load(new URLRequest(url), _buffer);
			
			if(autoPlay){
				play();
			}
		}
		
		/**
		 * 播放声音
		 * @param startTime		应开始回放的初始位置（以毫秒为单位）。
		 */		
		public function play(startTime:Number=0):void
		{
			_position = startTime;
			if(_channel!=null){
				_channel.stop();
			}
			_channel = _sound.play(startTime);
			//_channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_timer.start();
			
			_playing = true;
		}
		
		
		
		/**
		 * 暂停
		 */		
		public function pause():void
		{
			if(_playing){
				_timer.stop();
				
				_position = _channel.position;
				_channel.stop();
				
				_playing = false;
			}
		}
		
		
		/**
		 * 恢复暂停的声音
		 */		
		public function resume():void
		{
			if(_playing==false)
			{
				_timer.start();
				_channel = _sound.play(_position);
				_playing = true;
			}
		}
		
		
		/**
		 * 将暂停的声音恢复播放,将播放的声音暂停
		 */		
		public function playOrPause():void 
		{
			if(_playing) {
				_timer.stop();
				_position = _channel.position;
				_channel.stop( );
			}
			else {
				_timer.start();
				_channel = _sound.play(_position);
			}
			_playing = !_playing;
		}
		
		//流错误
		protected function onIOError(event:IOErrorEvent):void
		{
			trace(event.text);
		}
		
		protected function onOpen(event:Event):void
		{
		}
		
		protected function onComplete(event:Event):void
		{
		}
		
		//声音缓冲进度
		protected function onProgress(event:ProgressEvent):void
		{
			_bytesTotal = event.bytesTotal;
			_bytesLoaded = event.bytesLoaded;
			_percentBuffered = _bytesLoaded/_bytesTotal;
			trace(_percentBuffered*100);
			
			if(onProgressHandler!=null){
				onProgressHandler(_bytesLoaded,_bytesTotal);
			}
		}
		
		//声音播放结束
		protected function onSoundComplete(event:Event):void
		{
			trace("onSoundComplete");
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			_bytesLoaded = _sound.bytesLoaded;
			_bytesTotal = _sound.bytesTotal;
			_timeTotal = _sound.length;
			_position = _channel.position;
			
			if(_bytesTotal > 0) 
			{
				_percentBuffered = _bytesLoaded / _bytesTotal;
				_timeTotal /= _percentBuffered;
				_percentPlayed = _position / _timeTotal;
				
				var evt:MediaElementEvent = new MediaElementEvent(MediaElementEvent.TIMER);
				evt.bytesLoaded = _bytesLoaded;
				evt.bytesTotal = _bytesTotal;
				evt.timeTotal = _timeTotal;
				evt.position = _position;
				evt.percentBuffered = _percentBuffered;
				evt.percentPlayed = _percentPlayed;
				this.dispatchEvent(evt);
			}
		}

		
		/**
		 * 下载进度，接收两个参数bytesLoaded和bytesTotal
		 * @return 
		 */		
		public function get onProgressHandler():Function
		{
			return _onProgressHandler;
		}
		public function set onProgressHandler(value:Function):void
		{
			_onProgressHandler = value;
		}

		/**
		 * 是否自动播放
		 * @return 
		 * 
		 */		
		public function get autoPlay():Boolean
		{
			return _autoPlay;
		}
		public function set autoPlay(value:Boolean):void
		{
			_autoPlay = value;
		}

		public function get onTimerHandler():Function
		{
			return _onTimerHandler;
		}
		public function set onTimerHandler(value:Function):void
		{
			_onTimerHandler = value;
		}


	}
}