package
{
	import org.flixel.*;
	
	public class BtnMenu extends ZButton
	{
		protected const SIZE_CURSE:uint = 22;
		protected const SIZE_UNCURSE:uint = 17;
		protected const COLOR_CURSE:Number = 0xffffff;
		protected const COLOR_UNCURSE:Number = 0xbbbbbb;
		protected const ALIGNMENT:String = "center";
		
		public var text:FlxText;
		
		public function BtnMenu(_callback:Function=null,_label:String=null)
		{
			super(_callback);
			// add a text Label
			text = new FlxText(0,0,ZButton.W,_label);
			text.alignment = ALIGNMENT;
			add(text);
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