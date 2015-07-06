package com.mcc.interactives.component
{
	import com.greensock.TweenLite;
	import com.mcc.interactives.IEvents.QuizEvents;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class Quizer extends EventDispatcher
	{
		private var quizSkin:Sprite;
		private var _quizOptions:int;
		
		private var _optionNamePrefix:String = 'option';
		private var _optionsSkins:Array;
		private var _quizArrayAll:Array;
		
		private var _currentQuizArray:Array;
		private var _currentQuizCount:int;
		//private var 
		//private var _options:Array;
		
		private var _ansGiven:Boolean;
		
		public function Quizer(quizOptions:int, quizArr:Array, skin:Sprite)
		{
			super();
			_ansGiven = false;
			_optionsSkins = new Array();
			//_options = new Array();
			_currentQuizCount = 0;
			_quizOptions = quizOptions;			
			quizSkin = skin;
			_quizArrayAll = quizArr;
			elementCrawler();
		}
		
		public function get currentQuizCount():int
		{
			return _currentQuizCount;
		}
		
		private function elementCrawler():void
		{
			for(var i:int = 1; i <= quizSkin.numChildren; i++){
				var searchName:String = _optionNamePrefix+i;
				var op:Sprite = quizSkin.getChildByName(searchName) as Sprite;
				//trace(op);
				if(op != null){
					_optionsSkins.push(op);
				}
				
			}
			//trace('hello'+_optionsSkins);
		}
		
		
		private var optionButtons:Array = new Array();
		public function ask():void{
			removeListeners();
			
			if(_currentQuizCount < _quizArrayAll.length){
				_ansGiven = true;				
				
				var option:Sprite;
				_currentQuizArray = new Array();
				_currentQuizArray = _currentQuizArray.concat(_quizArrayAll[_currentQuizCount]);
				
				var tmpOptionSkin:Array = new Array();
				tmpOptionSkin = tmpOptionSkin.concat(_optionsSkins);
				
				var placeCorrectAt:int = Math.floor(Math.random() * _currentQuizArray.length);
				option = tmpOptionSkin[placeCorrectAt] as Sprite;
				tmpOptionSkin.splice(placeCorrectAt, 1);
				TextField(option.getChildByName('txt')).text = ''+_currentQuizArray.shift();
				
				option.addEventListener(MouseEvent.CLICK, correctAnsChoosen);
				optionButtons.push(option);
				
				
				for(var i:int = 0; i < _currentQuizArray.length; i++){
					//trace('rest question ... ...');
					option = tmpOptionSkin[i] as Sprite;
					TextField(option.getChildByName('txt')).text = ''+_currentQuizArray[i];
					
					option.addEventListener(MouseEvent.CLICK, wrongAnsChoosen);
					optionButtons.push(option);
				}
				
				_currentQuizCount++;
				for(i = 0; i< optionButtons.length; i++){
					TweenLite.fromTo(optionButtons[i] as Sprite, 1, {alpha:0}, {alpha:1});
				}
				
			}
			
		}
		
		private function removeListeners():void{
			for each(var option:Sprite in optionButtons){
				option.removeEventListener(MouseEvent.CLICK, wrongAnsChoosen);
				option.removeEventListener(MouseEvent.CLICK, correctAnsChoosen);
			}
			
			optionButtons = [];
		}
		
		protected function wrongAnsChoosen(event:MouseEvent):void
		{
			_ansGiven = false;
			if(_currentQuizCount == _quizArrayAll.length){
				this.dispatchEvent(new QuizEvents(QuizEvents.FINAL_ANS_GIVEN, false));
			}
			else{
				this.dispatchEvent(new QuizEvents(QuizEvents.ANS_GIVEN, false));
			}
		}
		
		protected function correctAnsChoosen(event:MouseEvent):void
		{
			trace(this+' [CORRECT ANS CHOOSEN]');
			_ansGiven = false;
			this.dispatchEvent(new QuizEvents(QuizEvents.ANS_GIVEN, true));
		}
		
		public function get isAllAnswerDone():Boolean{
			return _currentQuizCount == _quizArrayAll.length;
		}
	}
}