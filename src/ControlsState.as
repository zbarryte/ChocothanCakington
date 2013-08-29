package
{
	import org.flixel.*;
	
	public class ControlsState extends ZState
	{
		private const ESCAPE_KEY:Array = ["ESCAPE"];
		
		override public function createObjects():void {
			add(new FlxText(Glob.CENT.x,Glob.CENT.y,100,"Controls State Alpha"));
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(ESCAPE_KEY)) {
				goBack();
			}
		}
	}
}