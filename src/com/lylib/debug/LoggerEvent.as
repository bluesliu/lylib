package com.lylib.debug
{
import flash.events.Event;

public class LoggerEvent extends Event
{
	//==========================================================================
	//  Class variables
	//==========================================================================
	static public const LOG_INFO_CHANGE:String = "logInfoChange";
	
	//==========================================================================
	//  Constructor
	//==========================================================================
	public function LoggerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
	
	//==========================================================================
	//  Variables
	//==========================================================================
	public var msg:String = "";
	public var level:int;
	
	//==========================================================================
	//  Methods
	//==========================================================================
	override public function clone():Event
	{
		var event:LoggerEvent = new LoggerEvent(type, bubbles, cancelable);
		event.msg = msg;
		event.level = level;
		return event;
	}
}
}