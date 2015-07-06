package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.objects.Fruit;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ScreenElephant01 extends Screen
	{
		private var mainSkin:FL_ScreenElephant01;
		
		private var mov01:MovieClip;
		private var buttonNext:Sprite;
		private var msgFruit:Sprite;
		
		private var overlapFull:FL_BlackFadeIn;
		private var overlapFilmOut:FL_BlackBar_OUT;
		
		private var speechElephant:TextLine;
		
		private var fruits:Array;
		private var clipFruits:Sprite;
		
		public function ScreenElephant01()
		{
			super();
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_forestElephant);
			addChild(background);
			
			mainSkin = new FL_ScreenElephant01();
			addChild(mainSkin);
			
			mov01 = mainSkin.mov01;
			mov01.stop();
			
			overlapFilmOut = new FL_BlackBar_OUT();
			overlapFilmOut.stop();
			addChild(overlapFilmOut);
			
			overlapFull = new FL_BlackFadeIn();
			overlapFull.stop();
			addChild(overlapFull);
			
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			msgFruit = mainSkin.msgFruitDone;
			msgFruit.visible = false;
			
			speechElephant = mainSkin.elephantSpeech;
			speechElephant.visible = false;
			fruits = new Array();
			crawlFruit();
		}
		
		private function crawlFruit():void{
			
			clipFruits = mainSkin.allFruits;
			for(var i:int = 0; i < clipFruits.numChildren; i++){
				if(clipFruits.getChildAt(i) is Fruit){
					fruits.push(clipFruits.getChildAt(i));
				}
			}
			
			trace(fruits);
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			overlapFull.play();
			AfterPlayClip.callBack(overlapFull, filmBarPlay);
		}
		
		private function filmBarPlay():void{
			removeChild(overlapFull);
			mov01.play();
			AfterPlayClip.callBack(mov01, movieEnded);
		}
		
		private function movieEnded():void{
			overlapFilmOut.play();
			AfterPlayClip.callBack(overlapFilmOut, bringSpeechBubble);
		}
		
		private function bringSpeechBubble():void{
			removeChild(overlapFilmOut);
			
			speechElephant.visible = true;
			speechElephant.appear();
			speechElephant.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, speechEnded);
			speechElephant.addEventListener(TextLineEvents.TEXTLINE_END, speechEnded);
		}
		
		private function speechEnded(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END){
				speechElephant.disAppear();
				return;
			}
			speechElephant.visible = false;
			DelayCall.call(showGameIns, .3);
		}
		
		private function showGameIns():void{
			var ins:ScreenStartGame = new ScreenStartGame();
			ins.instruction = "nvwZi Rb¨ d‡ji Dci wK¬K K‡i dj cvo‡Z n‡e|";
			addChild(ins);
			
			ins.addEventListener(LevelEvents.LEVEL_START, startFruitGame);
		}
		
		private var fruitTimer:Timer;
		private var sec:int = 3;
		private var fruitCount:int = 0;
		private var fruitdroppable:Array = new Array();
		private var fruitFlipping:Fruit;
		private var fruitDropping:Fruit;
		
		private function startFruitGame(e:LevelEvents):void{
			for(var i:int = 0; i<fruits.length; i++){
				fruits[i].live = true;
				fruits[i].addEventListener('HIT', fruitHit);
			}
			
			var delay:int = 200;
			var repeatCountDynamic:int = sec*1000/delay;
			fruitTimer = new Timer(delay);//, repeatCountDynamic);
			fruitTimer.addEventListener(TimerEvent.TIMER, flipFruits);
			fruitTimer.start();
			
			this.addEventListener(Event.ENTER_FRAME, dropFruit);
		}
		
		private function flipFruits(e:TimerEvent):void{
			for(var i:int = 0; i<fruits.length; i++){
				fruitFlipping = fruits[i];
				if(Math.random()*5 > 4 && !fruitFlipping.dropped){
					fruits[i].flip();
				}
			}
		}
		
		private function dropFruit(e:Event):void{
			
			for(var i:int = 0; i<fruitdroppable.length; i++){
				fruitDropping = fruitdroppable[i];
				if(fruitDropping.y < 560){
					fruitDropping.vy *= 1.3;
					fruitDropping.y += fruitDropping.vy;
				}
				
			}
		}
		
		private function fruitHit(e:Event):void{
			e.currentTarget.live = false;
			e.currentTarget.vy = 3;
			fruitCount++;
			fruitdroppable.push(e.currentTarget);
			
			if(fruitCount == 10){
				fruitTimer.stop();
				this.removeEventListener(Event.ENTER_FRAME, dropFruit);
				
				DelayCall.call(prepareExit, .5);
			}
			
			trace(fruitCount);
		}
		
		private function prepareExit():void{
			msgFruit.visible = true;
			buttonNext.visible = true;
			buttonNext.addEventListener(MouseEvent.CLICK, exit);
		}
		
		private function exit(e:MouseEvent):void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
	}
}