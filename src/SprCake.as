package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class SprCake extends ZNode
	{
		private var blinkTimer:Number = 0;
		private var blinkPeriod:Number = 2.2;
		
		private const W:Number = 48;
		private const H:Number = 8;
		
		private const MOVE_DECEL:Number = 444;
		private const MOVE_ACCEL_X:Number = 444;
		private const MOVE_VEL_Y:Number = Math.pow(Glob.GRAV_ACCEL*10*32,0.5);
		private const MAX_VEL_X:Number = 222;
		private const MAX_VEL_Y:Number = 888;
		
		private const KEY_RIGHT:Array = ["RIGHT"];
		private const KEY_LEFT:Array = ["LEFT"];
		private const KEY_JUMP:Array = ["SPACE"];
		
		private var state:String;
		
		private static const IDLE:String = "IDLE";
		private static const MOVE_LEFT:String = "MOVE_LEFT";
		private static const MOVE_RIGHT:String = "MOVE_RIGHT";
		private static const JUMP:String = "JUMP";
		private static const FALL:String = "FALL";
		private static const BALLOON:String = "BALLOON";
		
		public var balloon:FlxSprite;
		private var stringLength:Number = 32;
		private var balloonString:FlxSprite;
		
		private var wasUsingBalloon:Boolean;
		
		//private var eyes:FlxSprite;
		private var eyes:ZComponent;
		private var feet:ZComponent;
		
		public var components:FlxGroup;
										
		public function SprCake(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{	
			components = new FlxGroup;
			
			feet = new ZComponent(this,8,H,Glob.cakeFeetSheet,0,32,16);
			feet.addAnimation("walk",[0,1,2,1,3,4,5],22,false);
			feet.addAnimation("idle",[0]);
			components.add(feet);
			
			super(_x,_y);
			loadGraphic(Glob.cakeBaseSheet,true,true,W,H,true);
			
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
			var head:ZComponent = new ZComponent(this,3,-16,Glob.cakeHeadSheet,0,42,16);
			components.add(head);
			
			eyes = new ZComponent(head,0,0,Glob.cakeEyesSheet,0,42,16);
			eyes.addAnimation("blink",[1,2,3,4,0,4,3,2,1],22,false);
			eyes.frame = 1;
			//eyes.play("blink");
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
		
		public function moveLeft():void {
			acceleration.x = -MOVE_ACCEL_X;
		}
		
		public function moveRight():void {
			acceleration.x = MOVE_ACCEL_X;
		}
		
		public function jump():void {
			if (onGround()) {
				velocity.y = -MOVE_VEL_Y;
			}
		}
		
		public function fall():void {
			if (velocity.y < 0 && !wasUsingBalloon) {
				velocity.y = 0;
			}
		}
		
		override public function update():void {
			
			//super.update();
			
			/*
			if (velocity.x != 0 && onGround()) {
				feet.play("walk");
			} else {
				feet.play("idle");
			}*/
			
			// blink?
			blinkTimer += FlxG.elapsed;
			if (blinkTimer >= blinkPeriod) {
				eyes.play("blink");
				blinkTimer = 0;
			}
			
			
			// reset acceleration
			//acceleration = new FlxPoint(0,Glob.GRAV_ACCEL);
			balloon.acceleration = new FlxPoint(0,0);
			
			super.update();
			
			/*
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
				//FlxG.log(_theta);
				
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
		
		/*
		override public function overlaps(ObjectOrGroup:FlxBasic, InScreenSpace:Boolean=false, Camera:FlxCamera=null):Boolean {
			for (var i:uint = 0; i < components.length; i++) {
				if (components.members[i].overlaps(ObjectOrGroup,InScreenSpace,Camera)) {
					return true;
				}
			}
			
			return (super.overlaps(ObjectOrGroup,InScreenSpace,Camera));
		}
		*/
		
		
		
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