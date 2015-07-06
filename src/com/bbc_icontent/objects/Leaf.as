package com.bbc_icontent.objects
{
	import flash.display.Sprite;
	
	public class Leaf extends Sprite
	{
		protected var _correctOne:Boolean;
		protected var _selected:Boolean;
		
		protected var _rmark:Sprite;
		protected var _wmark:Sprite;
		public function Leaf()
		{
			super();
			_rmark = getChildByName("mark_r") as Sprite;
			_wmark = getChildByName("mark_w") as Sprite;
			_selected = false;
			if(_rmark != null) _rmark.visible = false;
			if(_wmark != null) _wmark.visible = false;
			
			mouseChildren = false;
		}
		
		public function set correctOne(value:Boolean):void{
			_correctOne = value;
		}
		
		public function get correctOne():Boolean{
			return _correctOne;
		}
		
		public function set selected(value:Boolean):void{
			_selected = value;
			
			if(_correctOne && _rmark !=null){
				_rmark.visible = _selected;
			}
			else if(_wmark != null){
				_wmark.visible = _selected;
			}
		}
		
		public function get selected():Boolean{
			return _selected;
		}
	}
}