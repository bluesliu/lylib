package com.lylib.debug
{

import flash.events.EventDispatcher;

[Event(name="logInfoChange", type="com.lylib.debug.LoggerEvent")]

/**
 * log日志暂只分error warn info debug
 * debug调试阶段  
 * info线上阶段输出各种信息
 * warn不影响正常使用但可能出现的错误
 * error输出各种加载错误
 * error > warn > info > debug
 */
public class Logger extends EventDispatcher
{
	//==========================================================================
	//  Class variables
	//==========================================================================
	static public const LEVEL_DEBUG:int = 0;
	static public const LEVEL_INFO:int = 1;
	static public const LEVEL_WARN:int = 2;
	static public const LEVEL_ERROR:int = 3;
	
	static public var logLevel:int = LEVEL_DEBUG;
	static public var totalLogArr:Array = [];
	static public var instance:Logger = new Logger();
	
	public var levelTitleArr:Array = ["[Debug]", "[Info]", "[Warn]", "[Error]"];
	
	//==========================================================================
	//  Class Methods
	//==========================================================================
	static public function log(str:*, level:int = LEVEL_DEBUG):void
	{
		if (logLevel > level)
		{
			return;
		}
		
		var date:Date = new Date();
		
		var content:String = instance.levelTitleArr[level];
		content += "\t" + date.fullYear+"."+(date.month+1)+"."+date.date+" "+date.hours+":"+date.minutes+":"+date.seconds;
		content += "\t" + str;
		trace(content);
		content += "\n";
		
		totalLogArr.push({msg:content, level:level});
		dispatchLogEvent(content, level);
	}
	
	static public function debug(str:*, ...args):void
	{
		str += args.toString();
		log(str, LEVEL_DEBUG);
	}
	
	static public function info(str:*, ...args):void
	{
		str += args.toString();
		log(str, LEVEL_INFO);
	}
	
	static public function warn(str:*, ...args):void
	{
		str += args.toString();
		log(str, LEVEL_WARN);
	}
	
	static public function error(str:*, ...args):void
	{
		str += args.toString();
		log(str, LEVEL_ERROR);
	}
	
	static public function logObject(infoStr:*, obj:Object, level:int = LEVEL_DEBUG):void
	{
		infoStr += "\t";
		for (var props:* in obj)
		{
			infoStr += props + ":" + obj[props] + "\t";
		}
		log(infoStr, level);
	}
	
	static public function logArray(infoStr:*, arr:Array, level:int = LEVEL_DEBUG):void
	{
		infoStr += "\t";
		if (arr && arr.length)
		{
			if (typeof(arr[0]) == "object")
			{
				log(infoStr + "----------------start----------------", level);
				for (var obj:* in arr)
				{
					logObject(String(obj), arr[obj], level);
				}
				log(infoStr + "----------------end----------------", level);
			}
			else
			{
				infoStr += arr.toString();
				log(infoStr, level);
			}
		}
		else
		{
			log(infoStr, level);
		}
	}
	
	static public function clear():void
	{
		totalLogArr = [];
	}
	
	static private function dispatchLogEvent(msg:*, level:int):void
	{
		var event:LoggerEvent = new LoggerEvent(LoggerEvent.LOG_INFO_CHANGE);
		event.msg = msg;
		event.level = level;
		instance.dispatchEvent(event);
	}
}
}