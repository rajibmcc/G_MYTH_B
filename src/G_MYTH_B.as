package 
{
	
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.ScoreGame;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.levels.LevelBird;
	import com.bbc_icontent.levels.LevelDeer;
	import com.bbc_icontent.levels.LevelElephant;
	import com.bbc_icontent.levels.LevelMonkey;
	import com.bbc_icontent.levels.LevelSnake;
	import com.bbc_icontent.levels.LevelTiger;
	import com.bbc_icontent.levels.LevelVodor;
	import com.bbc_icontent.screens.InfoCallCenter;
	import com.bbc_icontent.screens.ScreenHome;
	import com.bbc_icontent.screens.ScreenTheEnd;
	import com.mcc.interactives.SoundEngine;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(frameRate="40", width="1280", height="720")]
	public class G_MYTH_B extends Sprite
	{
		private var _currentIdLevel:int;
		private var _levels:Vector.<Class>;
		private var _currentLevel:Level;
		private var _movTheEnd:MovieClip;
		
		private var homeScreen:ScreenHome;
		
		private var hudScore:HudScore;
		public function G_MYTH_B()
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.NORMAL;
			
			InfoGame.initializeInfo();
			ScoreGame.initializeScore();

			_levels = new Vector.<Class>();
<<<<<<< HEAD
			_levels.push(LevelSnake, LevelVodor,  LevelElephant, LevelTiger, LevelDeer, LevelMonkey);
=======
			_levels.push(LevelBird, LevelVodor, LevelSnake, LevelElephant, LevelTiger, LevelDeer, LevelMonkey);
>>>>>>> rajibmcc/master
			_currentIdLevel = -1;
			homeScreen = new ScreenHome();
			addChild(homeScreen);
			
			homeScreen.show();
			homeScreen.addEventListener(LevelEvents.LEVEL_START, startLevelFromBegining);
			
			hudScore = new HudScore();
			hudScore.update();
			addChild(hudScore);
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
				
				ScoreGame.updateScore(_currentLevel.scoreValue);
				
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
				var screenTheEnd:ScreenTheEnd = new ScreenTheEnd();
				addChild(screenTheEnd);
			}
			
			hudScore.update();
			addChild(hudScore);
			
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
			var callCenterInfo:InfoCallCenter = new InfoCallCenter();
			addChild(callCenterInfo);
			callCenterInfo.addEventListener(LevelEvents.LEVEL_NEXT, hideCallCenter);
		}
		
		private function hideCallCenter(event:Event):void
		{
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