package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class Cake extends FlxSprite
	{
		private const W:Number = 32;
		private const H:Number = 32;
		
		private const MOVE_DECEL:Number = 444;
		private const MOVE_ACCEL_X:Number = 444;
		private const MOVE_VEL_Y:Number = Math.pow(Glob.GRAV_ACCEL*10*32,0.5);
		private const MAX_VEL_X:Number = 222;
		private const MAX_VEL_Y:Number = 888;
		
		private const KEY_RIGHT:Array = ["RIGHT"];
		private const KEY_LEFT:Array = ["LEFT"];
		private const KEY_JUMP:Array = ["SPACE"];
		
		public var balloon:FlxSprite;
		private var stringLength:Number = 32;
		private var balloonString:FlxSprite;
		
		private var wasUsingBalloon:Boolean;
		
		//private var eyes:FlxSprite;
		private var eyes:ZComponent;
		
		public var components:FlxGroup;
										
		public function Cake(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.cakeSheet,true,true,W,H,true);
			
			components = new FlxGroup;
			
			acceleration.y = Glob.GRAV_ACCEL;
			drag.x = MOVE_DECEL;
			maxVelocity.x = MAX_VEL_X;
			maxVelocity.y = MAX_VEL_Y;
			
			/*eyes = new FlxSprite(x,y);
			eyes.loadGraphic(Glob.cakeEyesSheet,true,true,width,height,true);
			eyes.addAnimation("blink",[0,1],2,true);
			//eyes.play("blink");
			eyes.frame = 1;
			components.add(eyes);
			*/
			eyes = new ZComponent(this,32,0,Glob.cakeEyesSheet);
			components.add(eyes);
			
			balloon = new FlxSprite(x,y);
			balloon.loadGraphic(Glob.balloonSheet,true,true,32,32,true);
			balloon.acceleration.y = Glob.GRAV_ACCEL/222.222;
			balloon.maxVelocity.x = MAX_VEL_X/2.2;
			balloon.maxVelocity.y = MAX_VEL_Y/22.22;
			balloon.visible = false;
			balloon.drag = drag;
			
			balloonString = new FlxSprite(x,y,Glob.balloonStringSheet);
			//components.add(balloonString);
			balloonString.visible = false;
		}
		
		override public function update():void {
			
			super.update();
			
			if (FlxG.keys.pressed("M")) {
				angle += 1;
			} else if (FlxG.keys.pressed("N")) {
				angle -= 1;
			}
			
			// reset acceleration
			acceleration = new FlxPoint(0,Glob.GRAV_ACCEL);
			balloon.acceleration = new FlxPoint(0,0);
			
			// handle left/right motion
			if (Glob.pressedAfter(KEY_LEFT,KEY_RIGHT)) {
				acceleration.x = -MOVE_ACCEL_X;
			} else if (Glob.pressedAfter(KEY_RIGHT,KEY_LEFT)) {
				acceleration.x = MOVE_ACCEL_X;
			}
			// handle jumping
			if (Glob.justPressed(KEY_JUMP) && onGround()) {
				velocity.y = -MOVE_VEL_Y;
			} else if (Glob.justReleased(KEY_JUMP) && velocity.y < 0 && !wasUsingBalloon) {
				velocity.y = 0;
			}
			/*// center some components
			eyes.x = x;
			eyes.y = y;
			*/
			// Handle Balloon Use
			if (justUsedBalloon()) {
				balloon.x = x;
				balloon.y = y - balloon.height/2.0 - stringLength;
				balloon.velocity.x = velocity.x;
				balloon.visible = true;
				balloonString.visible = true;
				wasUsingBalloon = true;
				balloon.acceleration.y = Glob.GRAV_ACCEL/22.22;
			} else if (usingBalloon()) {
									
				var _balloonTiePoint:FlxPoint = new FlxPoint(balloon.x+width/2.0,balloon.y+balloon.height/2.0);
				var _cakeTiePoint:FlxPoint = new FlxPoint(x+width/2.0,y);
				var _distToBalloon:Number = Math.pow(Math.pow(_balloonTiePoint.x-_cakeTiePoint.x,2) + Math.pow(_balloonTiePoint.y-_cakeTiePoint.y,2),0.5);
				var _dirToBalloon:FlxPoint = new FlxPoint((_balloonTiePoint.x-_cakeTiePoint.x)/_distToBalloon,(_balloonTiePoint.y-_cakeTiePoint.y)/_distToBalloon);
				
				var _theta:Number = -Math.atan(_dirToBalloon.x/_dirToBalloon.y)*180.0/Math.PI;
				balloon.angle = _theta;
				FlxG.log(_theta);
				
				acceleration.x -= Math.abs(_distToBalloon - stringLength)*0.5*Glob.GRAV_ACCEL*Math.sin(_theta);// + (_distToBalloon - stringLength)*_dirToBalloon.x*Glob.GRAV_ACCEL;
				acceleration.y -= Math.abs(_distToBalloon - stringLength)*Glob.GRAV_ACCEL*Math.pow(Math.sin(_theta),2.0);// + (_distToBalloon - stringLength)*_dirToBalloon.y*Glob.GRAV_ACCEL;
				
				//if (_distToBalloon >= stringLength) {
					/*
					acceleration.x = 0.5*Glob.GRAV_ACCEL*Math.sin(_theta);
					acceleration.y = Glob.GRAV_ACCEL*Math.pow(Math.sin(_theta),2.0);
					*/
					
					/*
					acceleration.x += 0.22*(_distToBalloon - stringLength)*_dirToBalloon.x*Glob.GRAV_ACCEL;
					acceleration.y += 0.22*(_distToBalloon - stringLength)*_dirToBalloon.y*Glob.GRAV_ACCEL;
					//velocity.y = (velocity.y > -maxVelocity.y/8) ? velocity.y : -maxVelocity.y/8;
					
					balloon.acceleration.x -= 0.022*(_distToBalloon - stringLength)*_dirToBalloon.x*Glob.GRAV_ACCEL;
					balloon.acceleration.y -= 0.022*(_distToBalloon - stringLength)*_dirToBalloon.y*Glob.GRAV_ACCEL;
					//balloon.velocity.y = (balloon.velocity.y < maxVelocity.y/22) ? balloon.velocity.y : maxVelocity.y/22;
					*/
					
				//}
			} else if (justStoppedUsingBalloon()) {
				balloon.velocity = new FlxPoint(0,0);
				balloon.visible = false;
				balloonString.visible = false;
				wasUsingBalloon = false;
				balloon.acceleration.y = 0;
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
			return (!onGround() && Glob.pressed(KEY_JUMP) && (velocity.y > 0 || balloon.velocity.y > 0));
		}
		private function justUsedBalloon():Boolean {
			return usingBalloon() && !wasUsingBalloon;
		}
		private function justStoppedUsingBalloon():Boolean {
			return !usingBalloon() && wasUsingBalloon;
		}
	}
}