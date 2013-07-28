package
{
	import org.flixel.*;
	
	public class TitleState extends FlxState
	{
		override public function create():void {
			add(new FlxText(FlxG.width/2.0,FlxG.height/2.0,100,"Title State \n press any key"));
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.any()) {
				FlxG.switchState(new MenuState());
			}
		}
	}
}