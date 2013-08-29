package
{
	import org.flixel.*;
	
	public class SprPresent extends FlxSprite
	{
		private const ANGLE_MIN:Number = -45;
		private const ANGLE_MAX:Number = 45;
		private var angleDir:int = 1;
		
		public function SprPresent(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.presentSheet,true,true,32,32,true);
			addAnimation("bounce",[0,1,2,3,2,1,0],10,false);
			finished = true;
		}
		
		override public function update():void {
			super.update();
			if (finished) {
				angle += angleDir*2;
				if (angle <= ANGLE_MIN || angle >= ANGLE_MAX) {
					play("bounce");
					angleDir *= -1;
				}
			}
		}
			
	}
}