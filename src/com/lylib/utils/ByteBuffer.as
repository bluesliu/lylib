package com.lylib.utils
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;

	public class ByteBuffer extends ByteArray
	{
		protected var limitCapacity:int = -1;
		
		public function allocate(capacity:int):void
		{
		  limitCapacity = length = capacity;
		  position = 0;
		}
		
		public function get limit():int
		{
			return limitCapacity;
		}
		
		public function fill(input:IDataInput):void
		{
			if(limitCapacity != 0)
			{
		   		input.readBytes(this,0,limitCapacity);
			}
		}
		
		public function copyToByteArray():ByteArray
		{
			var bytes:ByteArray = new ByteArray;
			position = 0;
			readBytes(bytes,0,limitCapacity);
			return bytes;
		}
		
		public function get buffLen():int
		{
			if(limitCapacity == -1)
			return bytesAvailable;
			return limitCapacity-position;
		}
	}
}