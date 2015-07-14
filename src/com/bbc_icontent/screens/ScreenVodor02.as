package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ScreenVodor02 extends Screen
	{
		
		
		private var mainSkin:FL_ScreenVodor2;
		
		private var matchedTotal:int;
		private var matchedGoal:int;
		
		
		
		private var dataArr:Array=new Array();
		private var separetor:String = "/";
		
		private var speech1:MovieClip, speech2:MovieClip;
		
		
		public function ScreenVodor02()
		{
			super();
			scoreMax=4;
			
			var background:Bitmap = Assets.getBackground(Assets.IMG_forestSnake2);
			addChild(background);
			
			var guideImage:Bitmap = Assets.getBackground(Assets.IMG_jigFR);
			guideImage.x = 440;
			guideImage.y = 160;
			addChild(guideImage);
			
			mainSkin = new FL_ScreenVodor2();
			addChild(mainSkin);
			
			speech1 = mainSkin.SpeechDeer01;
			speech2 = mainSkin.SpeechDeer02;
		}
		
		
		private function populateData():void
		{
			speech1.txt.text="gvwm‡Ki mgq †Kv‡bv mgm¨v n‡j Kweiv‡Ri Kv‡Q †h‡Z n‡e|";
			speech2.txt.text="gvwm‡Ki mgq †Kv‡bv mgm¨v n‡j Wv³v‡ii Kv‡Q †h‡Z n‡e|";
			speech1.addEventListener(MouseEvent.CLICK, onSpeechClocked);
			speech2.addEventListener(MouseEvent.CLICK, onSpeechClocked);
		}
		
		protected function onSpeechClocked(e:MouseEvent):void
		{
			var targetSpeech:MovieClip = e.currentTarget as MovieClip;
			
			if(targetSpeech==speech1){
				trace("Inccorect");
			}else if(targetSpeech==speech2){
				trace("Correct"+speech2.txt.text);
			} 
		}		
		
		
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			populateData();
			
			
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