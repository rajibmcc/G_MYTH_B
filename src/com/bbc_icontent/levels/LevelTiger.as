package com.bbc_icontent.levels
{
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenTiger01;
	import com.bbc_icontent.screens.ScreenTiger02;
	
	public class LevelTiger extends Level
	{
		public function LevelTiger()
		{
			super();
			
			_checkPoints.push(ScreenTiger01, ScreenTiger02);
		}
	}
}