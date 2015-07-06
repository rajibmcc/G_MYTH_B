package 
{
	
	import com.bbc_icontent.Level;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.levels.LevelElephant;
	import com.bbc_icontent.levels.LevelSnake;
	import com.bbc_icontent.levels.LevelTiger;
	import com.bbc_icontent.screens.ScreenHome;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	
	[SWF(frameRate="40", width="600", height="400")]
	public class gmb_ extends Sprite
	{
		private var _currentIdLevel:int;
		private var _levels:Vector.<Class>;
		private var _currentLevel:Level;
		private var _movTheEnd:MovieClip;
		
		private var homeScreen:ScreenHome;
		public function gmb_()
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.NORMAL;
			
			
			/*_levels = new Vector.<Class>();
			_levels.push(LevelTiger, LevelElephant, LevelSnake);
			_currentIdLevel = -1;
			homeScreen = new ScreenHome();
			addChild(homeScreen);
			
			homeScreen.show();
			homeScreen.addEventListener(LevelEvents.LEVEL_START, startLevelFromBegining);*/
			
			var tScreen:TEST_SCREEN = new TEST_SCREEN();
			addChild(tScreen);
		}
		
		private function startLevelFromBegining(e:LevelEvents):void{
			homeScreen.hide();
			startNextLevel();
		}
		
		private function startNextLevel():void{
			if(_currentLevel != null){
				var _prevLevel:Level = _currentLevel;
				_currentLevel.removeEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
				_currentLevel.removeEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
				_prevLevel.destroy();
			}
			
			_currentLevel = nextLevel;
			
			if(_currentLevel != null){
				_currentLevel.initialize();
				_currentLevel.show();
				addChild(_currentLevel);
				_currentLevel.startLevel();
				_currentLevel.addEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
				_currentLevel.addEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
			}
			else{
				/*_movTheEnd = new ScreenTheEnd();
				addChild(_movTheEnd);
				AfterPlayClip.callBack(_movTheEnd, THE_END);*/
			}
			
		}
		
		private function THE_END():void{
			trace("````````````````````````````````````THE END```````````````````````````````````````````");
		}
		
		
		private function startPreviousLevel():void{
			if(_currentLevel != null){
				var _prevLevel:Level = _currentLevel;
				_currentLevel.removeEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
				_currentLevel.removeEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
				_prevLevel.destroy();
			}
			
			_currentLevel = prevLevel;
			
			_currentLevel.initialize();
			_currentLevel.show();
			addChild(_currentLevel);
			_currentLevel.startLevel();
			_currentLevel.addEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
			_currentLevel.addEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
		}
		
		
		private function goPreviousLevel(e:LevelEvents):void{
			startPreviousLevel();
		}
		
		
		private function goNevtLevel(e:LevelEvents):void{
			startNextLevel();
		}
		
		protected function get nextLevel(): Level {
			trace('------------------------------- GETING LEVEL\nTOTAL LEVEL:'+ _levels.length);
			if (_currentIdLevel + 1 < _levels.length) {
				_currentIdLevel++;
				trace('level is Returning...[INDEX:'+_currentIdLevel+']');
				trace('-------------------------------');
				var levelClass:Class = _levels[_currentIdLevel];
				return new levelClass();
			} else {
				trace('level is NULL');
				trace('-------------------------------');
				return null;
			}
		}
		
		protected function get prevLevel(): Level {
			trace('------------------------------- GETING LEVEL\nTOTAL LEVEL:'+ _levels.length);
			if (_currentIdLevel - 1 <= 0) {
				_currentIdLevel--;
				trace('level is Returning...[INDEX:'+_currentIdLevel+']');
				trace('-------------------------------');
				var levelClass:Class = _levels[_currentIdLevel];
				return new levelClass();
			} else {
				trace('level is NULL');
				trace('-------------------------------');
				return null;
			}
		}
	}
}