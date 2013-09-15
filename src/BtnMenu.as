package
{
	import org.flixel.*;
	
	public class BtnMenu extends ZButton
	{
		private const SIZE_CURSE:uint = 22;
		private const SIZE_UNCURSE:uint = 17;
		private const COLOR_CURSE:Number = 0xffffff;
		private const COLOR_UNCURSE:Number = 0xbbbbbb;
		private const ALIGNMENT:String = "center";
		
		private var text:FlxText;
		
		public function BtnMenu(_callback:Function,_label:String)
		{
			super(_callback);
			// add a text Label
			text = new FlxText(0,0,ZButton.W,_label);
			text.alignment = ALIGNMENT;
			add(text);
			
			width = ZButton.W;
		}
		
		override public function curse():void {
			text.size = SIZE_CURSE;
			text.color = COLOR_CURSE;
			super.curse();
		}
		override public function uncurse():void {
			text.size = SIZE_UNCURSE;
			text.color = COLOR_UNCURSE;
			super.uncurse();
		}
		
		override public function pulse(dir:int):void {
			text.size += dir;
		}
		
		override public function resetPulse():void {
			text.size = 17;
		}
	}
}