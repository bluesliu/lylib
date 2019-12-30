package com.lylib.utils
{
	public class DateFormat
	{
		public static const DAYS:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		public static const DAYS_ABBREVIATED:Array = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"];
		public static const DAYS_CN:Array = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
		public static const MONTHS:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		public static const MONTHS_ABBREVIATED:Array = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		public static const MONTHS_CN:Array = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"];
		public static const DAYSINMONTH:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		
		private var _mask:String="yyyy-mm-dd";
		private var _group:String = "-";
		
		
		public function DateFormat() {
			
		}
		
		
		public static function getMonth_CN(date:Date):String{
			return MONTHS_CN[date.getMonth()];
		}
		
		public static function getDay_CN(date:Date):String{
			return DAYS_CN[date.getDay()];
		}
		
		
		
		/**
		 * 格式化 
		 * @param date	要格式化的日期
		 * @param obj	属性包括：group(年月日之间的分隔符)
		 * @return 
		 * 
		 */		
		public function format(date:Date = null, obj:Object=null):String{
			if(date==null){
				date = new Date();
			}
			if(obj!=null){
				if(obj.group!=null){
					this._group = obj.group;
				}
			}
			var str:String="";
			var nf:NumberFormatter = new NumberFormatter("##");
			
			var arr:Array = mask.split("-");
			for(var i:int=0; i<arr.length; i++){
				
			}
			return str;
		}

		
		/**
		 * 格式化 时间变为字符串 如：2015/4/18 22:55:20
		 * @param date	要格式化的日期
		 * @return  如：2015/4/18 22:55:20
		 * 
		 */		
		public static function formatDate2String(date:Date = null):String{
			if(date==null){
				date = new Date();
			}
			var str:String="";
			
			var nf:NumberFormatter = new NumberFormatter("##");
			nf.format(date.month+1,{integer:0});
			
			str=date.fullYear+"/"+nf.format(date.month+1,{integer:0})+"/"+nf.format(date.date,{integer:0})
				+" " 
				+ nf.format(date.hours,{integer:0})+":" +nf.format(date.minutes,{integer:0})+":"+nf.format(date.seconds,{integer:0});
			return str;
		}
		
		/**
		 * 格式化时间戳
		 * @param timestamp
		 * @return 
		 * 
		 */		
		public static function formatTimestamp(timestamp:int):String
		{
			var date:Date = DateUtil.timestamp2Date(timestamp);
			return formatDate2String(date);
		}
		
		
		/**
		 * 掩码，由“ymd-”组成 
		 * @return 
		 */		
		public function get mask():String
		{
			return _mask;
		}
		public function set mask(value:String):void
		{
			_mask = value;
		}

	}
}