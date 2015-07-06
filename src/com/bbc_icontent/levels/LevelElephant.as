package com.bbc_icontent.levels
{
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenElephant01;
	import com.bbc_icontent.screens.ScreenElephant02;
	
	public class LevelElephant extends Level
	{
		public function LevelElephant()
		{
			super();
			
			_checkPoints.push(ScreenElephant01, ScreenElephant02);
		}
	}
}