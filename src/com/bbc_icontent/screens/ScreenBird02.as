package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	
	public class ScreenBird02 extends Screen
	{
		private var mainSkin:FL_screenBird02;
		private var speech:Speech;
		private var buttonNext:Sprite;
		private var buttonSkip:Sprite;
		
		private var container01:Sprite;
		private var container02:Sprite;
		private var container03:Sprite;
		private var containers:Vector.<Sprite>;
		
		private var notificationTry:Sprite;
		private var notificationSuccess:Sprite;
		
		private var homePoint:Point, swapPoint:Point;
		
		
		TweenPlugin.activate([GlowFilterPlugin]);
		
		public function ScreenBird02()
		{
			super();
			
			mainSkin = new FL_screenBird02();
			addChild(mainSkin);
						
			buttonNext = mainSkin.bt_next;
			buttonNext.visible = false;
			buttonSkip = mainSkin.bt_skip;
			buttonSkip.visible = false;
			
			speech = new Speech();
			speech.x = 400;
			speech.y = 50;
			
			container01 = mainSkin.container01;
			container01.visible = false;
			container02 = mainSkin.container02;
			container02.visible = false;
			container03 = mainSkin.container03;
			container03.visible = false;
			
			containers=new Vector.<Sprite>();
			containers.push(container01, container02, container03);
			
			notificationTry = mainSkin.tryBird;
			notificationTry.visible = false;
			notificationSuccess = mainSkin.successBird;
			notificationSuccess.visible = false;
			
			homePoint=new Point();
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			DelayCall.call(showSpeech, 2);
		}
		
		private function showSpeech():void{
			buttonNext.visible = true;
			buttonNext.addEventListener(MouseEvent.CLICK, lineNext);
			buttonSkip.visible = true;
			buttonSkip.addEventListener(MouseEvent.CLICK, prepareInteractive);
			
			addChild(speech);
			speech.visible = false;
			
			speech.addEventListener(Event.COMPLETE, skipSpeech);
		}
		
		private function lineNext(e:MouseEvent):void{
			speech.visible = true;
			speech.nextLine();
		}
		
		private function skipSpeech(e:Event):void{
			prepareInteractive(null);
		}
		
		private function prepareInteractive(e:MouseEvent):void{
			speech.removeEventListener(Event.COMPLETE, skipSpeech);
			removeChild(speech);
			
			startInteractive();
		}
		
		private function startInteractive():void{
			reset();
			
			container01.visible = true;
			container02.visible = true;
			container03.visible = true;
			
			container01.addEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
			container02.addEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
			container03.addEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
			
		}
		
		private var currentMoving:Sprite;
		private function dragEnable(e:MouseEvent):void{
			currentMoving = e.currentTarget as Sprite;
			trace("currentMoving: "+currentMoving.name);
			homePoint.x=currentMoving.x;
			homePoint.y=currentMoving.y;
			
			this.addChild(currentMoving);			
			currentMoving.startDrag();
			
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(e:MouseEvent):void{
			
		}
		private function mouseUpHandler(e:MouseEvent):void{
			stopDrag();
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			
			var currentTarget:Sprite =checkCollision(currentMoving);
			
			if(currentTarget!=null){
				swapPoint=new Point(currentTarget.x, currentTarget.y);
				TweenLite.to(currentMoving, 1, {x:swapPoint.x, y:swapPoint.y, onComplete:onCompleteTween });
				TweenLite.to(currentTarget, 1, {x:homePoint.x, y:homePoint.y, onComplete:onCompleteTween });
			}else{
				TweenLite.to(currentMoving, 1, {x:homePoint.x, y:homePoint.y, onComplete:onCompleteTween });	
			}
			
			
		}
		
		private function onCompleteTween():void{
			trace("complete tween");
			
			
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			
			checkResult();
		}
		
		private function checkResult():void{
			trace(container01.x+"<>"+container02.x+"<>"+container03.x);
			
			if(container03.x > container02.x  && container02.x > container01.x){
				trace("glowing...................");
				
				var myTimeline:TimelineMax = new TimelineMax({onComplete:completeTimeLine});
				myTimeline.add([new TweenLite(container01, .25, {glowFilter:{color:0x009900, blurX:50, blurY:50, strength:50, alpha:1, remove:true}}),
								new TweenLite(container02, .25, {glowFilter:{color:0x009900, blurX:50, blurY:50, strength:50, alpha:1, remove:true}}),
								new TweenLite(container03, .25, {glowFilter:{color:0x009900, blurX:50, blurY:50, strength:50, alpha:1, remove:true}}),],
					0,
					"start",
					0.2);
			}
					
			
		}
		
		
		
		private function completeTimeLine():void{
			TweenLite.to([container01,container02,container03], .5, {glowFilter:{color:0x00FF00, blurX:75, blurY:75, strength:75, alpha:1, remove:true}});
			
			//finish call
		}
		
		
		private function checkCollision(movingObject:Sprite):Sprite{
			var mObject:Sprite = movingObject;
			var targetObject:Sprite;
			var dx:Number = 0;
			var dy:Number = 0;
			var distance:Number = 0;
			var range:Number = container01.width-10;
			
			for(var i:int = 0; i<containers.length; i++){
				targetObject = containers[i] as Sprite;
				
				
				dx = movingObject.x - targetObject.x;
				dy = movingObject.y - targetObject.y;
				
				distance = Math.sqrt(dx*dx + dy*dy);
				if(distance < range && targetObject!=null){
				//	targetObject.alpha = .2;
					
					if(movingObject!=targetObject)
					return targetObject;
				}
				else{
				//	targetObject.alpha = 1;
				}				
			}
			
			return null;
		}
		
		private function reset():void{
			container01.x = 130;
			container01.y = 386;
			
			container02.x = 510;
			container02.y = 386;
			
			container03.x = 890;
			container03.y = 386;
		}
		
	}
}

import com.mcc.interactives.utils.AfterPlayClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

class Speech extends Sprite{
	private var skin:BirdSpeech;
	private var textLine:TextField;
	private var lines:Array;
	private var indexLine:int;
	public function Speech(){
		skin = new BirdSpeech();
		addChild(skin);
		skin.stop();
		textLine = skin.txt;
		textLine.visible = false;
		
		lines = ['gvwm‡Ki mgq †g‡qiv cwi¯‹vi Kvco ev m¨vwbUvwi c¨vW e¨envi Ki‡Z cv‡i| G¸‡jv i³¯ªvve fv‡jvfv‡e ï‡l wb‡Z cv‡i|',
		'gvwm‡Ki mgq cwi¯‹vi Kvco †avqv I e¨envi Kivi c×wZ¸‡jv wb‡P †`Iqv Av‡Q| Zzwg wK G¸‡jv µgvbymv‡i mvRv‡Z cvi‡e? Zvn‡jB Zzwg GB evavwU AwZµg K‡i mvg‡b GwM‡q †h‡Z cvi‡e|'];
		
		indexLine = 0;
	}
	
	public function nextLine():void{
		if(indexLine < lines.length){
			textLine.visible = false;
			skin.gotoAndPlay(1);
			AfterPlayClip.callBack(skin, showLine);
		}
		else{
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
	}
	
	private function showLine():void{
		textLine.visible = true;
		textLine.text = ''+lines[indexLine];		
		indexLine++;
	}
}