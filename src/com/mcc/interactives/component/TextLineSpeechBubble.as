package com.mcc.interactives.component
{
	import com.mcc.objects.SpeechBubble;
	
	import flash.display.Sprite;
	
	public class TextLineSpeechBubble extends Sprite
	{
		protected var speechBubble:SpeechBubble;
		protected var speechs:Array;
		public function TextLineSpeechBubble()
		{
			super();
		}
		
		public function setSpeech(speech:Array):void{
			speechs = speech;
		}
	}
}