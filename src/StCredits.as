package
{
	import org.flixel.*;
	
	public class StCredits extends ZState
	{
		private const ESCAPE_KEY:Array = ["ESCAPE"];
		
		override public function create():void {
			FlxG.bgColor = 0xff666666;
			super.create();
		}
		
		override public function createObjects():void {
			add(new FlxText(Glob.CENT.x,Glob.CENT.y,100,"Credits State Alpha"));
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(ESCAPE_KEY)) {
				goBack();
			}
		}
	}
}