package
{
	import org.flixel.*;
	
	public class StMap extends ZState
	{
		private const BACK_KEY:Array = ["ESCAPE"];
		private const FORWARD_KEY:Array = ["ENTER","SPACE"];
		
		override public function create():void {
			FlxG.bgColor = 0xff333333;
			super.create();
		}
		
		override public function createObjects():void {
			add(new FlxText(FlxG.width/2.0,FlxG.height/2.0,100,"Map State, continue with SPACE or ENTER"));
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(BACK_KEY)) {
				goBack();
			} else if (Glob.justPressed(FORWARD_KEY)) {
				goTo(StPlay);
			}
		}
	}
}