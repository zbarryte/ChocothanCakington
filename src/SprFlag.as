package
{
	import org.flixel.FlxSprite;
	
	public class SprFlag extends FlxSprite
	{
		public function SprFlag(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y,Glob.flagSheet);
		}
	}
}