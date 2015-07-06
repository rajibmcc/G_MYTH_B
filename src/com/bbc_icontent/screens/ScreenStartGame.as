package com.bbc_icontent.screens
{
	import com.bbc_icontent.events.LevelEvents;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ScreenStartGame extends Sprite
	{
		private var mainSkin:FL_HowToPlay;
		public function ScreenStartGame()
		{
			super();
			
			mainSkin = new FL_HowToPlay();
			addChild(mainSkin);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			mainSkin.bt_play.addEventListener(MouseEvent.CLICK, hide);
		}
		
		protected function hide(event:MouseEvent):void
		{
			if(this.parent) this.parent.removeChild(this);
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_START));
		}
		
		public function set instruction(value:String):void{
			mainSkin.insMsg.text = ''+value;
		}
	}
}