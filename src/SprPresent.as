package
{
	import org.flixel.*;
	
	public class SprPresent extends FlxSprite
	{
		private const ANGLE_MIN:Number = -44;
		private const ANGLE_MAX:Number = 44;
		private var angleDir:int = 1;
		
		public var captured:Boolean;
		
		public function SprPresent(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.presentSheet,true,true,32,32,true);
			addAnimation("bounce",[0,1,2,3,2,1,0],10,false);
			finished = true;
			captured = false;
		}
		
		override public function update():void {
			super.update();
			if (!captured) {
			if (finished) {
				angle += angleDir*1.5;
				if (angle <= ANGLE_MIN || angle >= ANGLE_MAX) {
					play("bounce");
					angleDir *= -1;
				}
			}
			scale.y = (22.0-frame)/22.0;
			scale.x = (44.0-frame)/44.0;
			} else {
				frame = 0;
				scale.x = 1;
				scale.y = 1;
				angle = 0;
			}
		}
			
	}
}