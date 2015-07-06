package com.bbc_icontent.levels
{
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenDeer01;
	
	public class LevelDeer extends Level
	{
		public function LevelDeer()
		{
			super();
			
			_checkPoints.push(ScreenDeer01);
		}
	}
}