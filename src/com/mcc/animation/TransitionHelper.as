package com.mcc.animation
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;

	public class TransitionHelper
	{
		public static function fadeIn(target:DisplayObject, duration:Number = .8, visibility = false):void
		{
			TweenLite.fromTo(target, duration,{alpha:0},{alpha:1});//, onComplete:setVisibility, onCompleteParams:[visibility]});
/*			
			function setVisibility(visibility:Boolean):void{
				target.visible = false;
				trace('Visibility changed after transition : '+target.visible);
			}*/
		}
		
		public static function fadeOut(target:DisplayObject, duration:Number = .8):void{
			target.visible = true;
			TweenLite.fromTo(target, duration, {alpha:1},{alpha:0});
		}
	}
}