package com.lylib.utils
{
	/**
	 * 数值格式化工具类
	 */	
	public class NumberFormatter
	{
		private var _sMask:String;
		private var _group:String = ",";
		private var _integer:String = " ";
		private var _decimal:String = "0";
		private var _dot:String = ".";
		
		/**
		 * @param sMask	掩码是由"#,.0"组成
		 */		
		public function NumberFormatter(sMask:String = null)
		{
			_sMask = sMask;
		}
		
		
		
		/**
		 * 格式化数值
		 * @param nNumber			要格式化的数值
		 * @param oParameter1		格式化参数对象，包括几个属性：group：分组符号；integer：整数占位符；decimal：小数占位符；dot：小数点占位符
		 * @return 
		 */		
		public function format(nNumber:Number, oParameter1:Object=null):String
		{
			if(oParameter1!=null){
				if(oParameter1.group != null){
					_group = oParameter1.group;
				}
				if(oParameter1.integer != null){
					_integer = oParameter1.integer;
				}
				if(oParameter1.decimal != null){
					_decimal = oParameter1.decimal;
				}
				if(oParameter1.dot != null){
					_dot = oParameter1.dot;
				}
			}
			var sNumber:String = String(nNumber);
			
			var num1:String="";
			var num2:String="";
			var mask1:String="";
			var mask2:String="";
			var xS:String="";
			var dS:String = "";
			var jinWei:int=0;
			
			if(sNumber.split(".").length > 1){
				num2 = sNumber.split(".")[1];
			}
			num1 = sNumber.split(".")[0];
			if(_sMask.split(".").length > 1){
				mask2 = _sMask.split(".")[1];
			}
			mask1 = _sMask.split(".")[0];
			
			
			//处理小数部分
			if( mask2 != "" && Number(mask2)==0 ){
				//小数部分的掩码都是0 符合要求，获得0的个数
				var mask_x_len:int = mask2.length;
				if(num2=="")
				{
					//要格式化的Number没有小数部分，所以小数都为0,0的个数就是掩码0的个数
					xS = getChongFuChar(_decimal, mask_x_len);
				}else if(num2.length == mask_x_len){
					//小数位数等于掩码位数
					xS = num2;
				}else if(num2.length < mask_x_len){
					xS = num2 + getChongFuChar(_decimal, mask2.length-num2.length);;
				}else{
					for(var i:int=0; i<mask_x_len; i++){
						xS += num2.substr(i,1);
					}
					if(int(num2.substr(mask_x_len,1))>4){
						var xS_temp:String = String( int(xS) + 1 );
						if(xS_temp.length > mask_x_len)
						{
							xS = xS_temp.substr(xS_temp.length - mask_x_len, mask_x_len);
							jinWei = int(xS_temp.substr(0,1));
						}else{
							xS = xS_temp;
						}
					}
				}
			}else{
				//掩码中没有小数部分的定义
				if(num2!="")
				{	//要格式化的数据存在小数，原样返回
					xS = num2;
				}else{
					xS = "";
				}		
			}
			
			//处理整数部分
			num1 = String(int(num1) + jinWei);
			var num_d_len:int = num1.length;
			var mask_d_len:int = mask1.length;
			for(var i_num:int=1, i_mask:int=1; ; ){
				if(mask_d_len - i_mask >= 0){
					if( mask1.substr(mask_d_len - i_mask, 1) == "#" ){
						if(num_d_len - i_num >= 0){
							dS = num1.substr(num_d_len - i_num, 1) + dS;
							i_num++;
						}else{
							dS = _integer + dS;
						}
					}else if( mask1.substr(mask_d_len - i_mask, 1) == "," ){
						if(num_d_len - i_num >= 0){
							dS = _group + dS;
						}else{
							dS = _integer + dS;
						}
					}else{
						dS = num1;
						break;
					}
				}else{
					if(num_d_len - i_num >= 0){
						dS = num1.substr(0, num_d_len - i_num + 1) + dS;
					}
					break;
				}
				i_mask++;
			}
			
			
			return dS + ((xS!="")?(_dot+xS):"");
		}
		
		
		
		
		/**
		 * 返回重复的字符串
		 * @param char
		 * @param num
		 * @return 
		 */
		private function getChongFuChar(char:String, num:int):String{
			var str:String = "";
			for(var i:int=0; i<num; i++)
			{
				str += char;
			}
			return str;
		}
		
		
		/**
		 * 掩码是由 “ # , . 0 ” 4个英文字符组成
		 * @return 
		 * 
		 */		
		public function get mask():String
		{
			return _sMask;
		}
		public function set mask(value:String):void
		{
			_sMask = value;
		}

		public function get group():String
		{
			return _group;
		}

		public function set group(value:String):void
		{
			_group = value;
		}

		public function get integer():String
		{
			return _integer;
		}

		public function set integer(value:String):void
		{
			_integer = value;
		}

		public function get decimal():String
		{
			return _decimal;
		}

		public function set decimal(value:String):void
		{
			_decimal = value;
		}

		public function get dot():String
		{
			return _dot;
		}

		public function set dot(value:String):void
		{
			_dot = value;
		}


	}
}