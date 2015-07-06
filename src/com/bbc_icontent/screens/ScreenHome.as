package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.SceneManager;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	public class ScreenHome extends Screen
	{
		private var mainSkin:FL_ScreenHome;
		
		private var _mov01:MovieClip;
		private var _textLine01:TextLine;
		private var _filmBlackBar:MovieClip;
		
		private var backgroundImage:Bitmap;		
		
		public function ScreenHome()
		{
			super();		
			
			backgroundImage = Assets.getBackground(Assets.IMG_forestHome);
			addChild(backgroundImage);
			
			mainSkin  = new FL_ScreenHome();
			addChild(mainSkin);
			
			_mov01 = mainSkin.mov01;
			_mov01.stop();
			
			_textLine01 = mainSkin.textLine01 as TextLine;
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
			_textLine01.appear();
			_textLine01.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, prepareExit);
			_textLine01.addEventListener(TextLineEvents.TEXTLINE_END, prepareExit);
		}
		
		private function prepareExit(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END) {
				_textLine01.disAppear();
				return;
			}
			
			
			_filmBlackBar = new FL_BlackBar_IN();
			addChild(_filmBlackBar);
			AfterPlayClip.callBack(_filmBlackBar, showEndMov);
		}
		
		private function showEndMov():void{
			_mov01.play();
			AfterPlayClip.callBack(_mov01, doExit);
		}
		
		private function doExit():void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_START));
		}
		
	}
}