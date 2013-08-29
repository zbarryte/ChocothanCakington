package
{
	import org.flixel.*;
	
	public class ZNode extends FlxSprite
	{
		public var parent:ZNode;
		public var children:FlxGroup;
		
		public var xOffset:Number;
		public var yOffset:Number;
		public var angleOffset:Number;
		
		public function ZNode(_x:Number=0,_y:Number=0,_angle:Number=0)
		{
			super(_x,_y);
			parent = null;
			xOffset = _x;
			yOffset = _y;
			angleOffset = _angle;
			children = new FlxGroup();
		}
		
		public function add(_node:ZNode):void {
			_node.parent = this;
			children.add(_node);
		}
		
		override public function update():void {
			if (parent != null) {
				angle = parent.angle + angleOffset;
				var theta:Number = -angle*Math.PI/180.0;
				x = parent.x + Math.cos(theta)*xOffset + Math.sin(theta)*yOffset;
				y = parent.y - Math.sin(theta)*xOffset + Math.cos(theta)*yOffset;
				scale = parent.scale;
				
			} else {
				angle = angleOffset;
				x = xOffset;
				y = yOffset;
			}
			children.update();
			super.update();
		}
		
		override public function draw():void {
			super.draw();
			children.draw();
		}
	}
}