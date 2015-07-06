package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ScreenTiger02 extends Screen
	{
		private var mainSkin:FL_ScreenTiger02;
		
		private var hideOuts:Sprite;
		private var hideOutBush01:Sprite;
		private var hideOutBush02:Sprite;
		private var hideOutTree01:Sprite;
		private var hideOutTree02:Sprite;
		
		private var cubHidden01:Sprite;
		private var cubHidden02:Sprite;
		private var cubHidden03:Sprite;
		private var cubHidden04:Sprite;
		
		private var cub01:Sprite;
		private var cub02:Sprite;
		private var cub03:Sprite;
		private var cub04:Sprite;
		
		private var totalCubFound:int;
		private var totalCub:int = 4;
		private var scoreIcons:Array = new Array();
		
		private var arrHiddenCub:Array = new Array();
		private var arrCub:Array = new Array();
		private var arrInfo:Array = new Array();
		
		public function ScreenTiger02()
		{
			super();
			var img:Bitmap;
			var background:Bitmap = Assets.getBackground(Assets.IMG_forestTiger);
			addChild(background);
			
			mainSkin = new FL_ScreenTiger02();
			addChild(mainSkin);
			
			hideOuts = mainSkin.hideOut;
			hideOuts.mouseEnabled = false;
			hideOuts.mouseChildren = false;
			
			hideOutBush01 = ImageInjector.inject(mainSkin.hideOut.bush01, Assets.IMG_forestTigerBush01);
			hideOutBush02 = ImageInjector.inject(mainSkin.hideOut.bush02, Assets.IMG_forestTigerBush02);			
			hideOutTree01 = ImageInjector.inject(mainSkin.hideOut.tree01, Assets.IMG_forestTigerTre01);
			hideOutTree02 = ImageInjector.inject(mainSkin.hideOut.tree02, Assets.IMG_forestTigerTre02);
			
			cubHidden01 = ImageInjector.inject(mainSkin.hiddenCub01, Assets.IMG_forestTigerHead);
			cubHidden02 = ImageInjector.inject(mainSkin.hiddenCub02, Assets.IMG_forestTigerHead);
			cubHidden03 = ImageInjector.inject(mainSkin.hiddenCub03, Assets.IMG_forestTigerTail);
			cubHidden04 = ImageInjector.inject(mainSkin.hiddenCub04, Assets.IMG_forestTigerTail);
			arrHiddenCub.push(cubHidden01, cubHidden02, cubHidden03, cubHidden04);
			
			prepareCubs(cub01, mainSkin.cub01);
			prepareCubs(cub02, mainSkin.cub02);
			prepareCubs(cub03, mainSkin.cub03);
			prepareCubs(cub04, mainSkin.cub04);
			
			for(var i:int = 0; i< totalCub; i++){
				var scoreIcon:ScoreIconTiger = new ScoreIconTiger(Assets.getBackground(Assets.IMG_TigerIcon), Assets.getBackground(Assets.IMG_TigerIconGray));
				scoreIcon.x = 10 + i*60;
				scoreIcon.y = 620;
				
				addChild(scoreIcon);
				scoreIcons.push(scoreIcon);
			}
			
			var sp:Sprite;
			for(i = 1; i< 5; i++){
				sp = mainSkin.getChildByName("info0"+i) as Sprite;
				trace('sp: '+sp);
				sp.visible = false;
				arrInfo.push(sp);
			}

		}
		
		private function prepareCubs(cub:Sprite, spriteFLA:Sprite):void{
			cub = ImageInjector.inject(spriteFLA, Assets.IMG_forestTigerCub);
			cub.visible = false;
			arrCub.push(cub);
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			var startScreen:ScreenStartGame = new ScreenStartGame();
			startScreen.instruction = 'jywK‡q _vKv evN Qvbv¸‡jvi Dci wK¬K K‡i evB‡i †ei wb‡q Avm|';
			startScreen.addEventListener(LevelEvents.LEVEL_START, startInteraction);
			
			addChild(startScreen);
		}
		
		protected function startInteraction(event:Event):void
		{
			if(totalCubFound > 0){
				for each (var cubIcon:ScoreIconTiger in scoreIcons) 
				{
					cubIcon.awarded = false;
				}
				
			}
			
			totalCubFound = 0;
			
			cubHidden01.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			cubHidden02.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			cubHidden03.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			cubHidden04.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private var cubHidden:Sprite;
		private var cubInfo:Sprite;
		
		protected function onClick(event:MouseEvent):void
		{
			cubHidden = event.currentTarget as Sprite;
			cubHidden.removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
			Shaker.shake(cubHidden);
			
			
			
			DelayCall.call(function():void{
				cubInfo = arrInfo[arrHiddenCub.indexOf(cubHidden)]
				cubInfo.visible = true;
				
				cubInfo.getChildByName("btNext").addEventListener(MouseEvent.CLICK, cubFound);
				
			}, .5);
		}
		
		protected function cubFound(event:Event):void
		{
			cubInfo.visible = false;
			cubHidden.visible = false;
			
			arrCub[arrHiddenCub.indexOf(cubHidden)].visible = true;
			ScoreIconTiger(scoreIcons[totalCubFound]).awarded = true;
			
			totalCubFound++;
			if(totalCubFound == totalCub){
				DelayCall.call(prepareExit, .5);
			}
			
		}
		
		private function prepareExit():void{
			exit(); 
		}
		
		private function exit():void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}
//****************************************************************************************************************************************************************
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

class ScoreIconTiger extends Sprite{
	private var _imageAwarded:Bitmap;
	private var _imageNotAwarded:Bitmap;
	private var _awarded:Boolean;
	public function ScoreIconTiger(awardedImg:Bitmap, notAwardedImg:Bitmap){
		super();
		
		_imageAwarded = awardedImg;
		_imageNotAwarded = notAwardedImg;
		
		awarded = false;
	}
	
	public function get awarded():Boolean
	{
		return _awarded;
	}
	
	public function set awarded(value:Boolean):void
	{
		_awarded = value;
		if(value){
			if(numChildren>0){
				removeChildAt(0);
			}
			addChild(_imageAwarded);
		}
		else {
			if(numChildren >0){
				removeChildAt(0);
			}
			addChild(_imageNotAwarded);
		}
	}
}

class Shaker {	
	public static function shake(shakable:Object):void{
		var timer:Timer = new Timer(3, 10);
		var oldX:Number = shakable.x;
		var oldY:Number = shakable.y;
		
		timer.addEventListener(TimerEvent.TIMER, doshake);
		timer.start();
		
		function doshake(e:TimerEvent):void{
			shakable.x = oldX + (Math.random() * 5 - 5);
			shakable.y = oldY + (Math.random() * 5 - 5);
			
			if(e.target.currentCount == 15){
				shakable.x = oldX;
				shakable.y = oldY;
			}
		}
	}
}