package
{
	import org.flixel.*;
	
	public class TitleState extends FlxState
	{	
		override public function create():void {
			
			Glob.titleMusic.play();
			
			add(new FlxSprite(0,0,Glob.titleSheet));
			
			add(new FlxText(3*FlxG.width/4.0,3*FlxG.height/4.0,100,"press any key"));
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.any()) {
				Glob.titleMusic.stop();
				FlxG.switchState(new MenuState());
			}
		}
	}
}