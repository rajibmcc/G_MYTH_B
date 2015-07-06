package
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.ScoreGame;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class HudScore extends Sprite
	{
		private var mainSkin:FL_HUD_SCORE;
		private var hudText:TextField;
		public function HudScore()
		{
			super();
			
			mainSkin = new FL_HUD_SCORE();
			addChild(mainSkin);
			hudText = mainSkin.txt;
		}
		
		public function update():void{
			hudText.text = ''+ScoreGame.getScoreString(InfoGame.LEVEL_ALL);
		}
	}
}