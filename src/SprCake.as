package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class SprCake extends ZNode
	{			
		private const kMaxVelX:Number = 10.0*32.0; // max x velocity, in pixels per second
		private const kMoveAccelX:Number = Math.pow(10*32.0,2.0); // acceleration of motion, in pixels per second^2
		private const kDragX:Number = kMoveAccelX/2.0; // drags against motion in the x dir, in pixels per second^2
		private const kJumpVelY:Number = Math.pow(Glob.GRAV_ACCEL*10.0*32.0,0.5); // initial y jump velocity, in pixels per second
		private const kMaxVelY:Number = kJumpVelY*2.0; // max y velocity, in pixels per second
		
		private var isMovingLeft:Boolean;
		private var isMovingRight:Boolean;
		private var isJumping:Boolean;
		private var isFalling:Boolean;
		private var isBallooning:Boolean;
		private var isRunning:Boolean;
		
		private var face:ZNode;
		private var jaw:ZNode;
		private var eyeL:ZNode;
		private var eyeR:ZNode;
		private var feet:ZNode;
		
		private const kFeetAnimIdle:String = "IDLE";
		private const kFeetAnimWalk:String = "WALK";
		private const kFeetAnimRun:String = "RUN";
		private const kFeetAnimJump:String = "JUMP";
		private const kEyeAnimBlink:String = "BLINK";
		
		private var blink:ZTimedEvent;
		private var idle:ZTimedEvent;
		
		private var jawY:Number;
		private var faceY:Number;
		private var faceAngle:Number;
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
			// set up the base
			super(_x,_y);
			width = 32;
			height = 32;
			// set up feet
			feet = new ZNode();
			feet.loadGraphic(Glob.cakeFeetSheet,true,false,32,32);
			feet.addAnimation(kFeetAnimIdle,[0]);
			feet.addAnimation(kFeetAnimWalk,[5,6,7,8],22,false);
			feet.addAnimation(kFeetAnimRun,[5,6,7,8],44,false);
			feet.addAnimation(kFeetAnimJump,[9]);
			add(feet);
			// set up the jaw
			jaw = new ZNode();
			jaw.loadGraphic(Glob.cakeJawSheet);
			add(jaw);
			jawY = 0.0;
			// set up the face
			face = new ZNode();
			face.loadGraphic(Glob.cakeFaceSheet);
			jaw.add(face);
			faceY = 0.0;
			faceAngle = 0.0;
			// set up eyes
			eyeL = new ZNode();
			eyeL.loadGraphic(Glob.cakeEyeLSheet,true,true,32,32);
			eyeL.addAnimation(kEyeAnimBlink,[0,1,2,1,0],22,false);
			eyeR = new ZNode();
			eyeR.loadGraphic(Glob.cakeEyeRSheet,true,true,32,32);
			eyeR.addAnimation(kEyeAnimBlink,[0,1,2,1,0],22,false);
			face.add(eyeL);
			face.add(eyeR);
			// time blinks
			blink = new ZTimedEvent(0.75,maybeBlink);
			idle = new ZTimedEvent(0.75,idleAction);
			// drag
			drag.x = kDragX;
			// set up state properties
			isMovingLeft = false;
			isMovingRight = false;
			isJumping = false;
			isFalling = false;
			isBallooning = false;
			isRunning = false;
		}
		
		private function maybeBlink():void {
			if (Math.random()*2>=1.5) {
				eyeL.play(kEyeAnimBlink);
			}
			if (Math.random()*2>=1.5) {
				eyeR.play(kEyeAnimBlink);
			}
		}
		
		private function idleAction():void {
			if (Math.random()*3>=2.5) {
				jawY = int(Math.random()*2);
			}
			if (Math.random()*3>=2.5) {
				faceY = -int(Math.random()*2);
			}
		}
		
		override public function update():void {
			super.update();
			updateAnimations();
			updateMovements();
		}
		
		private function updateAnimations():void {
			jaw.y = jawY;
			face.y = faceY;
			face.angle = faceAngle;
			// run
			if (isTouching(FlxObject.DOWN) && velocity.x != 0) {
				if (maxVelocity.x <= kMaxVelX) {
					feet.play(kFeetAnimWalk);
				} else {
					feet.play(kFeetAnimRun);
				}
				
				if (feet.frame == 6 || feet.frame == 7) {
					jaw.y = 2;
				}
			}
			// idle
			if (isTouching(FlxObject.DOWN) && velocity.x == 0 && velocity.y == 0) {
				feet.play(kFeetAnimIdle);
				idle.update();
			}
			// jump
			if (!isTouching(FlxObject.DOWN)) {
				feet.play(kFeetAnimJump);
				face.angle = Math.random()*2*Math.pow(-1,int(Math.random()*2));
				face.y = -Math.random()*3;
			}
			// blink
			blink.update();
		}
		
		private function updateMovements():void {
			// reset the accel and max vel
			acceleration.x = 0;
			acceleration.y = Glob.GRAV_ACCEL;
			maxVelocity.x = kMaxVelX;
			maxVelocity.y = kMaxVelY;
			// check if it's moving
			if (isMovingLeft) {
				acceleration.x += -kMoveAccelX;
				isMovingLeft = false;
			}
			else if (isMovingRight) {
				acceleration.x += kMoveAccelX;
				isMovingRight = false;
			}
			// check if it's running
			if (isRunning) {
				maxVelocity.x *= 1.5;
				acceleration.x *= 1.5;
				isRunning = false;
			}
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
			} else if (isBallooning) {
				//maxVelocity.x *= 0.25;
				maxVelocity.y *= 0.75;
				acceleration.x *= 0.05;
				acceleration.y *= 0.05;
				isBallooning = false;
			}
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