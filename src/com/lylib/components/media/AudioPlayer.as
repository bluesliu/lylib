package com.lylib.components.media
{
	import com.lylib.components.controls.ProgressBar;
	import com.lylib.events.MediaElementEvent;
	import com.lylib.utils.NumberFormatter;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class AudioPlayer extends Sprite
	{
		protected var _audio:AudioElement;
		//进度条
		protected var _progressBar:ProgressBar;
		
		protected var _format:NumberFormatter;
		
		public function AudioPlayer()
		{
			_audio = new AudioElement();
			_audio.autoPlay = true;
			_audio.onProgressHandler = onProgress;
			_audio.onTimerHandler = onTimer;
			_audio.addEventListener(MediaElementEvent.TIMER, onTimer);
			
			_progressBar = new ProgressBar();
			addChild(_progressBar);
		}
		
		public function open(url:String):void
		{
			_audio.open(url);
		}
		
		
		
		protected function onTimer(event:MediaElementEvent):void
		{
			_progressBar.setSecondaryRotio(event.percentBuffered);
			_progressBar.setRatio(event.percentPlayed);
			trace(int(event.position/1000)/60, int(event.timeTotal/1000)/60)
		}
		
		private function onProgress(loaded:Number, total:Number):void
		{
			_progressBar.setSecondaryRotio(loaded/total);
		}
		
	}
}