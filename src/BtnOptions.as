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
		public var spr:ZNode;
		public var toggleBool:Function;
		public var sprText:FlxText;
		
		public function BtnOptions(_callback:Function=null,_label:String=null,_toggleBool:Function=null)
		{	
			toggleBool = _toggleBool;
			super(_callback);
			// add a text Label
			text = new FlxText(0,0,ZButton.W,_label);
			text.alignment = ALIGNMENT;
			add(text);
			// add a sprite
			spr = new ZNode(text.width,0);
			spr.loadGraphic(Glob.btnToggleSheet,true);
			//toggleSprite();
			add(spr);
			// add text to sprite node
			sprText = new FlxText(spr.width/2.0,spr.height/2.0,spr.width,onOrOff());
			sprText.alignment = "center";
			sprText.size = 12;
			spr.add(sprText);
			toggleSprite();
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
			super.select();
			toggle();
		}
		
		override public function pulse(dir:int):void {
			text.size += dir;
		}
		
		override public function resetPulse():void {
			text.size = 17;
		}
		
		public function toggle():void {
			toggleSprite();
			
		}
		
		private function toggleSprite():void {
			//FlxG.log(toggleBool());
			spr.frame = (toggleBool()) ? 1 : 0;
			sprText.text = onOrOff();
		}
		
		private function onOrOff():String {
			return (toggleBool()) ? "On" : "Off";
		}
	}
}