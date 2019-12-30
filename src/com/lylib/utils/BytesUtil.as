package com.lylib.utils
{
    import flash.utils.ByteArray;

    public class BytesUtil
	{
        public static function directWriteInt (buf:ByteArray, position:uint, value:int):void 
		{
            var pos:uint = buf.position;
            buf.position = position;
            buf.writeInt(value);
            buf.position = pos;
        }

        public static function directWriteUint (buf:ByteArray, position:uint, value:uint):void 
		{
            var pos:uint = buf.position;
            buf.position = position;
            buf.writeUnsignedInt(value);
            buf.position = pos;
        }

        public static function directWriteSmallint (buf:ByteArray, position:uint, value:int):void 
		{
            var pos:uint = buf.position;
            buf.position = position;
            buf.writeShort(value);
            buf.position = pos;
        }
		
        public static function directWriteTinyint (buf:ByteArray, position:uint, value:uint):void 
		{
            var pos:uint = buf.position;
            buf.position = position;
            buf.writeByte(value);
            buf.position = pos;
        }
		
        public static function directReadInt (buf:ByteArray, position:uint):int 
		{
            var ret:int;
            var pos:uint = buf.position;
            buf.position = position;
            ret = buf.readInt();
            buf.position = pos;

            return ret;
        }

        public static function directReadUint (buf:ByteArray, position:uint):uint 
		{
            var ret:uint;
            var pos:uint = buf.position;
            buf.position = position;
            ret = buf.readUnsignedInt();
            buf.position = pos;

            return ret;
        }

        public static function directReadSmallint (buf:ByteArray, position:uint):int
		{
            var ret:int;
            var pos:uint = buf.position;
            buf.position = position;
            ret = buf.readShort();
            buf.position = pos;

            return ret;
        }

        public static function directReadSmalluint (buf:ByteArray, position:uint):int 
		{
            var ret:int;
            var pos:uint = buf.position;
            buf.position = position;
            ret = buf.readUnsignedShort();
            buf.position = pos;

            return ret;
        }

        public static function directReadTinyint (buf:ByteArray, position:uint):int 
		{
            var ret:int;
            var pos:uint = buf.position;
            buf.position = position;
            ret = buf.readByte();
            buf.position = pos;

            return ret;
        }

        public static function directReadTinyuint (buf:ByteArray, position:uint):int
		{
            var ret:int;
            var pos:uint = buf.position;
            buf.position = position;
            ret = buf.readUnsignedByte();
            buf.position = pos;

            return ret;
        }
    }
}
