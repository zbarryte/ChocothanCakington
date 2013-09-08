package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class SprCake extends ZNode
	{			
		private const kDragX:Number = 888; // drags against motion in the x dir, in pixels per second^2
		private const kMaxVelX:Number = 222; // max x velocity, in pixels per second
		private const kFastMaxVelX:Number = 444; // max x velocity if running, in pixels per second
		private const kMaxVelY:Number = 888; // max y velocity, in pixels per second
		private const kBalloonMaxVelY:Number = 111;
		private const kMoveAccelX:Number = 666; // acceleration of motion, in pixels per second^2
		private const kMoveFastAccelX:Number = 888; // acceleration of motion if running, in pixels per second^2
		private const kJumpVelY:Number = Math.pow(Glob.GRAV_ACCEL*10*32,0.5); // initial y jump velocity, in pixels per second
		
		private var isMovingLeft:Boolean;
		private var isMovingRight:Boolean;
		private var isJumping:Boolean;
		private var isFalling:Boolean;
		private var isBallooning:Boolean;
		private var isRunning:Boolean;
		/*
		private var state:String;
		
		private static const IDLE:String = "IDLE";
		private static const MOVE_LEFT:String = "MOVE_LEFT";
		private static const MOVE_RIGHT:String = "MOVE_RIGHT";
		private static const JUMP:String = "JUMP";
		private static const FALL:String = "FALL";
		private static const BALLOON:String = "BALLOON";
		
		private var balloon:FlxSprite;
		private var stringLength:Number = 32;
		private var balloonString:FlxSprite;
		
		private var wasUsingBalloon:Boolean;*/
										
		public function SprCake(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{	
			super(_x,_y);
			loadGraphic(Glob.cakeSheet,true,true,32,32,true);
			
			drag.x = kDragX;
			
			isMovingLeft = false;
			isMovingRight = false;
			isJumping = false;
			isFalling = false;
			isBallooning = false;
			isRunning = false;
		}
		
		override public function update():void {
			super.update();
			setAccel();
		}
		
		private function setAccel():void {
			// reset the acceleration
			acceleration.x = 0;
			acceleration.y = Glob.GRAV_ACCEL;
			// check if it's moving
			if (isMovingLeft) {
				acceleration.x += (isRunning) ? -kMoveFastAccelX : -kMoveAccelX;
				isMovingLeft = false;
			}
			else if (isMovingRight) {
				acceleration.x += (isRunning) ? kMoveFastAccelX : kMoveAccelX;
				isMovingRight = false;
			}
			maxVelocity.x = (isRunning) ? kFastMaxVelX : kMaxVelX;
			isRunning = false;
			// check if it's jumping, falling, or ballooning
			if (isJumping) {
				velocity.y -= kJumpVelY;
				isJumping = false;
			}
			else if (isFalling) {
				if (velocity.y < 0) {
					velocity.y = 0;
				}
				isFalling = false;
			}
			maxVelocity.y = (isBallooning) ? kBalloonMaxVelY : kMaxVelY;
			isBallooning = false;
		}
		
		public function moveLeft():void {
			isMovingLeft = true;
		}
		
		public function moveRight():void {
			isMovingRight = true;
		}
		
		public function jump():void {
			if (isTouching(FlxObject.DOWN)) {
				isJumping = true;
			}
		}
		
		public function fall():void {
			isFalling = true;
		}
		
		public function run():void {
			isRunning = true;
		}
		
		public function balloon():void {
			if (velocity.y > 0) {
				isBallooning = true;
			}
		}
			
			
			/*
			
			acceleration.y = Glob.GRAV_ACCEL;
			drag.x = MOVE_DECEL;
			maxVelocity.x = MAX_VEL_X;
			maxVelocity.y = MAX_VEL_Y;
			
			balloon = new FlxSprite(x,y);
			balloon.loadGraphic(Glob.balloonSheet,true,true,32,32,true);
			balloon.acceleration.y = Glob.GRAV_ACCEL/222.222;
			balloon.maxVelocity.x = MAX_VEL_X/2.2;
			balloon.maxVelocity.y = MAX_VEL_Y/22.22;
			balloon.visible = false;
			balloon.drag = drag;
			
			balloonString = new FlxSprite(x,y,Glob.balloonStringSheet);
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
			
			// reset acceleration
			//acceleration = new FlxPoint(0,Glob.GRAV_ACCEL);
			balloon.acceleration = new FlxPoint(0,0);
			
			super.update();
			
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
				
				acceleration.x -= Math.abs(_distToBalloon - stringLength)*0.5*Glob.GRAV_ACCEL*Math.sin(_theta);
				acceleration.y -= Math.abs(_distToBalloon - stringLength)*Glob.GRAV_ACCEL*Math.pow(Math.sin(_theta),2.0);
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
		}*/
	}
}