package com.bbc_icontent.levels
{
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenVodor01;
	
	public class LevelVodor extends Level
	{
		public function LevelVodor()
		{
			super();
			_checkPoints.push(ScreenVodor01);
		}
	}
}