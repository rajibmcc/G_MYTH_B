package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.custom_elements.DropTargetJigsaw;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.animation.TransitionHelper;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import flash.events.MouseEvent;
	
	import flash.geom.Point;
	
	public class ScreenSnake02 extends Screen
	{
		private var mainSkin:FL_ScreenSnake02;
		
		private var msgTitle:Sprite;
		private var msgDetails:Sprite;
		
		private var pieac01:Sprite;
		private var pieac02:Sprite;
		private var pieac03:Sprite;
		private var pieac04:Sprite;
		
		private var buttonNext:Sprite;
		
		private var backgroundImage:Bitmap;
		
		private var pointScreen:ScreenMythBusterPoint;
		
		
		private var placeHolders: Vector.<DropTargetJigsaw>;
		private var dragables: Vector.<Sprite>;		
		private var storePositions: Vector.<Point>;
		private var dragCurrent: Sprite;
		private var placeTarget: DropTargetJigsaw;
		private var placedTotal: int;
		private var dragOffsetX: Number;
		private var dragOffsetY: Number;
		private var dragActive: Boolean;
		
		public function ScreenSnake02()
		{
			super();
			
			backgroundImage = Assets.getBackground(Assets.IMG_forestSnake2);
			addChild(backgroundImage);
			
			mainSkin = new FL_ScreenSnake02();
			addChild(mainSkin);
			
			msgTitle = mainSkin.titleJig as Sprite;
			msgTitle.visible = false;
			msgDetails = mainSkin.msgJigComplete;
			msgDetails.visible = false;
			
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			
			pieac01 = new Sprite();pieac01.name="pieac01";
			pieac01.addChild(Assets.getBackground(Assets.IMG_jigFR01));
			pieac02 = new Sprite();pieac02.name="pieac02";
			pieac02.addChild(Assets.getBackground(Assets.IMG_jigFR02));
			pieac03 = new Sprite();pieac03.name="pieac03";
			pieac03.addChild(Assets.getBackground(Assets.IMG_jigFR03));
			pieac04 = new Sprite();pieac04.name="pieac04";
			pieac04.addChild(Assets.getBackground(Assets.IMG_jigFR04));
			
			placeHolders = new Vector.<DropTargetJigsaw>();
			dragables = new Vector.<Sprite>();
			storePositions = new Vector.<Point>();
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			msgTitle.visible = true;
			TransitionHelper.fadeIn(msgTitle, .3);
			
			pieac01.x = 153;
			pieac01.y = 92;
			addChild(pieac01);
			
			pieac02.x = 932;
			pieac02.y = 92;
			addChild(pieac02);
			
			pieac03.x = 153;
			pieac03.y = 426;
			addChild(pieac03);
			
			pieac04.x = 932;
			pieac04.y = 426;
			addChild(pieac04);
			
			//DUMMY SOLVER
			//pieace04.addEventListener(MouseEvent.CLICK, sucess);
			
			placeHolders.push(mainSkin.place01, mainSkin.place02, mainSkin.place03, mainSkin.place04);
			dragables.push(pieac01, pieac02, pieac03, pieac04);
			
			
			//swap random position 
			/*for (var i:int = 0; i < dragables.length; i++) {
			storePositions.push(new Point(dragables[i].x, dragables[i].y));
			}*/
			
			
			//store position for reset
			for (var i:int = 0; i < dragables.length; i++) {
				storePositions.push(new Point(dragables[i].x, dragables[i].y));
			}		
			
			startQuiz();
			
		}
		
		private function startQuiz():void{
			
			placedTotal = 0;
			
			enableDraging();
		}
		
		private function enableDraging(): void {
			for (var i: int = 0; i < dragables.length; i++) {
				//trace('>>>>>>> ' + dragables[i].name);
				dragables[i].addEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
			}
		}
		
		private function stickWithPointer(e: MouseEvent): void {
			trace('MOUSE DOWN happend');
			if (!dragActive) {
				dragCurrent = e.currentTarget as Sprite;
				addChild(dragCurrent);
				
				dragCurrent.removeEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
				dragActive = true;
				dragOffsetX = dragCurrent.x - stage.mouseX;
				dragOffsetY = dragCurrent.y - stage.mouseY;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, dragOverStage);
				stage.addEventListener(MouseEvent.MOUSE_UP, dragCompleted);
			} 
			else return;
		}
		
		private function dragOverStage(e: MouseEvent): void {
			dragCurrent.x = dragOffsetX + stage.mouseX;
			dragCurrent.y = dragOffsetY + stage.mouseY;
			checkCollision(dragCurrent);
		}
		
		private function dragCompleted(e: MouseEvent): void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragOverStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, dragCompleted);
			dragCurrent.addEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
			placeTarget = checkCollision(dragCurrent);
			var index:int;
			if(placeTarget != null && placeTarget){
				var nameTarget:String = placeTarget.name;
				var nameObject:String = dragCurrent.name;
				
				trace(nameTarget+" "+nameObject);
				
				if(nameTarget.substr(5) == nameObject.substr(5)){
					dragCurrent.x = placeTarget.x ;//+ placeTarget.width*.5 - dragCurrent.width*.5;
					dragCurrent.y = placeTarget.y ;//+ placeTarget.height*.5 - dragCurrent.height*.5;
					trace(dragCurrent.x +" "+ placeTarget.x+"<>"+dragCurrent.y +" " + placeTarget.y);
					placeTarget.empty = false;
					dragCurrent.mouseEnabled = false;
					placedTotal++;
					if(placedTotal == placeHolders.length){
						
						//DelayCall.call(sucess, 1);
						scoreValue = 5;
						success();
					}
				}
				else{
					index = dragables.indexOf(dragCurrent);
					trace(storePositions[index].x +'  ::  '+storePositions[index].y);
					dragCurrent.x = storePositions[index].x;
					dragCurrent.y = storePositions[index].y;
				}
				
			}
			else{
				index = dragables.indexOf(dragCurrent);
				trace(storePositions[index].x +'  ::  '+storePositions[index].y);
				dragCurrent.x = storePositions[index].x;
				dragCurrent.y = storePositions[index].y;
			}
			//trace(placeTarget);
			dragActive = false;
			restoreAlpha();
		}
		
		private function checkCollision(movingObject:Sprite):DropTargetJigsaw{
			var mObject:Sprite = movingObject;
			var targetObject:DropTargetJigsaw;
			var dx:Number = 0;
			var dy:Number = 0;
			var distance:Number = 0;
			var range:Number = 65;
			
			for(var i:int = 0; i<placeHolders.length; i++){
				targetObject = placeHolders[i] as DropTargetJigsaw;
				dx = movingObject.x - targetObject.x;
				dy = movingObject.y - targetObject.y;
				
				distance = Math.sqrt(dx*dx + dy*dy);
				if(distance < range && targetObject.empty){
					targetObject.alpha = .2;
					return targetObject;
				}
				else{
					targetObject.alpha = 1;
				}				
			}
			
			return null;
		}
		
		private function restoreAlpha():void{
			for(var i:int = 0; i<placeHolders.length; i++){
				placeHolders[i].alpha = 1;
			}
		}
		
		//USE THIS FUNCTION AFTER PUZZLE SOLVED/////////
		protected function success():void
		{
			DelayCall.call(pointEarned, .2);
		}
		
		
		private function pointEarned():void{
			pointScreen = new ScreenMythBusterPoint();
			addChild(pointScreen);
			pointScreen.setMessage = ["`viæY! Zzwg †Zvgvi cÖ_g wg_ ev÷vi c‡q›U wR‡ZQ|",
				"†Zvgvi †gjv‡bv wRMm cvRjwU Avi GKevi †`‡L †bqv hvK hv‡Z Zzwg AviI fvjfv‡e Rvb‡Z cv‡iv †g‡q‡`i cÖRbb Z‡š¿i †Kvb AskwU Avm‡j Kx|"];
			
			pointScreen.animPointEarned();
			pointScreen.addEventListener(LevelEvents.LEVEL_NEXT, prepareExit);
			/*	*/
		}
		/////////////////////////////////////////
		
		private function prepareExit(e:LevelEvents):void{
			pointScreen.removeEventListener(LevelEvents.LEVEL_NEXT, prepareExit);
			
			DelayCall.call(function ():void{
				buttonNext.visible = true;
				addChild(buttonNext);
				buttonNext.addEventListener(MouseEvent.CLICK, exit);
			}, .3);
		}
		
		private function exit(e:MouseEvent):void{
			buttonNext.removeEventListener(MouseEvent.CLICK, exit);
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}