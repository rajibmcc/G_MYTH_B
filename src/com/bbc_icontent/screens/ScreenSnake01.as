package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenSnake01 extends Screen
	{
		private var mainSkin:FL_ScreenSnake01;
		
		private var _textLine01:TextLine;
		private var _textLine02:TextLine;
		private var _textline03:TextLine;
		
		private var _snakeCoil:Sprite;
		private var _snakeStraight:Sprite;
		private var _snakeInfoDrop:MovieClip;
		private var _hitSnake:Sprite;
		
		private var _blackIn:MovieClip;

		
		public function ScreenSnake01()
		{
			super();
			
			var backgroundImage:Bitmap = Assets.getBackground(Assets.IMG_forestSnake2);
			addChild(backgroundImage);
			
			mainSkin = new FL_ScreenSnake01();
			addChild(mainSkin);
			
			_textLine01 = mainSkin.levelIntro as TextLine;
			_textLine01.visible = false;
			
			_textLine02 = mainSkin.info_detail as TextLine;
			_textLine02.visible = false;
			
			_textline03 = mainSkin.speechSnake as TextLine;
			_textline03.visible = false;
			
			_snakeCoil = mainSkin.snake_coil as Sprite;
			trace('x:y: '+_snakeCoil.x+':'+_snakeCoil.y);
			
			_snakeStraight = mainSkin.snake_straight as Sprite;
			_snakeStraight.visible = false;
			
			_snakeInfoDrop = mainSkin.anim_infoDrop as MovieClip;
			_snakeInfoDrop.stop();
			_snakeInfoDrop.visible = false;
			
			_hitSnake = mainSkin.hitAreaSnake as Sprite;
			
			_hint = new HintDynamic();
			_hint.x = 250;
			
			_blackIn = new FL_BlackBar_OUT();
			_blackIn.stop();
			addChild(_blackIn);
		}
		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
		}
		
		override public function hide():void
		{
			// TODO Auto Generated method stub
			super.hide();
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			DelayCall.call(function():void{
				_blackIn.play(), AfterPlayClip.callBack(_blackIn, showStartupDescription);
			}, 1);
			//AfterPlayClip.callBack(_blackIn, showStartupDescription);
		}
		
		private function showStartupDescription():void{
			removeChild(_blackIn);
			_textLine01.appear();
			_textLine01.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, levelHint);
			_textLine01.addEventListener(TextLineEvents.TEXTLINE_END, levelHint);
		}
		
		private function levelHint(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END){
				_textLine01.disAppear();
				return;
			}
			
			showHint(true, "KzÛjx cvKv‡bv mvcwUi Ici wK¬K K‡i †R‡b bvI mvcwU Kx ej‡Z Pvq|");
			
			
			_hitSnake.addEventListener(MouseEvent.CLICK, clickHandler_snake);
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
		
		private function clickHandler_snake(e:MouseEvent):void{
			_hitSnake.removeEventListener(MouseEvent.CLICK, clickHandler_snake);
			_snakeCoil.visible = false;
			_snakeStraight.visible = true;
			_snakeInfoDrop.visible = true;
			_snakeInfoDrop.gotoAndPlay(1);
			
			AfterPlayClip.callBack(_snakeInfoDrop, showInfoDetails);
		}
		
		private function showInfoDetails():void{
			_snakeInfoDrop.visible = false;
			_textLine02.visible = true;
			_textLine02.appear();
			
			_textLine02.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, showSpeech);
			_textLine02.addEventListener(TextLineEvents.TEXTLINE_END, showSpeech);
		}
		
		private function showSpeech(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END){
				_textLine02.disAppear();
				return;
			}
			
			_textLine02.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, showSpeech);
			_textLine02.addEventListener(TextLineEvents.TEXTLINE_END, showSpeech);
			
			_textline03.visible = true;
			_textline03.appear();
			
			_textline03.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, prepareNext);
			_textline03.addEventListener(TextLineEvents.TEXTLINE_END, prepareNext);
		}
		
		private function prepareNext(e:TextLineEvents):void{
			trace('LOADES NEXT.....');
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
	}
}