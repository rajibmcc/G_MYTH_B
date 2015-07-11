package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.animation.TransitionHelper;
	import com.mcc.interactives.SoundEngine;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ScreenBird01 extends Screen
	{
		private var hint:HintDynamic;
		private var mainSkin:FL_screenBird01;

		private var textline:TextLine;
		
		private var hitMother:Sprite;
		private var hitBaby01:Sprite;
		private var hitBaby02:Sprite;
		private var hitBaby03:Sprite;
		private var hitBaby04:Sprite;
		private var hitBaby05:Sprite;
		
		private var clipMother:MovieClip;
		private var clipBirds:Array;
		
		private var originalSequence:Array;
		private var suffledIndex:Array;
		private var sequenceNum:int;
		
		private var indicator:Sprite;
		private var notificationTry:Sprite;
		private var notificationSuccess:Sprite;
		
		private var buttonNext:Sprite;
		
		public function ScreenBird01()
		{
			super();
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_forest_bird);
			addChild(background);
			
			mainSkin = new FL_screenBird01();
			addChild(mainSkin);
			
			hint = new HintDynamic();
			hint.txt.text = 'MvbwU †kvbvi Rb¨ gv cvwLwUi Ici wK¬K K‡iv|';
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			
			
			notificationTry = mainSkin.tryBird;
			notificationTry.visible = false;
			notificationSuccess = mainSkin.successBird;
			notificationSuccess.visible = false;
			
			hitMother = mainSkin.hitMother;
			hitBaby01 = mainSkin.hitBaby01;
			hitBaby02 = mainSkin.hitBaby02;
			hitBaby03 = mainSkin.hitBaby03;
			hitBaby04 = mainSkin.hitBaby04;
			hitBaby05 = mainSkin.hitBaby05;
			
			indicator = new Sprite();
			mainSkin.tuneIndicator.addChild(indicator);
			
			hint2 = new HintDynamic();
			
			clipMother = mainSkin.motherBird;
			clipMother.stop();
			clipBirds = [mainSkin.babyBird01, mainSkin.babyBird02, mainSkin.babyBird03, mainSkin.babyBird04, mainSkin.babyBird05];
			
			for each(var bird:MovieClip in clipBirds){
				bird.stop();
			}
			
			textline = mainSkin.textLine01;
			addChild(textline);
			
			originalSequence = [AUDIO_BIRD_SING_05, AUDIO_BIRD_SING_01, AUDIO_BIRD_SING_02, AUDIO_BIRD_SING_03, AUDIO_BIRD_SING_04];
			suffledIndex = [1, 0, 2, 3, 4];
		}
		
		private function singBabySongCorrectly(e:MouseEvent):void{			
			var tuneSerial:int = 0;
			var bird:MovieClip;
			var canPlaybirdIndex:int;
			
			nextSound(null);
			
			function nextSound(e:Event):void{
				SoundEngine.voiceOver.removeEventListener(Event.SOUND_COMPLETE, nextSound);
				
				if(tuneSerial >= suffledIndex.length){
					hint2.txt.text = 'Gevi cvwLi Qvbv¸‡jvi Ici wK¬K K‡i wfbœ wfbœ †bvU¸‡jv µgvbymv‡i evRvI|';
					readyBaby();
					return;
				}
				
				canPlaybirdIndex = suffledIndex.indexOf(tuneSerial);
				SoundEngine.playVoiceOver(originalSequence[tuneSerial]);
				SoundEngine.voiceOver.addEventListener(Event.SOUND_COMPLETE, nextSound);
				bird = clipBirds[canPlaybirdIndex] as MovieClip;
				bird.gotoAndPlay(1);
				clipMother.gotoAndPlay(1);
				
				AfterPlayClip.callBack(bird);
				AfterPlayClip.callBack(clipMother);
				tuneSerial++;
			}
		}
		
		private function checkSequence(currentSequence:int, playingIndex:int):Boolean{
			if(currentSequence == playingIndex){
				return true;
			}
			else return false;
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			textline.appear();
			
			textline.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, showGameHint);
			textline.addEventListener(TextLineEvents.TEXTLINE_END, showGameHint);
		}
		
		protected function showGameHint(event:TextLineEvents):void
		{
			if(event.type == TextLineEvents.TEXTLINE_END){
				textline.disAppear();
				return;
			}
			
			textline.visible = false;
			
			hint2.txt.text = 'MvbwU †kvbvi Rb¨ gv cvwLwUi Ici wK¬K K‡iv|';
			hint2.x = 840;
			addChild(hint2);
			
			hitMother.addEventListener(MouseEvent.CLICK, singBabySongCorrectly);
		}
		
		private function readyBaby():void{
			indicator.graphics.clear();
			notificationTry.visible = false;
			enableBabies(true);
			sequenceNum = 0;
		}
		
		protected function activateBabies(event:Event):void
		{
			// TODO Auto-generated method stub
			trace('Mother bird sing complete ...............................................');
			clipMother.gotoAndStop(1);
			SoundEngine.voiceOver.removeEventListener(Event.SOUND_COMPLETE, activateBabies);
		}
		
		private function enableBabies(status:Boolean):void{
			if(status){
				hitBaby01.addEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby02.addEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby03.addEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby04.addEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby05.addEventListener(MouseEvent.CLICK, playOwnTune);
			}
			else{
				hitBaby01.removeEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby02.removeEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby03.removeEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby04.removeEventListener(MouseEvent.CLICK, playOwnTune);
				hitBaby05.removeEventListener(MouseEvent.CLICK, playOwnTune);
			}
		}
		
		private var playIndex:int;

		private var hint2:HintDynamic;
		protected function playOwnTune(event:MouseEvent):void
		{
			trace("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "+sequenceNum);
			switch(event.currentTarget){
				case hitBaby01:
					MovieClip(clipBirds[0]).play();
					AfterPlayClip.callBack(clipBirds[0]);
					playIndex = suffledIndex[0];
					break;
				case hitBaby02:
					MovieClip(clipBirds[1]).play();
					AfterPlayClip.callBack(clipBirds[1]);
					playIndex = suffledIndex[1];
					break;
				case hitBaby03:
					MovieClip(clipBirds[2]).play();
					AfterPlayClip.callBack(clipBirds[2]);
					playIndex = suffledIndex[2];
					break;
				case hitBaby04:
					MovieClip(clipBirds[3]).play();
					AfterPlayClip.callBack(clipBirds[3]);
					playIndex = suffledIndex[3];
					break;
				case hitBaby05:
					MovieClip(clipBirds[4]).play();
					AfterPlayClip.callBack(clipBirds[4]);
					playIndex = suffledIndex[4];
					break;
			}
			
			SoundEngine.playVoiceOver(originalSequence[playIndex]);
			
			if(checkSequence(sequenceNum, playIndex)){
				trace('------------------------------------------------- Right sequence -----------------------');
				
				indicator.graphics.beginFill(0x00FF00);
				indicator.graphics.drawCircle(sequenceNum*75+20, 20, 20);
				indicator.graphics.endFill();
				if(sequenceNum == suffledIndex.length - 1){
					//Done Game over
					enableBabies(false);
					notificationSuccess.visible = true;
					clipMother.removeEventListener(MouseEvent.CLICK, singBabySongCorrectly);
					DelayCall.call(showNext, 1.5);
				}
				else{
					sequenceNum++;
				}
			}
			else{
				
				enableBabies(false);
				
				indicator.graphics.beginFill(0xFF0000);
				indicator.graphics.drawCircle(sequenceNum*75+20, 20, 20);
				indicator.graphics.endFill();
				
				notificationTry.visible = true;
				DelayCall.call(readyBaby, 1.5);
			};
		}
		
		private function showNext():void{
			buttonNext.addEventListener(MouseEvent.CLICK, exit);
		}
		
		protected function exit(event:MouseEvent):void
		{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
	}
}