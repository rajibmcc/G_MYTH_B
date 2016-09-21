package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.custom_elements.Connector;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class ScreenSnake04 extends Screen
	{
		private var hit_area:Sprite;
		private var hit_overy:Sprite;
		private var hit_vegina:Sprite;
		private var hit_cervix:Sprite;
		private var hit_felopino:Sprite;
		private var hit_uterus:Sprite;
		
		private var tag_overy:Sprite;
		private var tag_vegina:Sprite;
		private var tag_cervix:Sprite;
		private var tag_felopino:Sprite;
		private var tag_uterus:Sprite;
		
		private var mainSkin:FL_ScreenSnake04;
		
		private var matchedTotal:int;
		private var matchedGoal:int;
		
		private var cl1:Sprite,cl2:Sprite, cl3:Sprite, cl4:Sprite, cl5:Sprite,
		cr1:Sprite, cr2:Sprite, cr3:Sprite,  cr4:Sprite, cr5:Sprite;
		
		
		
		private var matchables:Vector.<Sprite > ;
		private var matchDone:Vector.<Sprite > ;
		private var matchablesLeft:Vector.<Sprite > ;
		private var matchablesRight:Vector.<Sprite> ;
		
		private var line:Connector;
		private var lines:Vector.<Connector > ;
		
		private var startPoint:Point,endPoint:Point;
		private var startClip:MovieClip,endClip:MovieClip;
		
		private var dataArr:Array=new Array();
		private var separetor:String = "/";
		
		
		private var buttonNext:Sprite;
		
		public function ScreenSnake04()
		{
			super();
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_forestSnake2);
			addChild(background);
			
			var guideImage:Bitmap = Assets.getBackground(Assets.IMG_jigFR);
			guideImage.x = 440;
			guideImage.y = 160;
			addChild(guideImage);
			
			mainSkin = new FL_ScreenSnake04();
			addChild(mainSkin);
			
			buttonNext = mainSkin.bt_next;
			
			
			hit_overy = mainSkin.hitAreas.area_overy;
			hit_vegina = mainSkin.hitAreas.area_vegina;
			hit_cervix = mainSkin.hitAreas.area_cervix;
			hit_felopino = mainSkin.hitAreas.area_felopion;
			hit_uterus = mainSkin.hitAreas.area_uterus;
			
			tag_overy = mainSkin._tag_overy;
			tag_vegina = mainSkin._tag_vegina;
			tag_cervix = mainSkin._tag_cervix;
			tag_felopino = mainSkin._tag_felopino;
			tag_uterus = mainSkin._tag_uterus;
			
			
			
			//==========
			//left side
			cl1 = hit_overy;
			cl2 = hit_vegina;
			cl3 = hit_cervix;
			cl4 = hit_felopino;
			cl5 = hit_uterus;
			
			
			matchablesLeft=new Vector.<Sprite>();
			matchablesLeft.push(cl1, cl2, cl3, cl4, cl5 );
			
			//right side;
			cr1 = tag_overy;
			cr2 = tag_vegina;
			cr3 = tag_cervix;
			cr4 = tag_felopino;
			cr5 = tag_uterus;
			
			matchablesRight=new Vector.<Sprite>();
			matchablesRight.push(cr1, cr2, cr3, cr4, cr5);
			
			//mouse over
			cl1.addEventListener(MouseEvent.MOUSE_UP, onMouseOver);
			
			
			//data array;
			dataArr.push("cl1"+separetor+"cr1",
				"cl2"+separetor+"cr2", 
				"cl3"+separetor+"cr3",
				"cl4"+separetor+"cr4",
				"cl5"+separetor+"cr5");
			
			
			matchables=new Vector.<Sprite>();
			matchables = matchablesLeft.concat(matchablesRight);
			//hide all matching parts
			showHideMatching(matchables, true);
			
			matchDone=new Vector.<Sprite>();
			
			//prepareMatching(dataArr, matchablesLeft, matchablesRight );
			
			lines=new Vector.<Connector>();
			
			
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			trace("onMouseOver"+e.target);
		}
		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
			
		}
		
		
		private function addMatchingListener():void
		{
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		private function removeMatchingListener():void
		{
			if(stage){
				stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
				stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			}
		}
		
		private var activeDrawLine:Boolean;
		private function mouseDownHandler(event:MouseEvent):void
		{
			trace("down");
			
			for (var i:int=0; i<matchables.length; i++)
			{
				var target:MovieClip = matchables[i] as MovieClip;
				if (target.hitTestPoint(mouseX,mouseY,true))
				{
					
					
					startPoint = new Point(matchables[i].x,matchables[i].y);
					activeDrawLine = true;
					startClip = matchables[i];
					startClip.alpha = 0.75;
					break;
				}
			}
			
			if (activeDrawLine)
			{
				line = new Connector();
				addChild(line);
				lines.push(line);
				
				line.graphics.lineStyle(6);
				stage.addEventListener(MouseEvent.MOUSE_MOVE,movement);
				line.addEventListener(MouseEvent.CLICK,onLineClicked);
				activeDrawLine = false;
			}
		}
		
		
		private function showHideMatching(cnt:Vector.<Sprite>, visibility:Boolean):void
		{
			for (var i:int=0; i<cnt.length; i++)
			{
				cnt[i].visible = visibility;
			}
		}
		
		private function prepareMatching(_data:Array, cntLeft:Vector.<Sprite>, cntRight:Vector.<Sprite>):void
		{
			for (var i:int=0; i<_data.length; i++)
			{
				var st:String = _data[i];
				var partLeft:String = st.substr(0,st.indexOf(separetor));
				var partRight:String = st.substr(st.indexOf(separetor) + 1,st.length);
				
				cntLeft[i].name= partLeft;
				cntRight[i].name = partRight;
			}
			
			
		}
		
		private function mouseUpHandler(event:MouseEvent):void
		{
			trace("up");
			//line.graphics.clear();
			if(stage) stage.removeEventListener(MouseEvent.MOUSE_MOVE,movement);
			
			
			var isReleasedonTarget:Boolean;
			///
			for (var i:int=0; i<matchables.length; i++)
			{
				//trace("for "+ i);
				
				var target:MovieClip = matchables[i] as MovieClip;
				//trace("target: "+target);
				if (line!=null && target!=null && startClip!=null && target.name.substr(4) != startClip.name.substr(4) && target != startClip && target.hitTestPoint(mouseX,mouseY,true))
				{

					//trace("if "+i);
					endPoint = new Point(mouseX, mouseY);//(matchables[i].x,matchables[i].y);
					
					line.graphics.clear();
					line.graphics.moveTo(startPoint.x,startPoint.y );
					//line.graphics.lineStyle(8,0x930000);
					line.graphics.lineStyle(8,getColor().color);
					
					
					// this is the line I was fogetting before;
					line.graphics.lineTo(endPoint.x,endPoint.y);
					
					endClip = matchables[i];
					endClip.alpha = 0.75;
					startClip.alpha = .75;
					
					line.startClip = startClip;
					line.endClip = endClip;
					trace('LINE HIT WITH --------------------------------------- TARGET'+startClip.name+'<>'+endClip.name);
					
					matchables.splice(matchables.indexOf(startClip),1);
					matchables.splice(matchables.indexOf(endClip),1);
					
					matchDone.push(startClip,endClip);
					
					//add boarder
					addBorder(endClip);
					removeBorder(endClip);
					
					
					
					
					isReleasedonTarget = true;
					line = null;
					
					if (lines.length == dataArr.length)
					{
						resultCheck();
					}
					
					break;
					
					
				}
				else
				{
					if (startClip!=null)
					{
						startClip.alpha = 1;
					}
				}
				
				
			}
			
			if (! isReleasedonTarget)
			{
				if (line!=null && contains(line))
				{
					lines.splice(lines.indexOf(line),1);
					line.graphics.clear();
					trace(line);
					removeChild(line);
					line = null;
				}
				isReleasedonTarget = false;
			}
			
			trace("lines : "+lines.length);
		}
		
		
		private function addBorder(myMC):void{
			
			var mc:MovieClip = new MovieClip();
			mc.name="Border";
			mc.graphics.lineStyle(2, 0x009900);
			mc.graphics.drawRect(0, 0, myMC.width, myMC.height);
			mc.graphics.endFill();
			myMC.addChild(mc);
			
		}
		
		private function removeBorder(myMC:MovieClip):void{
			
			var mc:DisplayObject =myMC.getChildByName("Border");
			
			var tm:Timer = new Timer(1000,2);
			tm.addEventListener(TimerEvent.TIMER_COMPLETE, onCompleteRemovedDealy);
			
			function onCompleteRemovedDealy(e:TimerEvent):void{
				trace("timer comlete");
				myMC.removeChild(mc);
			}
			
			tm.start();
			
		}
		
		
		private function resultCheck():void
		{
			
			
			var totalMatchFound:int = 0;
			for (var j:int=0; j<lines.length; j++)
			{
				var cntr:Connector = lines[j] as Connector;
				var retivedSentace:String = cntr.startClip.name + separetor + cntr.endClip.name;
				
				for (var k:int=0; k<dataArr.length; k++)
				{
					if (retivedSentace==dataArr[k])
					{
						
						totalMatchFound++;
						break;
					}
				}
				
			}
			
			if (totalMatchFound == 0)
			{
				removeMatchingListener();
				trace("FAILED "+ totalMatchFound);
				this.scoreValue = 0;
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
				
				showResult(false);
			}
			else
			{
				removeMatchingListener();
				trace("try again "+ totalMatchFound );
				this.scoreValue = totalMatchFound;
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
				
				showResult(true);
			}
		}
		
		
		private function movement(event:MouseEvent):void
		{
			//trace("Move");
			line.graphics.clear();
			line.graphics.moveTo(startPoint.x,startPoint.y );
			line.graphics.lineStyle(6,0x930000, 0.5);
			
			// this is the line I was fogetting before;
			line.graphics.lineTo(mouseX,mouseY);
		}
		
		private function onLineClicked(e:MouseEvent):void
		{
			//line.graphics.clear();
			
			
			
			var removeLine:Connector = e.currentTarget as Connector;
			matchables.push(removeLine.startClip, removeLine.endClip);
			removeLine.startClip.alpha = 1;
			removeLine.endClip.alpha = 1;
			
			matchDone.splice(matchDone.indexOf(removeLine.startClip),1);
			matchDone.splice(matchDone.indexOf(removeLine.endClip),1);
			
			trace(removeLine.x+" "+removeLine.y+ " "+removeLine.width+" "+removeLine.height);
			lines.splice(lines.indexOf(removeLine),1);
			removeChild(removeLine);
			trace(removeLine.x+" "+removeLine.y);
			
		}
		
		
		
		private function getColor():ColorTransform
		{
			
			var colorArray:Array = new Array(0xFFFF33,0xFF50FF,0x79DCF4,0xFF3333,0xFFCC33,0x99CC33);
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);
			
			var myColor:ColorTransform = new ColorTransform();
			myColor.color = colorArray[randomColorID];
			
			//myMovieClip.transform.colorTransform = myColor;
			
			return myColor;
			
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			addMatchingListener();
			
			buttonNext.addEventListener(MouseEvent.CLICK, nextLevelButton);
		}
		
		private function nextLevelButton(e:MouseEvent):void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
		

		private function showResult(sucess:Boolean):void{
			if(sucess){
				var pointEarned:ScreenMythBusterPoint = new ScreenMythBusterPoint();
				pointEarned.setMessage = [' Zzwg AviI wg_ ev÷vi c‡q›U wR‡ZQ|','†Zvgvi †gjv‡bv QweUv Avi GKevi †`‡L †bqv hvK hv‡Z Zzwg fvjfv‡e  †g‡q‡`i cÖRbb Z‡š¿i wewfbœ Ask¸‡jv  g‡b ivL‡Z cv‡iv|'];
				addChild(pointEarned);
				pointEarned.animPointEarned();
				pointEarned.addEventListener(LevelEvents.LEVEL_NEXT, prepareExit);
			}
			else{
				var pointMissed:ScreenMythBusterFailed = new ScreenMythBusterFailed();
				pointMissed.setMessage = ['`ytwLZ, Zzwg †Kvb wg_ ev÷vi c‡q›U wRZ‡Z cviwb|','wKš‘ wPšÍvi wKQy †bB| Avwg †Zvgv‡K G¸‡Z w`‡ev hw` Zzwg †g‡q‡`i cÖRbb Z‡š¿i wewfbœ Ask¸‡jv Avi GKevi †`‡L bvI hv †Zvgv‡K GB Ask¸‡jv g‡b ivL‡Z mvnvh¨ Ki‡e|'];
				addChild(pointMissed);
				pointMissed.animPointEarned();
				pointMissed.addEventListener(LevelEvents.LEVEL_NEXT, prepareExit);
			}
		}
		
		private function prepareExit(e:LevelEvents):void{
			mainSkin.areaInteractive.visible = false;
			
			var blackShutter:FL_BlackFadeOut = new FL_BlackFadeOut();
			addChild(blackShutter);
			
			AfterPlayClip.callBack(blackShutter, waitForexit);
		}
		
		private function waitForexit():void{
			DelayCall.call(exit, .5);
		}
		
		private function exit():void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}