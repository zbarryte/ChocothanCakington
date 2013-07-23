package
{
	import org.flixel.*;
	
	public class Present extends FlxSprite
	{
		public function Present(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.presentSheet,true,true,32,32,true);
			addAnimation("rock",[0,0,0,1,2,3,3,3,3,3,3,2,1,0,0,0],10,true);
			play("rock");
		}
	}
}