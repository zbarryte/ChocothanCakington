package
{
	import org.flixel.FlxSprite;
	
	public class SprFlag extends FlxSprite
	{
		public function SprFlag(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.flagSheet,true,false,32,32);
			makeSad();
		}
		
		public function makeSad():void {
			frame = 0;
		}
		
		public function makeHappy():void {
			frame = 1;
		}
	}
}