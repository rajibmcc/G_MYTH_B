package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.animation.TransitionHelper;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScreenSnake03 extends Screen
	{
		private var mainSkin:FL_ScreenSnake03;
		private var msgSprite:Sprite;
		private var puzzleSolved:MovieClip;
		private var buttonNext:Sprite;
		
		private var backgroundImage:Bitmap;
		private var imgRO:Bitmap;
		
		private var hit_area:Sprite;
		private var hit_overy:Sprite;
		private var hit_vegina:Sprite;
		private var hit_cervix:Sprite;
		private var hit_felopino:Sprite;
		private var hit_uterus:Sprite;
		
		public function ScreenSnake03()
		{
			super();
			
			backgroundImage = Assets.getBackground(Assets.IMG_forestSnake2);
			addChild(backgroundImage);
			
			mainSkin = new FL_ScreenSnake03();
			addChild(mainSkin);
			
			imgRO = Assets.getBackground(Assets.IMG_jigFR);
			imgRO.alpha = .7;
			addChild(imgRO);
			//imgRO.visible = false;
			
			msgSprite = mainSkin.solveMessage;
			addChild(msgSprite);
			
			
			puzzleSolved = mainSkin.puzzleSolved;
			puzzleSolved.stop();
			puzzleSolved.visible = false;
			addChild(puzzleSolved);
			
			imgRO.x = puzzleSolved.x;
			imgRO.y = puzzleSolved.y;
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			
			hit_area = mainSkin.hitAreas;
			hit_area.visible = false;
			addChild(hit_area);
			
			hit_overy = mainSkin.hitAreas.area_overy;
			hit_vegina = mainSkin.hitAreas.area_vegina;
			hit_cervix = mainSkin.hitAreas.area_cervix;
			hit_felopino = mainSkin.hitAreas.area_felopion;
			hit_uterus = mainSkin.hitAreas.area_uterus;
			
			_hint = new HintDynamic();
			_hint.x = 250;
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			TransitionHelper.fadeIn(msgSprite);
			
			DelayCall.call(function():void{
				buttonNext.visible = true;
				buttonNext.addEventListener(MouseEvent.CLICK, showPuzzleSolved);
			}, 1);
		}
		
		protected function showPuzzleSolved(event:MouseEvent):void
		{
			buttonNext.visible = false;
			buttonNext.removeEventListener(MouseEvent.CLICK, showPuzzleSolved);
			
			msgSprite.visible = false;
			hit_area.visible = true;
			
			imgRO.alpha = 1;
			
			hit_overy.addEventListener(MouseEvent.CLICK, showArea);
			hit_vegina.addEventListener(MouseEvent.CLICK, showArea);
			hit_cervix.addEventListener(MouseEvent.CLICK, showArea);
			hit_felopino.addEventListener(MouseEvent.CLICK, showArea);
			hit_uterus.addEventListener(MouseEvent.CLICK, showArea);
			
			showHint(true, "wewfbœ As‡ki Ici wK¬K K‡i †mB AskwU m¤ú‡K© wKQz Z_¨ †R‡b bvI");
			
			
			DelayCall.call(function ():void{
				buttonNext.visible = true;
				addChild(buttonNext);
				buttonNext.addEventListener(MouseEvent.CLICK, prepareNext);
			}, 5);
			
			
			/*com.mcc.interactives.utils.DelayCall.call(function():void{
				buttonNext.visible = true;
				buttonNext.addEventListener(MouseEvent.CLICK, prepareNext);
			}, 1);*/
		}
		
		private function showArea(e:MouseEvent):void{
			
			puzzleSolved.visible = true;
			
			switch(e.currentTarget){
				case hit_overy:
					puzzleSolved.gotoAndStop(1);
					break;
				case hit_felopino:
					puzzleSolved.gotoAndStop(2);
					break;
				case hit_uterus:
					puzzleSolved.gotoAndStop(3);
					break;
				case hit_cervix:
					puzzleSolved.gotoAndStop(4);
					break;
				case hit_vegina:
					puzzleSolved.gotoAndStop(5);
					break;
			}
		}
		
		//COMMON USER HINT 
		private var _hint:HintDynamic;
		//_hint = new HintDynamic();
		//_hint.x = 250;
		private function showHint(isShowing:Boolean, msg:String=''):void{
			if(isShowing){
				_hint.txt.text = ''+msg;
				addChild(_hint);
			}
			else if(_hint.parent){
				removeChild(_hint);
			}
		}
		////////////////////
		
		private function prepareNext(e:MouseEvent):void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}