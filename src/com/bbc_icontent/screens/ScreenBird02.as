package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenBird02 extends Screen
	{
		private var mainSkin:FL_screenBird02;
		private var speech:Speech;
		private var buttonNext:Sprite;
		private var buttonSkip:Sprite;
		
		private var container01:Sprite;
		private var container02:Sprite;
		private var container03:Sprite;
		
		public function ScreenBird02()
		{
			super();
			
			mainSkin = new FL_screenBird02();
			addChild(mainSkin);
						
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			buttonSkip = mainSkin.bt_skip;
			buttonSkip.visible = false;
			
			speech = new Speech();
			speech.x = 400;
			speech.y = 50;
			
			container01 = mainSkin.container01;
			container01.visible = false;
			container02 = mainSkin.container02;
			container02.visible = false;
			container03 = mainSkin.container03;
			container03.visible = false;
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			DelayCall.call(showSpeech, 2);
		}
		
		private function showSpeech():void{
			buttonNext.visible = true;
			buttonNext.addEventListener(MouseEvent.CLICK, lineNext);
			buttonSkip.visible = true;
			buttonSkip.addEventListener(MouseEvent.CLICK, prepareInteractive);
			
			addChild(speech);
			speech.visible = false;
			
			speech.addEventListener(Event.COMPLETE, skipSpeech);
		}
		
		private function lineNext(e:MouseEvent):void{
			speech.visible = true;
			speech.nextLine();
		}
		
		private function skipSpeech(e:Event):void{
			prepareInteractive(null);
		}
		
		private function prepareInteractive(e:MouseEvent):void{
			speech.removeEventListener(Event.COMPLETE, skipSpeech);
			removeChild(speech);
			
			startInteractive();
		}
		
		private function startInteractive():void{
			reset();
			
			container01.visible = true;
			container02.visible = true;
			container03.visible = true;
			
			container01.addEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
			container02.addEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
			container03.addEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
		}
		
		private var currentMoving:Sprite;
		private function dragEnable(e:MouseEvent):void{
			currentMoving = e.currentTarget as Sprite;
			currentMoving.removeEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
			currentMoving.startDrag(true);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(e:MouseEvent):void{
			checkCollision();
		}
		private function mouseUpHandler(e:MouseEvent):void{
			
		}
		
		private function checkCollision():void{
			
		}
		
		private function reset():void{
			container01.x = 130;
			container01.y = 386;
			
			container02.x = 510;
			container02.y = 386;
			
			container03.x = 890;
			container03.y = 386;
		}
		
	}
}

import com.mcc.interactives.utils.AfterPlayClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

class Speech extends Sprite{
	private var skin:BirdSpeech;
	private var textLine:TextField;
	private var lines:Array;
	private var indexLine:int;
	public function Speech(){
		skin = new BirdSpeech();
		addChild(skin);
		skin.stop();
		textLine = skin.txt;
		textLine.visible = false;
		
		lines = ['gvwm‡Ki mgq †g‡qiv cwi¯‹vi Kvco ev m¨vwbUvwi c¨vW e¨envi Ki‡Z cv‡i| G¸‡jv i³¯ªvve fv‡jvfv‡e ï‡l wb‡Z cv‡i|',
		'gvwm‡Ki mgq cwi¯‹vi Kvco †avqv I e¨envi Kivi c×wZ¸‡jv wb‡P †`Iqv Av‡Q| Zzwg wK G¸‡jv µgvbymv‡i mvRv‡Z cvi‡e? Zvn‡jB Zzwg GB evavwU AwZµg K‡i mvg‡b GwM‡q †h‡Z cvi‡e|'];
		
		indexLine = 0;
	}
	
	public function nextLine():void{
		if(indexLine < lines.length){
			textLine.visible = false;
			skin.gotoAndPlay(1);
			AfterPlayClip.callBack(skin, showLine);
		}
		else{
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
	}
	
	private function showLine():void{
		textLine.visible = true;
		textLine.text = ''+lines[indexLine];
		
		indexLine++;
	}
}