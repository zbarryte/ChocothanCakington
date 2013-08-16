package
{
	import org.flixel.*;
	
	public class HintButton extends FlxGroup
	{
		public var x:Number;
		public var y:Number;
		
		private var key:FlxText;
		private var keyDX:Number;
		private var keyDY:Number;
		
		private var command:FlxText;
		private var commandDX:Number;
		private var commandDY:Number;
		
		public function HintButton(_x:Number,_y:Number,_keyString:String,_commandString:String)
		{
			x = _x;
			y = _y;
			
			super(0);
			
		}
		
		public function set x(_x:Number) {
			x = _x;
			key.x = _x + keyDX;
			command.x = _x + commandDX;
		}
		
		public function set y(_y:Number) {
			y = _y;
			key.y = _y + keyDY;
			command.y = _y + commandDY;
		}
	}
}