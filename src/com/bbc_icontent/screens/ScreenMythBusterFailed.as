package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenMythBusterFailed extends Screen
	{
		private var messageClip:MovieClip;
		private var messageText01:TextField;
		private var messageText02:TextField;
		private var buttonNext:Sprite;
		
		private var mainSkin:FL_PointMissed;
		
		public function ScreenMythBusterFailed()
		{
			super();
			
			mainSkin = new FL_PointMissed();
			addChild(mainSkin);
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			
			messageClip = mainSkin.animAll;
			messageClip.stop();
			messageClip.visible = false;
			messageText01 = mainSkin.animAll.message01.txt;
			messageText02 = mainSkin.animAll.message02.txt;
		}
		
		public function set setMessage(value:Array):void{
			messageText01.text = ''+value[0];
			messageText02.text = ''+value[1];
		}
		
		public function animPointEarned():void{			
			DelayCall.call(animateMessage, .5);
		}
		
		private function animateMessage():void
		{
			messageClip.visible = true;
			messageClip.gotoAndPlay(1);
			AfterPlayClip.callBack(messageClip, function():void{DelayCall.call(prepareExit, .5)});
		}
		
		private function prepareExit():void{
			buttonNext.visible = true;
			buttonNext.addEventListener(MouseEvent.CLICK, exit);
		}
		
		private function exit(e:MouseEvent):void{
			trace('Point Screen removing.......');
			buttonNext.removeEventListener(MouseEvent.CLICK, exit);
			if(this.parent){
				this.parent.removeChild(this);
			}
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}