package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class Cake extends FlxSprite
	{
		private const W:Number = 32;
		private const H:Number = 32;
		
		private const MOVE_ACCEL:Number = 222;
		private const MOVE_ACCEL_X_GROUND:Number = 444;
		private const MOVE_ACCEL_X_AIR:Number = 222;
		private const MOVE_VEL_Y:Number = Math.pow(Glob.GRAV_ACCEL*10*32,0.5);
		private const MAX_VEL_X:Number = 444;
		private const MAX_VEL_Y:Number = 888;
		
		private const KEY_RIGHT:Array = ["RIGHT"];
		private const KEY_LEFT:Array = ["LEFT"];
		private const KEY_JUMP:Array = ["SPACE"];
		
		public var balloon:FlxSprite;
		private var stringLength:Number = 32;
		private var balloonString:FlxSprite;
		
		private var wasUsingBalloon:Boolean;
		
		private var eyes:FlxSprite;
		
		public var components:FlxGroup;
				
		public function Cake(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.cakeSheet,true,true,W,H,true);
			
			components = new FlxGroup;
			
			acceleration.y = Glob.GRAV_ACCEL;
			drag.x = MOVE_ACCEL;
			maxVelocity.x = MAX_VEL_X;
			//maxVelocity.y = MAX_VEL_Y;
			
			eyes = new FlxSprite(x,y);
			eyes.loadGraphic(Glob.cakeEyesSheet,true,true,width,height,true);
			eyes.addAnimation("blink",[0,1],2,true);
			//eyes.play("blink");
			eyes.frame = 1;
			components.add(eyes);
			
			balloon = new FlxSprite(x,y);
			balloon.loadGraphic(Glob.balloonSheet,true,true,32,32,true);
			balloon.acceleration.y = Glob.GRAV_ACCEL/222.222;
			//balloon.maxVelocity.x = MAX_VEL_X/22.22;
			//balloon.maxVelocity.y = MAX_VEL_Y/22.22;
			
			balloonString = new FlxSprite(x,y,Glob.balloonStringSheet);
			components.add(balloonString);
		}
		
		override public function update():void {
			
			super.update();
			
			// Right/Left motion
			if (Glob.pressedAfter(KEY_LEFT,KEY_RIGHT)) {
				acceleration.x = -MOVE_ACCEL_X_GROUND;
			} else if (Glob.pressedAfter(KEY_RIGHT,KEY_LEFT)) {
				acceleration.x = MOVE_ACCEL_X_GROUND;
			} else {
				acceleration.x = 0;
			}
			
			// Jump
			if (Glob.justPressed(KEY_JUMP) && onGround()) {
				velocity.y = -MOVE_VEL_Y;
			} else if (Glob.justReleased(KEY_JUMP) && velocity.y < 0) {
				velocity.y = 0;
			}
			
			/*
			if (FlxG.keys.pressed("LEFT")) {
				acceleration.x = (usingBalloon() && !onGround()) ? -MOVE_ACCEL_X_AIR : -MOVE_ACCEL_X_GROUND;
			} else if (FlxG.keys.pressed("RIGHT")) {
				acceleration.x = (usingBalloon() && !onGround()) ? MOVE_ACCEL_X_AIR : MOVE_ACCEL_X_GROUND;
			} else {
				acceleration.x = 0;
			}
			
			if (FlxG.keys.pressed("SPACE") && onGround()) {
				velocity.y -= MOVE_VEL_Y;
			}
			
			if (usingBalloon() && velocity.y >= 0) {
				acceleration.y = Glob.GRAV_ACCEL/22;
			} else {
				acceleration.y = Glob.GRAV_ACCEL;
			}
			*/
			
			/*
			// manual physics adjustments
			var _xPrev:Number = x;
			x = x + velocity.x*FlxG.elapsed + 0.5*(acceleration.x + drag.x)*Math.pow(FlxG.elapsed,2);
			velocity.x = (_xPrev-x)/FlxG.elapsed;
			velocity.x = (velocity.x < maxVelocity.x) ? velocity.x : maxVelocity.x;
			
			var _yPrev:Number = y;
			y = y + velocity.y*FlxG.elapsed + 0.5*(acceleration.y + drag.y)*Math.pow(FlxG.elapsed,2);
			velocity.y = (_yPrev-y)/FlxG.elapsed;
			velocity.y = (velocity.y < maxVelocity.y) ? velocity.y : maxVelocity.y;
			*/
			
			for (var i:uint = 0; i < components.length; i++) {
				components.members[i].x = x;
				components.members[i].y = y;
			}
			
			// Balloon stuff (maybe should model like a mass-spring system?  kind of cheating it for now)
			if (usingBalloon()) {
				var _connectPoint:FlxPoint = new FlxPoint(x+width/2.0,y);
				if (justUsedBalloon()) {
					balloon.x = _connectPoint.x-balloon.width/2.0;
					balloon.y = _connectPoint.y-stringLength-balloon.height;
					balloon.velocity.x = 0;
					balloon.velocity.y = 0;
					wasUsingBalloon = true;
				}
				
				var _balloonBasePoint:FlxPoint = new FlxPoint(balloon.x+width/2.0,balloon.y+balloon.height);
				balloonString.x = _balloonBasePoint.x;
				balloonString.y = _balloonBasePoint.y;
				
				var _dirMag:Number = Math.pow(Math.pow(_balloonBasePoint.x-_connectPoint.x,2) + Math.pow(_balloonBasePoint.y-_connectPoint.y,2),0.5);
				var _dir:FlxPoint = new FlxPoint(-(_balloonBasePoint.x-_connectPoint.x)/_dirMag,-(_balloonBasePoint.y-_connectPoint.y)/_dirMag);
				
				balloon.visible = true;
				balloonString.visible = true;
				acceleration.y = Glob.GRAV_ACCEL - 880*_dir.y;
				acceleration.x -= 880*_dir.x;
				
				// is the cake still attached?
				if (Math.pow(_connectPoint.x+_balloonBasePoint.x,2) + Math.pow(_connectPoint.y+_balloonBasePoint.y,2) > Math.pow(stringLength,2)) {
					x = _balloonBasePoint.x+_dir.x*stringLength-width/2.0;
					y = _balloonBasePoint.y+_dir.y*stringLength;
				}
				
				//balloon.acceleration.y = Glob.GRAV_ACCEL/222.222 + 880*_dir.y;
				//balloon.acceleration.x = 0 + 880*_dir.x;
			} else {
				balloon.visible = false;
				balloonString.visible = false;
				wasUsingBalloon = false;
				acceleration.y = Glob.GRAV_ACCEL;
				balloon.acceleration.y = Glob.GRAV_ACCEL/222.222;
				balloon.acceleration.x = 0;
			}
		}
		
		override protected function updateMotion():void {
			// in case I'd like to mess with this to add tension, it's defined in FlxObject
			super.updateMotion();
		}
		
		private function onGround():Boolean {
			return isTouching(FlxObject.DOWN);
		}
		
		private function usingBalloon():Boolean {
			return Glob.pressed(KEY_JUMP) && velocity.y > 0;
		}
		private function justUsedBalloon():Boolean {
			return usingBalloon() && !wasUsingBalloon;
		}
	}
}