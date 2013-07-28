package
{
	import org.flixel.*;
	
	public class PauseGroup extends ZGroup
	{	
		private const PAUSE_KEY:Array = ["ENTER"];
		
		public function PauseGroup(MaxSize:uint=0)
		{
			super(MaxSize);
			
			toggle();
			
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y-ZButton.H-ZGroup.SPACING,Glob.buttonSheet,continueReaction,"continue",ZButton.CURSED));
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y,Glob.buttonSheet,restartReaction,"restart"));
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y+ZButton.H+ZGroup.SPACING,Glob.buttonSheet,exitToMenuReaction,"exit to menu"));
		}
		
		// Button Reactions
		private function continueReaction():void {
			toggle();
		}
		private function restartReaction():void {
			FlxG.switchState(new PlayState());
		}
		private function exitToMenuReaction():void {
			FlxG.switchState(new MapState());
		}
		
		public function isOn():Boolean {
			return visible;
		}
		
		public function toggle():void {
			visible = !visible;
		}
		
		override public function reset():void {
			super.reset();
			toggle();
		}
		
		override public function update():void {
			if (isOn()) {
				super.update();
			}
			if (Glob.justPressed(PAUSE_KEY)) {
				reset();
			}
		}
	}
}