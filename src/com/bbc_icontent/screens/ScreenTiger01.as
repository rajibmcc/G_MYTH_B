package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class ScreenTiger01 extends Screen
	{
		private var mainSkin:FL_ScreenTiger01;
		private var textline:TextLine;
		private var speechTiger:MovieClip;
		public function ScreenTiger01()
		{
			super();
			
			mainSkin = new FL_ScreenTiger01();
			addChild(mainSkin);
			
			speechTiger = mainSkin.infoTiger;
			speechTiger.visible = false;
			textline = mainSkin.textLine01;
			textline.syncPoints = [2];
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			textline.appear();
			textline.addEventListener(TextLineEvents.TEXTLINE_SYNC, onSync);
			textline.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, textLineEnd);
			textline.addEventListener(TextLineEvents.TEXTLINE_END, textLineEnd);
		}
		
		protected function textLineEnd(event:Event):void
		{
			if(event.type == TextLineEvents.TEXTLINE_END) {
				textline.disAppear();
				return;
			}
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
		protected function onSync(event:TextLineEvents):void
		{
			speechTiger.visible = true;
		}		
		
	}
}