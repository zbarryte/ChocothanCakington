package
{
	import org.flixel.*;
	
	public class MapState extends ZState
	{
		private const BACK_KEY:Array = ["ESCAPE"];
		private const FORWARD_KEY:Array = ["ENTER","SPACE"];
		
		override public function create():void {
			add(new FlxText(FlxG.width/2.0,FlxG.height/2.0,100,"Map State, continue with SPACE or ENTER"));
		}
		
		override public function update():void {
			super.update();
			if (Glob.justPressed(BACK_KEY)) {
				FlxG.switchState(new MenuState());
			}
			if (Glob.justPressed(FORWARD_KEY)) {
				FlxG.switchState(new PlayState());
			}
		}
	}
}