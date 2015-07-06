package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.objects.Leaf;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenElephant02 extends Screen
	{
		private var mainSkin:FL_ScreenElephant02;
		private var speech:TextLine;
		private var totalSelected:int;
		private var correctSelected:int;
		private var buttonNext:Sprite;
		
		private var scoreLeaf:Sprite;
		private var scoreLeafText:TextField;
		
		public function ScreenElephant02()
		{
			super();
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_forestElephant2);
			addChild(background);
			
			mainSkin = new FL_ScreenElephant02();
			addChild(mainSkin);
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			
			speech = mainSkin.elephantSpeech;
			
			scoreLeaf = mainSkin.infoScore;
			scoreLeafText = mainSkin.infoScore.txt;
			scoreLeaf.visible = false;
			
			/*rLeaf01
			rLeaf02
			rLeaf03
			
			wLeaf01
			wLeaf02
			wLeaf03*/
			
			//trace(mainSkin.r_leaf03 is Leaf);
		
			
			Leaf(mainSkin.r_leaf01).selected = false;
			Leaf(mainSkin.r_leaf01).correctOne = true;
			
			Leaf(mainSkin.r_leaf02).selected = false;
			Leaf(mainSkin.r_leaf02).correctOne = true;
			
			Leaf(mainSkin.r_leaf03).selected = false;
			Leaf(mainSkin.r_leaf03).correctOne = true;
			
			Leaf(mainSkin.w_leaf04).selected = false;
			Leaf(mainSkin.w_leaf04).correctOne = false;
			
			Leaf(mainSkin.w_leaf05).selected = false;
			Leaf(mainSkin.w_leaf05).correctOne = false;
			
			Leaf(mainSkin.w_leaf06).selected = false;
			Leaf(mainSkin.w_leaf06).correctOne = false;
			
			
			mainSkin.r_leaf01.visible = false;
			mainSkin.r_leaf02.visible = false;
			mainSkin.r_leaf03.visible = false;
			mainSkin.w_leaf04.visible = false;
			mainSkin.w_leaf05.visible = false;
			mainSkin.w_leaf06.visible = false;
			
			/*mainSkin.r_leaf01.selected = false;
			
			mainSkin.r_leaf02.selected = false;
			
			mainSkin.r_leaf03.selected = false;
			
			mainSkin.w_leaf04.selected = false;
			
			mainSkin.w_leaf05.selected = false;
			
			mainSkin.w_leaf06.selected = false;
			*/
		}
		
		private function addListenerToLeaf(add:Boolean):void{
			if(add){
				mainSkin.r_leaf01.addEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.r_leaf02.addEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.r_leaf03.addEventListener(MouseEvent.CLICK, setSelected);
				
				mainSkin.w_leaf04.addEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.w_leaf05.addEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.w_leaf06.addEventListener(MouseEvent.CLICK, setSelected);
			}
			else{
				mainSkin.r_leaf01.removeEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.r_leaf02.removeEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.r_leaf03.removeEventListener(MouseEvent.CLICK, setSelected);
				
				mainSkin.w_leaf04.removeEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.w_leaf05.removeEventListener(MouseEvent.CLICK, setSelected);
				mainSkin.w_leaf06.removeEventListener(MouseEvent.CLICK, setSelected);
			}
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			DelayCall.call(function ():void{speech.appear()}, .5);
			
			speech.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, showInstruction);
			speech.addEventListener(TextLineEvents.TEXTLINE_END, showInstruction);
		}
		
		private function showInstruction(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END){
				speech.disAppear();
				return;
			}
			
			speech.visible = false;
			
			var instruction:ScreenStartGame = new ScreenStartGame();
			instruction.instruction = 'mwVK cvZv¸‡jv wK¬K K‡i wm‡j± Ki| g‡b †i‡Lv Zzwg wZbwU my‡hvM cv‡e| f‚j DË‡ii Rb¨ †Kvb c‡q›U cv‡e bv|';
			
			addChild(instruction);
			instruction.addEventListener(LevelEvents.LEVEL_START, startInteractive);
		}
		
		protected function startInteractive(event:Event):void
		{
			totalSelected = 0;
			scoreLeafText.text = ''+totalSelected;
			scoreLeaf.visible = true;
			
			
			mainSkin.r_leaf01.visible = true;
			mainSkin.r_leaf02.visible = true;
			mainSkin.r_leaf03.visible = true;
			mainSkin.w_leaf04.visible = true;
			mainSkin.w_leaf05.visible = true;
			mainSkin.w_leaf06.visible = true;
			
			addListenerToLeaf(true);
		}
		
		protected function setSelected(event:MouseEvent):void
		{
			event.currentTarget.removeEventListener(MouseEvent.CLICK, setSelected);
			Leaf(event.currentTarget).selected = true;
			
			if(Leaf(event.currentTarget).correctOne){
				correctSelected++;
			}
			totalSelected++;
			scoreLeafText.text = ''+totalSelected;
			
			trace('TOTAL CORRECT : '+correctSelected+'    '+'TOTAL SELECTED : '+totalSelected);
			
			if(totalSelected == 3){					
				DelayCall.call(showResult, .5);
			}
		}
		
		private function showResult():void
		{
			if(correctSelected >= 0){
				var pointEarned:ScreenMythBusterPoint = new ScreenMythBusterPoint();
				pointEarned.setMessage = ['`viæY! Zzwg AviI wKQz wg_ ev÷vi c‡q›U wR‡ZQ|', 'g‡b ‡i‡Lv, gvwmK GKwU ¯^vfvweK cÖwµqv| ZvB Gmgq †g‡qiv ¯^vfvweKfv‡eB Pjv‡div Ki‡Z cv‡i| cÖwZevi gvwm‡Ki mgq †cU †du‡c hvIqvi g‡Zv Abyf‚wZ n‡Z cv‡i| gvwm‡Ki mgq †g‡qiv Av‡ewM n‡q DV‡Z cv‡i|'];
				addChild(pointEarned);
				scoreValue = 5 * correctSelected;
				pointEarned.animPointEarned();
				pointEarned.addEventListener(LevelEvents.LEVEL_NEXT, prepareExit);
			}
			else{
				var resultScreen:ScreenMythBusterFailed = new ScreenMythBusterFailed();
				resultScreen.setMessage = ['`ytwLZ, Zzwg †Kvb wg_ ev÷vi c‡q›U wRZ‡Z cviwb| wKš‘ wPšÍvi wKQz †bB| Avwg †Zvgv‡K G¸‡Z w`‡ev|','g‡b ‡i‡Lv, gvwmK GKwU ¯^vfvweK cÖwµqv| ZvB Gmgq †g‡qiv ¯^vfvweKfv‡eB Pjv‡div Ki‡Z cv‡i| cÖwZevi gvwm‡Ki mgq †cU †du‡c hvIqvi g‡Zv Abyf‚wZ n‡Z cv‡i| gvwm‡Ki mgq †g‡qiv Av‡ewM n‡q DV‡Z cv‡i|'];
				addChild(resultScreen);
				
				resultScreen.animPointEarned();
				resultScreen.addEventListener(LevelEvents.LEVEL_NEXT, prepareExit);
			}
			
		}
		
		private function prepareExit(e:LevelEvents):void{
			addChild(buttonNext);
			buttonNext.visible = true;
			buttonNext.addEventListener(MouseEvent.CLICK, exit);
		}
		
		protected function exit(event:MouseEvent):void
		{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}