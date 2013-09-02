package
{
	import org.flixel.*;
	
	public class BtnOptions extends ZButton
	{
		protected const SIZE_CURSE:uint = 22;
		protected const SIZE_UNCURSE:uint = 17;
		protected const COLOR_CURSE:Number = 0xffffff;
		protected const COLOR_UNCURSE:Number = 0xbbbbbb;
		protected const ALIGNMENT:String = "center";
		
		public var text:FlxText;
		public var spr:FlxSprite;
		
		public function BtnOptions(_callback:Function=null,_label:String=null)
		{
			super(_callback);
			// add a text Label
			text = new FlxText(0,0,ZButton.W,_label);
			text.alignment = ALIGNMENT;
			add(text);
			// add a sprite
			spr = new FlxSprite(text.width,0).loadGraphic(Glob.btnToggleSheet,true);
			toggleSprite();
			add(spr);
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
		
		override public function select():void {
			toggle();
		}
		
		override public function pulse(dir:int):void {
			text.size += dir;
		}
		
		override public function resetPulse():void {
			text.size = 17;
		}
		
		public function toggle():void {
			//Glob.soundOn = !Glob.soundOn;
			Glob.sound = !Glob.sound;
			toggleSprite();
			//Glob.sound = Glob.soundOn;
			
		}
		
		private function sprToggleFrame():uint {
			return (Glob.sound) ? 0 : 1;
		}
		
		private function toggleSprite():void {
			spr.frame = sprToggleFrame();
			FlxG.log(spr.frame);
		}
	}
}