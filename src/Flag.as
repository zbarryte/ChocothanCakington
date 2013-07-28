package
{
	import org.flixel.FlxSprite;
	
	public class Flag extends FlxSprite
	{
		public function Flag(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y,Glob.flagSheet);
		}
	}
}