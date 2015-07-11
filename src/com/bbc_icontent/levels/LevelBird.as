package com.bbc_icontent.levels
{
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenBird01;
	import com.bbc_icontent.screens.ScreenBird02;
	
	public class LevelBird extends Level
	{
		public function LevelBird()
		{
			super();
			_checkPoints.push(ScreenBird02, ScreenBird01);
		}
	}
}