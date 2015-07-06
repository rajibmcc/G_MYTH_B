package com.bbc_icontent.screens
{
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenMythBusterPoint extends Sprite
	{
		private var mainSkin:FL_PointEarned;
		
		private var clipPointEarned:MovieClip;
		private var clipPointStored:MovieClip;
		private var messageClip:MovieClip;
		private var messageText01:TextField;
		private var messageText02:TextField;
		private var buttonNext:Sprite;
		public function ScreenMythBusterPoint()
		{
			super();
			
			mainSkin = new FL_PointEarned();
			addChild(mainSkin);
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			
			clipPointEarned = mainSkin.clipStart;
			clipPointEarned.stop();
			clipPointEarned.visible = false;
			
			clipPointStored = mainSkin.clipEnd;
			clipPointStored.stop();
			clipPointStored.visible = false;
			
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
			clipPointEarned.visible = true;
			clipPointStored.visible = false;
			
			clipPointEarned.gotoAndPlay(1);
			AfterPlayClip.callBack(clipPointEarned, animateMessage);
		}
		
		private function animateMessage():void
		{
			messageClip.visible = true;
			messageClip.gotoAndPlay(1);
			AfterPlayClip.callBack(messageClip, function():void{DelayCall.call(prepareExit, .5)});
		}
		
		private function animPointStored(e:MouseEvent):void{
			buttonNext.removeEventListener(MouseEvent.CLICK, animPointStored);
			
			clipPointEarned.visible = false;
			clipPointStored.visible = true;
			clipPointStored.gotoAndPlay(1);
			AfterPlayClip.callBack(clipPointStored, exit);
		}
		
		private function prepareExit():void{
			buttonNext.visible = true;
			buttonNext.addEventListener(MouseEvent.CLICK, animPointStored);
		}
		
		private function exit():void{
			trace('Point Screen removing.......');
			
			if(this.parent){
				this.parent.removeChild(this);
			}
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
	}
}