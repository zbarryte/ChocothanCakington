package
{
	import org.flixel.*;
	
	public class SprBalloon extends ZNode
	{	
		private var targetX:Number;
		private var targetY:Number;
		private var targetScaleX:Number;
		private var targetScaleY:Number;
		
		private const kAnchorX:Number = 0.0;
		private const kAnchorY:Number = 0.0;
		private const kAnchorScaleX:Number = 0.22;
		private const kAnchorScaleY:Number = 0.22;
		
		private const kScaleFactor:Number = 0.22;
		
		private const kInflateX:Number = 0;
		private const kInflateY:Number = -64;
		private const kInflateScaleX:Number = 1.0;
		private const kInflateScaleY:Number = 1.0;
		
		public function SprBalloon(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super();
			loadGraphic(Glob.balloonSheet);
			
			deflateSudden();
			deflate();
			
		}
		
		private function setTarget(_x:Number,_y:Number,_scaleX:Number,_scaleY:Number):void {
			targetX = _x;
			targetY = _y;
			targetScaleX = _scaleX;
			targetScaleY = _scaleY;
		}
		
		private function setTargetSudden(_x:Number,_y:Number,_scaleX:Number,_scaleY:Number):void {
			x = _x;
			y = _y;
			scale.x = _scaleX;
			scale.y = _scaleY;
		}
		
		public function inflate():void {
			setTarget(kInflateX,kInflateY,kInflateScaleX,kInflateScaleY);
		}
		
		public function deflate():void {
			setTarget(kAnchorX,kAnchorY,kAnchorScaleX,kAnchorScaleY);
		}
		
		public function inflateSudden():void {
			setTargetSudden(kInflateX,kInflateY,kInflateScaleX,kInflateScaleY);
		}
		
		public function deflateSudden():void {
			setTargetSudden(kAnchorX,kAnchorY,kAnchorScaleX,kAnchorScaleY);
		}
		
		override public function update():void {
			
			super.update();
			
			var _dirX:Number = targetX - x;
			var _dirY:Number = targetY - y;
			var _rescaleX:Number = targetScaleX - scale.x;
			var _rescaleY:Number = targetScaleY - scale.y;
			
			x += _dirX*kScaleFactor;
			y += _dirY*kScaleFactor;
			scale.x += _rescaleX;
			scale.y += _rescaleY;
			
			// hide an anchored balloon
			visible = true;
			if (x == kAnchorX && y == kAnchorY &&
				scale.x == kAnchorScaleX && scale.y == kAnchorScaleY) {
				
				visible = false;
			}
		}
	}
}