package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.mcc.interactives.utils.DelayCall;
	import com.mcc.objects.TigerDragable;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	
	public class ScreenTiger03 extends Screen
	{
		private var mainSkin:FL_ScreenTiger03;
		
	
		
		private var container01:Sprite, container02:Sprite, container03:Sprite, container04:Sprite, container05:Sprite;
		private var dragable1:TigerDragable, dragable2:TigerDragable, dragable3:TigerDragable;
		
		private var dragables:Vector.<TigerDragable>, containers:Vector.<Sprite>;
		
		
		
		
		TweenPlugin.activate([GlowFilterPlugin]);
		
		public function ScreenTiger03()
		{
			super();
			
			mainSkin = new FL_ScreenTiger03();
			addChild(mainSkin);
						
		
			
			container01 = mainSkin.c01;			
			container02 = mainSkin.c02;
			container03 = mainSkin.c03;
			container04 = mainSkin.c04;
			container05 = mainSkin.c05;
			containers = new Vector.<Sprite>();
			containers.push(container01,container02, container03, container04, container05);
			
			dragable1 =mainSkin.d01;
			dragable1.txt.text="†g‡qiv eqtmwÜ‡Z c`vc©Y Kivi ci †_‡K cÖwZ gv‡m Zv‡`i wW¤^vkq †_‡K wW¤^vby †ei n‡q d¨v‡jvwcqvb wUD‡ei ga¨ w`‡q Rivqy‡Z †cŠuQvq| Gmgq Rivqyi wSwj­ (Pvicv‡ki AveiY) AviI cyi“ nq Ges i³ I Ab¨vb¨ Dcv`v‡b f‡i D‡V|";
			dragable2 =mainSkin.d02;
			dragable2.txt.text="Gmgq kvixwiK wgj‡bi d‡j †Kv‡bv ïµvby wW¤^vby‡K wbwl³ Ki‡j †mB wbwl³ wW¤^vbywU Rivqyi Av¯—i‡Y ¯’vb K‡i †bq Ges ax‡i ax‡i ev”Pvq cwiYZ nq|";  
			dragable3 =mainSkin.d03;
			dragable3.txt.text="Avi hw` wW¤^vYy wbwl³ bv nq Zvn‡j †fZ‡ii i‡³i Av¯—iYwU wW¤^vbymn gvwm‡Ki mgq †hvwbc_ w`‡q †ewi‡q Avm‡e|";
			dragables=new Vector.<TigerDragable>();
			
			dragables.push(dragable1, dragable2, dragable3);
			
			
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
		
			DelayCall.call(prepareInteractive, 0);
		}
		
		
		
		private function prepareInteractive():void{
			
			startInteractive();
		}
		
		private function startInteractive():void{
			
			for(var i:int; i<dragables.length; i++){
				dragables[i].addEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
			}
			
			
		}
		
		private var currentMoving:TigerDragable;
		private var startPoint:Point;
		private function dragEnable(e:MouseEvent):void{
			currentMoving = e.currentTarget as TigerDragable;
			trace("currentMoving: "+currentMoving.name);
			//homePoint.x=currentMoving.x;
			//homePoint.y=currentMoving.y;
			
			startPoint=new Point(currentMoving.x, currentMoving.y);
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
			
			if(currentTarget!=null && currentTarget.name.substr(1,2)==currentMoving.name.substr(1,2) ){
				
				currentMoving.removeEventListener(MouseEvent.MOUSE_DOWN, dragEnable);
				
				
				TweenLite.to(currentMoving, .2, {x:currentTarget.x, y:currentTarget.y, onComplete:onCompleteMatch });
				
			}else{
				TweenLite.to(currentMoving, 1, {x:startPoint.x, y:startPoint.y, onComplete:onCompleteTween });
					
			}
			
			
		}
		
		private function onCompleteMatch():void{
			TweenLite.to(currentMoving, .2, {scaleX:.5, scaleY:.5, onComplete:onCompleteScaleDown });
		}
		
		private function onCompleteScaleDown():void{
			TweenLite.to(currentMoving, .3, {scaleX:1, scaleY:1 });
			
		}
		
		private function onCompleteTween():void{
			trace("complete tween");
			
			
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			
			checkResult();
		}
		
		private function checkResult():void{
			
			
			/*if(container03.x > container02.x  && container02.x > container01.x){
				trace("glowing...................");
				
				var myTimeline:TimelineMax = new TimelineMax({onComplete:completeTimeLine});
				myTimeline.add([new TweenLite(container01, .25, {glowFilter:{color:0x009900, blurX:50, blurY:50, strength:50, alpha:1, remove:true}}),
								new TweenLite(container02, .25, {glowFilter:{color:0x009900, blurX:50, blurY:50, strength:50, alpha:1, remove:true}}),
								new TweenLite(container03, .25, {glowFilter:{color:0x009900, blurX:50, blurY:50, strength:50, alpha:1, remove:true}}),],
					0,
					"start",
					0.2);
			}*/
					
			
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