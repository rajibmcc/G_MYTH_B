package com.bbc_icontent.screens
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.ScoreGame;
	import com.bbc_icontent.Screen;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenTheEnd extends Screen
	{
		private var mainSkin:FL_ScreenEND;
		private var message:TextField;
		
		private var buttonNext:Sprite;
		
		private var grade:int;
		public function ScreenTheEnd()
		{
			super();
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_forest_monkey_far);
			addChild(background);
			
			mainSkin = new FL_ScreenEND();
			addChild(mainSkin);
			
			message = mainSkin.txt;
			
			buttonNext = mainSkin.bt_next;
			
			grade = ScoreGame.getGrade();
			
			buttonNext.addEventListener(MouseEvent.CLICK, showGrade);
		}
		
		protected function showGrade(event:MouseEvent):void
		{
			switch(grade){
				case 1:
					message.text = ''+InfoGame.getScoreFeedbackMsg(InfoGame.SCORE_FEEDBACK_C);
					break;
				case 2:
					message.text = ''+InfoGame.getScoreFeedbackMsg(InfoGame.SCORE_FEEDBACK_B);
					break;
				case 3:
					message.text = ''+InfoGame.getScoreFeedbackMsg(InfoGame.SCORE_FEEDBACK_A);
					break;
			}
			
			buttonNext.visible = false;
			buttonNext.removeEventListener(MouseEvent.CLICK, showGrade);
		}
	}
}