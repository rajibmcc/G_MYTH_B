package com.mcc.interactives.IEvents
{
	import flash.events.Event;
	
	public class QuizEvents extends Event
	{
		public static var ANS_GIVEN:String = 'ans_given';
		public static var FINAL_ANS_GIVEN:String = 'final_ans_given';
		
		private var _correctAns:Boolean;
		public function QuizEvents(type:String, correctAns:Boolean, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_correctAns = correctAns;
			super(type, bubbles, cancelable);
		}
		
		public function get correctAns():Boolean{
			return _correctAns;
		}
	}
}