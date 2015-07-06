package com.bbc_icontent.objects
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Fruit extends Sprite
	{
		protected var covered:MovieClip;
		protected var cleared:MovieClip;
		protected var hitPoint:Sprite;
		
		private var statClear:Boolean;
		private var statLive:Boolean;
		
		private var _dropped:Boolean;
		private var _vy:Number = 1;
		public function Fruit()
		{
			super();
			
			covered = getChildByName("cover") as MovieClip;
			cleared = getChildByName("clear") as MovieClip;	
			hitPoint = getChildByName("hitFruit") as Sprite;
			statClear = false;
			_dropped = false;
		}
		
		public function get vy():Number
		{
			return _vy;
		}

		public function set vy(value:Number):void
		{
			_vy = value;
		}

		public function set live(value:Boolean):void{
			statLive = value;
			value == true ? hitPoint.addEventListener(MouseEvent.MOUSE_DOWN, shootFruit) : hitPoint.removeEventListener(MouseEvent.MOUSE_DOWN, shootFruit);
			
		}
		
		private function shootFruit(e:MouseEvent):void{
			statClear == true ? dropFruit() : missFruit();
		}
		
		public function get dropped():Boolean{
			return _dropped;
		}

		
		private function dropFruit():void{
			//trace(this+" Fruit : HIT");
			_dropped = true;
			live = false;
			covered.visible = false;
			cleared.visible = true;
			
			this.dispatchEvent(new Event('HIT'));
		}
		
		private function missFruit():void{
			//trace(this+" Fruit : MISSED");
		}
		
		public function flip():void{
			statClear = !statClear;
			covered.visible = !statClear;
			cleared.visible = statClear;
			
			//trace("Fruit cleared : "+statClear);
		}
	}
}