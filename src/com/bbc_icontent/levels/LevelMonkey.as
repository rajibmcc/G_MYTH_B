package com.bbc_icontent.levels
{
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenMonkey01;
	import com.bbc_icontent.screens.ScreenMonkey02;
	
	public class LevelMonkey extends Level
	{
		public function LevelMonkey()
		{
			super();
			
			_checkPoints.push(ScreenMonkey01, ScreenMonkey02);
		}
	}
}