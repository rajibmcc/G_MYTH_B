package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class ScreenMonkey01 extends Screen
	{
		private var mainSkin:FL_ScreenMonkey01;
		private var textline:TextLine;
		public function ScreenMonkey01()
		{
			super();
			var background:Bitmap = Assets.getBackground(Assets.IMG_forest_monkey);
			addChild(background);
			mainSkin = new FL_ScreenMonkey01();
			addChild(mainSkin);
			
			textline = mainSkin.textLine01;
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			textline.appear();
			textline.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, prepareNext);
			textline.addEventListener(TextLineEvents.TEXTLINE_END, prepareNext);
		}
		
		protected function prepareNext(event:TextLineEvents):void
		{
			if(event.type == TextLineEvents.TEXTLINE_END){
				textline.removeEventListener(TextLineEvents.TEXTLINE_END, prepareNext);
				textline.disAppear();
				return;
			}
			
			textline.removeEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, prepareNext);
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
	}
}