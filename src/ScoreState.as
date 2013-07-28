package
{
	import org.flixel.*;
	
	public class ScoreState extends FlxState
	{
		private var score:Number;
		
		public function ScoreState(_score:Number)
		{
			super();
			score = _score;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xff225522;
			add(new FlxText(0,0,100,"score = " + score));
		}
		
		override public function update():void {
			
			if (Glob.DEBUG_ON) {
				if (FlxG.keys.justPressed("SPACE")) {
					FlxG.switchState(new PlayState());
				}
			}
			
			super.update();
		}
	}
}