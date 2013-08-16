package
{
	import org.flixel.*;
	
	public class CreditsState extends ZState
	{
		private const ESCAPE_KEY:Array = ["ESCAPE"];
		
		override public function create():void {
			add(new FlxText(Glob.CENT.x,Glob.CENT.y,100,"Credits State Alpha"));
		}
		
		override protected function detectControls():void {
			if (Glob.justPressed(ESCAPE_KEY)) {
				goBack();
			}
		}
	}
}