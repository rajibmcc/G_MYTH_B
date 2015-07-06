package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.greensock.TweenLite;
	import com.mcc.interactives.utils.Pair;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenMonkey02 extends Screen
	{
		private var mainSkin:FL_ScreenMonkey02;
		
		private var questionBoxOrigin:Pair;
		private var questionBox:Sprite;
		private var questionBoxText:TextField;
		
		private var highLightTree:Sprite;
		private var pointTreeFalse:Pair;
		private var pointTreeTrue:Pair;
		
		private var currentQuestion:int;
		private var questionQuiz:Array;
		private var dataQuiz:Array;
		
		private var currentArea:String;
		
		public function ScreenMonkey02()
		{
			super();
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_MONKEY_INTERACTIVE);
			addChild(background);
			
			mainSkin = new FL_ScreenMonkey02();
			addChild(mainSkin);
			
			questionBox = mainSkin.qustion;
			questionBoxText = mainSkin.qustion.txt;
			questionBox.visible = false;
			questionBoxOrigin = new Pair(questionBox.x, questionBox.y);
			
			
			highLightTree = mainSkin.treeHighlight;
			highLightTree.visible = false;
			
			pointTreeFalse = new Pair(mainSkin.treeFalse.x, mainSkin.treeFalse.y);
			pointTreeTrue = new Pair(mainSkin.treeTrue.x, mainSkin.treeTrue.y);
			
			mainSkin.treeTrue.txt.text = 'mZ¨ MvQ';
			mainSkin.treeFalse.txt.text = 'wg_¨v MvQ';
			
			questionQuiz = [['gvwm‡Ki mgq gvQ LvIqv DwPZ bq| G mgq gvQ †L‡j kixi †_‡K `yM©Ü Qovq|', false], 
				['gvwm‡Ki mgq kixi †_‡K i³ †ei n‡q hvq, ZvB Gmgq †ewk †ewk Avqibhy³ Lvevi LvIqv DwPZ|', true], 
				['gvwm‡Ki mgq †ewk cvwb cvb Kiv DwPZ KviY G mgq †g‡qiv cvwb I wKQzUv kw³ nvivq|', true]];
			dataQuiz = ['wg_¨v| gvwm‡Ki i‡³ Ggwb‡ZB GKUz `yM©Ü _v‡K| Zzwg Kx Lvevi Lv‡”Qv Zvi mv‡_ GB M‡Üi †Kv‡bv m¤úK© †bB|',
				'mZ¨| gvwm‡Ki mgq kixi †_‡K i³ †ei n‡q hvq, ZvB Gmgq †ewk †ewk Avqibhy³ Lvevi, †LRyi, cvjs kvK, Wvj LvIqv DwPZ| cywóKi Lvevi †hgb gvQ, wWg, gvsm G mgq LvIqv DwPZ|',
				'mZ¨| gvwm‡Ki mgq kixi ‡_‡K Zij I myMvi (kw³) †ewi‡q hvq| ZvB Gmgq cÖwZw`b cÖvq 2 wjUvi cvwb LvIqv DwPZ|'];
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			var instruction:ScreenStartGame = new ScreenStartGame();
			instruction.instruction = 'mwVK Z_¨¸‡jv‡K ÔmZ¨ Mv‡QÕ I fzj K_v¸‡jv‡K Ôwg_¨v Mv‡QÕi Ici †U‡b wb‡q iv‡Lv|';
			
			addChild(instruction);
			instruction.addEventListener(LevelEvents.LEVEL_START, startInteractive);
		}
		
		protected function startInteractive(event:LevelEvents):void
		{
			currentQuestion = 0;
			
			askQuestion();
			questionBox.visible = true;
		}
		
		private function askQuestion():void
		{
			if(currentQuestion < questionQuiz.length){
				questionBoxText.text = ''+questionQuiz[currentQuestion][0];
				questionBox.x = questionBoxOrigin.xValue;
				questionBox.y = questionBoxOrigin.yValue;
				questionBox.addEventListener(MouseEvent.MOUSE_DOWN, prepareDrag);
			}
				
			else{
				trace('ALL QUESTION AS DONE **************************');
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
			}
			
			
		}
		
		protected function prepareDrag(event:MouseEvent):void
		{
			questionBox.removeEventListener(MouseEvent.MOUSE_DOWN, prepareDrag);
			questionBox.addEventListener(MouseEvent.MOUSE_MOVE, dragWithMouse);
			stage.addEventListener(MouseEvent.MOUSE_UP, dragComplete);
		}
		
		protected function dragComplete(event:MouseEvent):void
		{
			questionBox.stopDrag();			
			questionBox.removeEventListener(MouseEvent.MOUSE_MOVE, dragWithMouse);
			stage.removeEventListener(MouseEvent.MOUSE_UP, dragComplete);
			
			if(currentArea == 'FALSE'){
				trace('Box in the area FALSE : ADDING TWEEN');
				TweenLite.to(questionBox, .5, {x:-410, onComplete:showFeedback});
			}
			else if(currentArea == 'TRUE'){
				trace('Box in the area TRUE : ADDING TWEEN');
				TweenLite.to(questionBox, .5, {x:1284, onComplete:showFeedback});
			}
			else{
				questionBox.x = questionBoxOrigin.xValue;
				questionBox.y = questionBoxOrigin.yValue;
				
				questionBox.addEventListener(MouseEvent.MOUSE_DOWN, prepareDrag);
			}
		}
		
		private function showFeedback():void{
			if(questionQuiz[currentQuestion][1] && currentArea == 'TRUE' || !questionQuiz[currentQuestion][1] && currentArea == 'FALSE'){
				trace('--------------------------- CORRECT ANS');
				var feedbackRight:ScreenMythBusterPoint = new ScreenMythBusterPoint();
				feedbackRight.setMessage = ['`viæY! Zzwg AviI wKQz wg_ ev÷vi c‡q›U wR‡ZQ|', dataQuiz[currentQuestion]];
				addChild(feedbackRight);
				feedbackRight.animPointEarned();
				feedbackRight.addEventListener(LevelEvents.LEVEL_NEXT, prepareAnother);
				
				scoreValue += 5;
			}
				
			else{
				trace('----------------------------WRONG ANS');
				var feedbackWrong:ScreenMythBusterFailed = new ScreenMythBusterFailed();
				feedbackWrong.setMessage = ['`ytwLZ, Zzwg †Kvb wg_ ev÷vi c‡q›U wRZ‡Z cviwb| wKš‘ wPšÍvi wKQy †bB| Avwg †Zvgv‡K G¸‡Z w`‡ev|', dataQuiz[currentQuestion]];
				addChild(feedbackWrong);
				feedbackWrong.animPointEarned();
				feedbackWrong.addEventListener(LevelEvents.LEVEL_NEXT, prepareAnother);
			}
		}
		
		private function prepareAnother(e:LevelEvents):void{
			highLightTree.visible = false;
			currentQuestion++;
			askQuestion();
		}
		
		protected function dragWithMouse(event:MouseEvent):void
		{
			questionBox.startDrag(false);
			checkCollision();
		}
		
		private function checkCollision():void
		{
			if(questionBox.x < 100){
				currentArea = 'FALSE';
				highLightTree.visible = true;
				highLightTree.x = pointTreeFalse.xValue;
				highLightTree.y = pointTreeFalse.yValue;
			}
			else if(questionBox.x > 800){
				currentArea = 'TRUE';
				highLightTree.visible = true;
				highLightTree.x = pointTreeTrue.xValue;
				highLightTree.y = pointTreeTrue.yValue;
			}
				
			else {
				currentArea = '';
				highLightTree.visible = false;
			}
		}
		
	}
}