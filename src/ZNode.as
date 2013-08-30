package
{
	import org.flixel.*;
	import org.flixel.system.debug.VCR;
	
	public class ZNode extends FlxSprite
	{
		public var children:FlxGroup;
		
		public function ZNode(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y,_simpleGraphic);
			children = new FlxGroup();
		}
		
		public function add(_spr:FlxSprite):void {
			children.add(_spr);
		}
		
		override public function draw():void {
			super.draw();
			for (var i:uint = 0; i < children.length; i++) {
				var _child:FlxSprite = children.members[i];
				// preserve child's property values
				var _oldAngle:Number = _child.angle;
				var _oldX:Number = _child.x;
				var _oldY:Number = _child.y;
				var _oldScale:FlxPoint = _child.scale;
				// change child's property values temporarily
				var _theta:Number = -_child.angle*Math.PI/180.0;
				_child.x = x - width/2.0 + Math.cos(_theta)*_child.x + Math.sin(_theta)*_child.y;
				_child.y = y - height/2.0 - Math.sin(_theta)*_child.x + Math.cos(_theta)*_child.y;
				_child.angle += angle;
				_child.scale = scale;
				// draw child
				_child.draw();
				// reset child property values
				_child.angle = _oldAngle;
				_child.x = _oldX;
				_child.y = _oldY;
				_child.scale = _oldScale;
			}
		}
	}
}