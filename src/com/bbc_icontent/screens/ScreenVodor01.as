package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.custom_elements.Connector;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public class ScreenVodor01 extends Screen
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
		
		private var mainSkin:FL_ScreenVodor;
		
		private var matchedTotal:int;
		private var matchedGoal:int;
		
		private var cl1:Sprite,cl2:Sprite, cl3:Sprite, cl4:Sprite,
		cr1:Sprite, cr2:Sprite, cr3:Sprite,  cr4:Sprite;
		
		
		
		private var matchables:Vector.<Sprite > ;
		private var matchDone:Vector.<Sprite > ;
		private var matchablesLeft:Vector.<Sprite > ;
		private var matchablesRight:Vector.<Sprite> ;
		
		private var line:Connector;
		private var lines:Vector.<Connector > ;
		
		private var startPoint:Point,endPoint:Point;
		private var startClip:Sprite,endClip:Sprite;
		
		private var dataArr:Array=new Array();
		private var separetor:String = "/";
		
		
		public function ScreenVodor01()
		{
			super();
			scoreMax=4;
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_forestSnake2);
			addChild(background);
			
			var guideImage:Bitmap = Assets.getBackground(Assets.IMG_jigFR);
			guideImage.x = 440;
			guideImage.y = 160;
			addChild(guideImage);
			
			mainSkin = new FL_ScreenVodor();
			addChild(mainSkin);
			mainSkin.SpeechDeer01.mouseChildren=false;
			mainSkin.SpeechDeer01.mouseEnabled=false;
			
			
		
			
			
			
			//==========
			//top  side
			cl1 = mainSkin.imgContainer01;
			cl2 = mainSkin.imgContainer02;
			cl3 = mainSkin.imgContainer03;
			cl4 = mainSkin.imgContainer04;
			
			
			matchablesLeft=new Vector.<Sprite>();
			matchablesLeft.push(cl1, cl2, cl3, cl4 );
			
			//down side;
			cr1 = mainSkin.dwnContainer01;
			cr2 = mainSkin.dwnContainer02;
			cr3 = mainSkin.dwnContainer03;
			cr4 = mainSkin.dwnContainer04;
			
			
			matchablesRight=new Vector.<Sprite>();
			matchablesRight.push(cr1, cr2, cr3, cr4);
			
			//data array;
			dataArr.push("cl1"+separetor+"cr1",
				"cl2"+separetor+"cr2", 
				"cl3"+separetor+"cr3",
				"cl4"+separetor+"cr4");
			
			
			matchables=new Vector.<Sprite>();
			matchables = matchablesLeft.concat(matchablesRight);
			trace("matchable length======================================="+matchables.length);
			//hide all matching parts
			showHideMatching(matchables, true);
			
			matchDone=new Vector.<Sprite>();
			
			
			
			
			
			//prepareMatching(dataArr, matchablesLeft, matchablesRight );
			
			lines=new Vector.<Connector>();
			
			
			
			
		}
		
		private function addMatchingListener():void
		{
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		private function removeMatchingListener():void
		{
			
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		private var activeDrawLine:Boolean;
		private function mouseDownHandler(event:MouseEvent):void
		{
			trace("down");
			
			for (var i:int=0; i<matchables.length; i++)
			{
				var target:Sprite = matchables[i] as Sprite;
				trace(mouseX+"<>"+mouseY);
				
				if (target!=null && target.hitTestPoint(mouseX,mouseY,true))
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
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,movement);
			
			var isReleasedonTarget:Boolean;
			///
			for (var i:int=0; i<matchables.length; i++)
			{
				trace("for "+ i);
				
				var target:Sprite = matchables[i] as Sprite;
				trace("target===: "+target+ target.name +"<>"+startClip.name );
				
				trace(line!=null );
				if (line!=null && target!=null && startClip!=null )
				{
					if(  target != startClip  && target.hitTestPoint(this.mouseX, this.mouseY,true) ){
						
						trace("if "+i);
						endPoint = new Point(matchables[i].x,matchables[i].y);
						
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
						
						
						
						isReleasedonTarget = true;
						line = null;
						
						if (lines.length == dataArr.length)
						{
							resultCheck();
						}
						
						break;
						
					}
					
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
		
		
		private function resultCheck():void
		{
			
			var totalMatchFound:int = 0;
			for (var j:int=0; j<lines.length; j++)
			{
				var cntr:Connector = lines[j] as Connector;
				var retivedSentace:String = cntr.startClip.name + separetor + cntr.endClip.name;
				
				if(cntr.startClip.name.substr(3) == cntr.endClip.name.substr(3)){
					totalMatchFound++;
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
			
			trace("total match found: "+totalMatchFound)
		}
		
		
		private function movement(event:MouseEvent):void
		{
			trace("Move");
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
			
			var colorArray:Array = new Array(0xFF50FF,0x79DCF4,0xFF3333,0xFFCC33,0x99CC33);
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