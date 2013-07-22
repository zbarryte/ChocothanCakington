package
{
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	
	public class ChocothanCakington extends FlxGame
	{
		public function ChocothanCakington()
		{
			super(640,480,PlayState,1,60,60,true);
			
			forceDebugger = Glob.DEBUG_ON;
		}
	}
}