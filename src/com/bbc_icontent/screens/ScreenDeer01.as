package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.IEvents.QuizEvents;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.Quizer;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenDeer01 extends Screen
	{
		private var mainSkin:FL_ScreenDeer01;
		
		
		private var flower01:MovieClip;
		private var flower01Hit:Sprite;
		private var flower02:MovieClip;
		private var flower02Hit:Sprite;
		private var flower03:MovieClip;
		private var flower03Hit:Sprite;
		
		private var deerSpeech:Sprite;
		private var deerSpeechText:TextField;
		
		private var quizSkin:Sprite;
		
		private var textline01:TextLine;
		private var buttonNext:Sprite;
		
		public function ScreenDeer01()
		{
			super();
			
			mainSkin = new FL_ScreenDeer01();
			addChild(mainSkin);
			
			quizSkin = mainSkin.quizSkin;
			quizSkin.visible = false;
			
			/*option01 = mainSkin.option01;
			option01Text = mainSkin.option01.txt;
			option01.visible = false;
			
			option02 = mainSkin.option02;
			option02Text = mainSkin.option02.txt;
			option02.visible = false;*/
			
			deerSpeech = mainSkin.SpeechDeer01;
			deerSpeechText = mainSkin.SpeechDeer01.txt;
			deerSpeech.visible = false;
			
			flower01 = mainSkin.flower01;
			flower01.stop();
			flower01Hit = mainSkin.flower01.hitPoint;
			flower02 = mainSkin.flower02;
			flower02.stop();
			flower02Hit = mainSkin.flower02.hitPoint;
			flower03 = mainSkin.flower03;
			flower03.stop();
			flower03Hit = mainSkin.flower03.hitPoint;
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			
			textline01 = mainSkin.textLine01;
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			textline01.appear();
			textline01.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, deerSpeaks);
			textline01.addEventListener(TextLineEvents.TEXTLINE_END, deerSpeaks);
		}
		private var activeFlowerCount:int;
		protected function deerSpeaks(event:TextLineEvents):void
		{
			if(event.type == TextLineEvents.TEXTLINE_END){
				textline01.disAppear();
				return;
			}
			
			
			deerSpeechText.text = 'dzj¸‡jv‡K fv‡jvfv‡e †dvUv‡bvi Rb¨ †m¸‡jvi Ici wK¬K K‡iv';
			deerSpeech.visible = true;
			
			activeFlowerCount = 0;
			flower01Hit.addEventListener(MouseEvent.CLICK, activateFlower);
			flower02Hit.addEventListener(MouseEvent.CLICK, activateFlower);
			flower03Hit.addEventListener(MouseEvent.CLICK, activateFlower);
		}
		
		protected function activateFlower(event:MouseEvent):void
		{
			switch(event.currentTarget){
				case flower01Hit:
					flower01.play();
				break;
				case flower02Hit:
					flower02.play();
					break;
				case flower03Hit:
					flower03.play();
					break;
			}
			
			activeFlowerCount++;
			event.currentTarget.removeEventListener(MouseEvent.CLICK, activateFlower);
			
			if(activeFlowerCount == 3){
				deerSpeech.visible = false;				
				DelayCall.call(prepareQuestions, .5);
			}
		}
		
		private function prepareQuestions():void{
			deerSpeechText.text = 'GB iv¯ÍvwU cvi n‡Z n‡j †Zvgv‡K cÖwZwU dz‡ji g‡a¨ _vKv Z_¨¸‡jv †_‡K mwVK Z_¨ I fzj aviYv¸‡jv wPwýZ Ki‡Z n‡e| ';
			deerSpeech.visible = true;
			
			buttonNext.visible = true;
			addChild(buttonNext);
			buttonNext.addEventListener(MouseEvent.CLICK, startQuiz);
		}
		
		private var quizArr:Array = [['gvwmK mvaviYZ cvuP †_‡K Qq w`b ch©šÍ ¯’vqx nq|', 'gvwmK mvaviYZ 12 †_‡K 14 w`b ch©šÍ ¯’vqx nq|'],
		['mvaviYZ 12 †_‡K 13 eQi eq‡m †g‡q‡`i gvwmK ïiæ nq|','mvaviYZ 20 †_‡K 24 eQi eq‡m †g‡q‡`i gvwmK ïiæ nq|']];
		
		private var dataFeedback:Array = ['gvwmK mvaviYZ cvuP †_‡K Qq w`b ¯’vqx nq| KviI gvwmK hw` mvZ w`‡bi †ewk mgq ch©šÍ P‡j Zvn‡j Wv³vi †`Lv‡bv DwPZ| Avi eskMZ KviY, kix‡i ni‡gvb I i‡³i cwigvY Ges ‰`wnK MV‡bi Kvi‡Y gvwm‡Ki mgq i³m«v‡ei gvÎv wbf©i K‡i| G Kvi‡Y gvwm‡Ki mgq KviI †ewk, KviI Kg ¯ªve †ei nq| gvwmK wbqwgZ n‡Z cÖvq `yB eQ‡ii gZ mgq jv‡M|',
			'KviI KviI gvwmK GKUz ZvovZvwo ev †`wi‡Z ïiæ n‡Z cv‡i| G‡Z Nveov‡bvi wKQy ‡bB| Z‡e 16 eQi eq‡mi ciI gvwmK ïiæ bv n‡j Wv³v‡ii civgk© wb‡Z n‡e| †g‡q‡`i gvwmK mvaviYZ 12 ‡_‡K 13 eQi eqm †_‡K ïiæ nq Ges 45-55 eQi eqm †_‡K ax‡i ax‡i eÜ n‡q hvq|'];
		
		private var quizMachine:Quizer;
		
		private function startQuiz(event:MouseEvent):void{
			
			buttonNext.removeEventListener(MouseEvent.CLICK, startQuiz);
			buttonNext.visible = false;
			
			quizMachine = new Quizer(2, quizArr, quizSkin);
			quizSkin.visible = true;
			
			quizMachine.ask();
			quizMachine.addEventListener(QuizEvents.ANS_GIVEN, showFeedback);
			quizMachine.addEventListener(QuizEvents.FINAL_ANS_GIVEN, showFeedback);
		}

		private function askAgain(e:LevelEvents):void{
			if(!quizMachine.isAllAnswerDone){
				quizMachine.ask();
				quizMachine.addEventListener(QuizEvents.ANS_GIVEN, showFeedback);
			}
			else{
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
			}
		}
		
		protected function showFeedback(event:QuizEvents):void
		{
			quizMachine.removeEventListener(QuizEvents.ANS_GIVEN, showFeedback);
			quizMachine.removeEventListener(QuizEvents.FINAL_ANS_GIVEN, showFeedback);
			
			if(event.correctAns){
				scoreValue += 5;
				var correctFeedback:ScreenMythBusterPoint = new ScreenMythBusterPoint();
				correctFeedback.setMessage = ['`viæY! Zywg AviI wKQy wg_ ev÷vi c‡q›U wR‡ZQ|', dataFeedback[quizMachine.currentQuizCount - 1]];
				addChild(correctFeedback);
				correctFeedback.animPointEarned();
				correctFeedback.addEventListener(LevelEvents.LEVEL_NEXT, askAgain);
			}
			else{
				var failFeedback:ScreenMythBusterFailed = new ScreenMythBusterFailed();
				failFeedback.setMessage = ['`ytwLZ, Zywg †Kvb wg_ ev÷vi c‡q›U wRZ‡Z cviwb| cieZ©x av‡c †Póv K‡i †`L|', dataFeedback[quizMachine.currentQuizCount - 1]];
				addChild(failFeedback);
				failFeedback.animPointEarned();
				failFeedback.addEventListener(LevelEvents.LEVEL_NEXT, askAgain);
			}
		}
		
	}
}