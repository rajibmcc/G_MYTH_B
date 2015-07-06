package com.bbc_icontent.levels
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenSnake01;
	import com.bbc_icontent.screens.ScreenSnake02;
	import com.bbc_icontent.screens.ScreenSnake03;
	import com.bbc_icontent.screens.ScreenSnake04;
	
	public class LevelSnake extends Level
	{
		public function LevelSnake()
		{
			super();
			
			_checkPoints.push(ScreenSnake01, ScreenSnake02, ScreenSnake03, ScreenSnake04);
			_levelId = InfoGame.LEVEL_SNAKE;
		}
	}
}