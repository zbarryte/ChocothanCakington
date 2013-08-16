package
{
	import org.flixel.*;
	
	public class ZTextButton extends ZButton
	{
		private var text:FlxText;
		
		private var pulseTimer:Number = 0;
		private const PULSE_PERIOD:Number = 0.33;
		private var pulseDir:int = 1;
		
		public function ZTextButton(_callback:Function=null,_label:String=null,_state:String=ZButton.UNCURSED, _maxSize:uint=0)
		{
			super(_callback,_state,_maxSize);
			
			// create and align text to add to the button
			text = new FlxText(0,0,ZButton.W,_label);
			text.alignment = "center";
			
			// add the text to the button
			add(text);
		}
		
		override public function curse():void {
			text.size = 22;
			text.color = 0xffffff;
			pulseTimer = 0;
			pulseDir = 1;
			super.curse();
		}
		override public function uncurse():void {
			text.size = 17;
			text.color = 0xbbbbbb;
			super.uncurse();
		}
		
		override public function update():void {
			if (stateIs(ZButton.CURSED)) {
				pulseTimer += FlxG.elapsed;
				text.size += pulseDir;
				if (pulseTimer >= PULSE_PERIOD) {
					pulseTimer = 0;
					pulseDir *= -1;
				}
			}
		}
	}
}