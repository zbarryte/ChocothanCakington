package
{
	import org.flixel.*;
	import org.flixel.system.debug.VCR;
	
	public class ZNode extends FlxSprite
	{
		public var children:FlxGroup;
		protected var graphic:Class;
		
		public function ZNode(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y,_simpleGraphic);
			children = new FlxGroup();
			graphic = _simpleGraphic;
		}
		
		public function add(_spr:FlxSprite):void {
			children.add(_spr);
		}
		
		override public function loadGraphic(_graphic:Class,_animated:Boolean=false,_reverse:Boolean=false,_width:uint=0,_height:uint=0,_unique:Boolean=false):FlxSprite {
			graphic = _graphic;
			return super.loadGraphic(_graphic,_animated,_reverse,_width,_height,_unique);
		}
		
		override public function draw():void {
			if (graphic && visible) {super.draw();} // don't draw the flixel logo sprites...
			for (var i:uint = 0; i < children.length; i++) {
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
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < children.length; i++) {
				var _child:FlxSprite = children.members[i];
				_child.update();
			}
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			for (var i:uint = 0; i < children.length; i++) {
				var _child:FlxSprite = children.members[i];
				_child.postUpdate();
			}
		}
		
		override public function preUpdate():void {
			super.preUpdate();
			for (var i:uint = 0; i < children.length; i++) {
				var _child:FlxSprite = children.members[i];
				_child.preUpdate();
			}
		}
	}
}