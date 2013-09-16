package
{
	import org.flixel.*;
	
	public class BtnGrpPause extends ZButtonGroup
	{	
		//private const PAUSE_KEY:Array = ["ENTER"];
		
		public function BtnGrpPause()
		{
			super(0,0,ZButton.H/2.0);
			Glob.centerNodeY(this);
			//Glob.centerNode(this)
			
			visible = false;
			//toggle();
			
			/*
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y-ZButton.H-spacing,Glob.buttonCakeMiddleSheet,continueReaction,"continue",ZButton.CURSED));
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y,Glob.buttonCakeMiddleSheet,restartReaction,"restart"));
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y+ZButton.H+spacing,Glob.buttonCakeBottomSheet,exitToMenuReaction,"exit to menu"));
			*/
		}
		
		/*
		// Button Reactions
		private function continueReaction():void {
			toggle();
		}
		private function restartReaction():void {
			FlxG.switchState(new StPlay());
		}
		private function exitToMenuReaction():void {
			FlxG.switchState(new StMap());
		}
		*/
		/*
		public function isOn():Boolean {
			return visible;
		}
		*/
		/*
		public function toggle():void {
			visible = !visible;
		}*/
		
		/*
		override public function reset():void {
			super.reset();
			toggle();
		}*/
		
		/*
		override public function update():void {
			if (isOn()) {
				super.update();
			}
			if (Glob.justPressed(PAUSE_KEY)) {
				//reset();
			}
		}*/
		
		/*
		override public function draw():void {
			for (var i:uint = children.length-1; i >= 0; i--) {
				//members[i].draw();
				children.members[i].draw();
			}
		}
		*/
		
		/*
		override public function draw():void {
			if (graphic && visible) {super.draw();} // don't draw the flixel logo sprites...
			for (var i:uint = children.length-1; i >= 0; i++) {
				var _child:FlxSprite = children.members[i];
				// preserve child's property values
				var _oldAngle:Number = _child.angle;
				var _oldX:Number = _child.x;
				var _oldY:Number = _child.y;
				var _oldScaleX:Number = _child.scale.x;
				var _oldScaleY:Number = _child.scale.y;
				var _oldAlpha:uint = _child.alpha;
				var _oldScrollFactor:FlxPoint = _child.scrollFactor;
				// change child's property values temporarily
				var _theta:Number = -_child.angle*Math.PI/180.0;
				_child.x = x + _child.x;//- width/2.0 + _child.width/2.0 + Math.cos(_theta)*_child.x + Math.sin(_theta)*_child.y;
				_child.y = y + _child.y;//- height/2.0 + _child.height/2.0 - Math.sin(_theta)*_child.x + Math.cos(_theta)*_child.y;
				_child.angle += angle;
				_child.scale.x = scale.x*_child.scale.x;
				_child.scale.y = scale.y*_child.scale.y;
				_child.alpha = alpha;
				_child.scrollFactor = scrollFactor;
				// draw child
				_child.draw();
				// reset child property values
				_child.angle = _oldAngle;
				_child.x = _oldX;
				_child.y = _oldY;
				_child.scale.x = _oldScaleX;
				_child.scale.y = _oldScaleY;
				_child.alpha = _oldAlpha;
				_child.scrollFactor = _oldScrollFactor;
			}
		}
		*/
	}
}