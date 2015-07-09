package  com.mcc.interactives{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SoundEngine extends EventDispatcher{
		private static var _masterChannel:SoundChannel;
		private static var _voiceChannel:SoundChannel;
		private static var _soundTransform:SoundTransform;
		private static var _fxSoundChannel:SoundChannel;
		
		private static var _soundClasses:Array = [];
		private static var _soundIndex:int;
		
		public static var voiceOver:EventDispatcher = new EventDispatcher();
		
		private static var _voiceOver:Sound;
		
		public static function set masterMusic(value:Class):void{
			//_soundTransform.volume = 2;
			if(_soundTransform == null){
				_soundTransform = new SoundTransform();
			}
			if(_masterChannel == null){
				_masterChannel = new SoundChannel();
			}
			_soundTransform.volume = .3;
			var _masterSound:Sound = new value();
			_masterChannel = _masterSound.play(0, 999);
			_masterChannel.soundTransform = _soundTransform;
			trace('MASTER SOUND playing......');
		}
		
		public static function set masterMusicVolume(value:Number):void{
			_soundTransform.volume = value;
			_masterChannel.soundTransform = _soundTransform;
			trace('MASTER SOUND volume changed.........');
		}
		
		public static function playVoiceOver(... soundClasses):void{
			//if(_voiceChannel == null) 
			trace('SOUND ADDED ......');
			_voiceChannel = new SoundChannel();
			
			_soundIndex = 0;
			_soundClasses = soundClasses;
			
			var _voiceOver:Sound = nextSound;
			_voiceChannel = _voiceOver.play();
			//_voiceChannel.removeEventListener(Event.SOUND_COMPLETE, onVoiceOverComplete);
			_voiceChannel.addEventListener(Event.SOUND_COMPLETE, onVoiceOverComplete);
			
			//	trace('VOICE SOUND playing..........');
		}
		
		private static function onVoiceOverComplete(e:Event):void{
			//trace('VOICE SOUND COMPLETED..........');
			trace('PLAYING SOUND INDEX : '+_soundIndex);
			
			_voiceOver = nextSound;
			if(_voiceOver != null){
				_voiceChannel = null;
				_voiceChannel = _voiceOver.play();
				_voiceChannel.addEventListener(Event.SOUND_COMPLETE, onVoiceOverComplete);
			}
			else{
				trace('SOUND COMPLETE : -------DISPATCHED--------------');
				_soundClasses=[];
				_voiceChannel.removeEventListener(Event.SOUND_COMPLETE, onVoiceOverComplete);
				voiceOver.dispatchEvent(new Event(Event.SOUND_COMPLETE));
			}
		}
		
		public static function stopVoiceOver():void{
			if(_voiceChannel == null) return;
			_voiceChannel.stop();
			trace('VOICE SOUND stoped..........');
		}
		
		public static function playFx(soundClass:Class):void{
			if(_fxSoundChannel == null){
				_fxSoundChannel = new SoundChannel();
			}
			var _fxSound:Sound = new soundClass();
			_fxSoundChannel = _fxSound.play();
		}
		
		public static function stopFx():void{
			if(_fxSoundChannel == null) return;
			_fxSoundChannel.stop();
		}
		
		public static function stopMasterMusic():void{
			if(_masterChannel == null) return;
			_masterChannel.stop();
			trace('MASTER SOUND stoped......');
		}
		
		private static function get nextSound():Sound{
			if(_soundIndex < _soundClasses.length){
				var sClass:Class = _soundClasses[_soundIndex];
				_soundIndex++;				
				trace('RETURNING SOUND .......'+'TOTAL SOUNDS : '+_soundClasses.length);
				return new sClass() as Sound;
			}
				
			else {
				trace('RETURNING NULL SOUND .......');
				return null;
			}
		}
	}
	
}
