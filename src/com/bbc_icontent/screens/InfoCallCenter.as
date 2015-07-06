package com.bbc_icontent.screens
{
	import com.bbc_icontent.events.LevelEvents;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class InfoCallCenter extends Sprite
	{
		private var mainSkin:FL_CallCenterHelpLine;
		
		private var buttonClose:Sprite;
		public function InfoCallCenter()
		{
			super();
			
			mainSkin = new FL_CallCenterHelpLine();
			addChild(mainSkin);
			
			buttonClose = mainSkin.bt_close;
			
			buttonClose.addEventListener(MouseEvent.CLICK, onCloseButton);
		}
		
		protected function onCloseButton(event:MouseEvent):void
		{
			trace('Call center CLOSE clicked .....');
			buttonClose.removeEventListener(MouseEvent.CLICK, onCloseButton);
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
			if(this.parent) this.parent.removeChild(this);
		}		
		
	}
}