package
{
	import org.flixel.*;
	
	public class Cake extends FlxSprite
	{
		private const MOVE_ACCEL:Number = 1111;
		private const MOVE_VEL_X:Number = 444;
		private const MOVE_VEL_Y:Number = 666;
		private const MAX_VEL:Number = 444;
		
		public function Cake(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.cakeSheet,true,true,32,32,true);
			
			acceleration.y = Glob.GRAV_ACCEL;
			drag.x = MOVE_ACCEL;
		}
		
		override public function update():void {
			super.update();
			
			if (FlxG.keys.pressed("LEFT")) {
				velocity.x = -MOVE_VEL_X;
			} else if (FlxG.keys.pressed("RIGHT")) {
				velocity.x = MOVE_VEL_X;
			}
			
			if (FlxG.keys.pressed("SPACE") && onGround()) {
				velocity.y = -MOVE_VEL_Y;
			}
		}
		
		private function onGround():Boolean {
			return isTouching(FlxObject.DOWN);
		}
	}
}