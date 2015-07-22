package com.mcc.objects {
	
	
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	public class TigerDragable extends Sprite {
		
		public var infoBtn:Sprite;
		public var txt:TextField ;
		
		public function TigerDragable() {
			// constructor code
			
			
			infoBtn=getChildByName("info") as Sprite;
			
			
			
			txt = getChildByName("txt") as TextField;//new TextField();
			txt.background = true;
			txt.border = false;
			txt.width = 300;
			txt.height = 37;
			txt.x = 0;
			txt.y = 0;
			txt.selectable = false;
			txt.visible=false;
			
			/*var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.color = 0x000000;
			format.size = 15;
			
			txt.defaultTextFormat = format;*/
			
			/*txt.addEventListener(FocusEvent.FOCUS_IN, handleFocusIn);
			txt.addEventListener(FocusEvent.FOCUS_OUT, handleFocusout);*/
			
			
			
			
			//txt.text = "If the dimensions of the TextField are not enough to house the extra text you may also want to use:";

			infoBtn.addEventListener(MouseEvent.CLICK, onInfoClicked);
			txt.addEventListener(MouseEvent.CLICK, onInfoClicked);
			this.addEventListener(MouseEvent.CLICK, onThisClicked);
		}
		
		protected function onThisClicked(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//
		}		
	
		
		protected function onInfoClicked(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if (txt.wordWrap)
			{
				txt.visible=false;
				//removeChild(txt);
				txt.wordWrap = false;
				txt.multiline = false;
				txt.autoSize = TextFieldAutoSize.NONE;
				//txt.width = 195;
				//txt.height = 37;
			}
			else
			{
				//addChild(txt);
				txt.visible=true;
				txt.wordWrap = true;
				txt.multiline = true;				
				txt.autoSize = TextFieldAutoSize.LEFT;
			}
			
			
		}
		
		
		protected function handleFocusIn(event:FocusEvent):void
		{
			// TODO Auto-generated method stub
			
			//removeChild(txt);
			
		}
		
		protected function handleFocusout(event:FocusEvent):void
		{
			// TODO Auto-generated method stub
			removeChild(txt);
		}
		
		
	}
	
}
