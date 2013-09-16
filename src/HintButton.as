package
{
	import org.flixel.*;
	
	public class HintButton extends ZNode
	{
		/*
		public var x:Number;
		public var y:Number;
		
		private var key:FlxText;
		private var keyDX:Number;
		private var keyDY:Number;
		
		private var command:FlxText;
		private var commandDX:Number;
		private var commandDY:Number;
		*/
		
		private const kCharLength:Number = 10;
		
		public function HintButton(_keyString:String,_commandString:String,_flipped:Boolean=false)
		{
			super();
			
			var _img:FlxSprite = new FlxSprite();
			_img.loadGraphic(Glob.exitHintSheet);
			_img.scale.x = _flipped ? -1 : 1;
			width = _img.width;
			height = _img.height;
			add(_img);
			
			var _keyImg:FlxSprite = new FlxSprite();
			_keyImg.loadGraphic(Glob.keySheet);
			add(_keyImg);
			
			var _keyTextWidth:Number = _keyString.length*kCharLength;
			_keyImg.scale.x = _keyTextWidth/_keyImg.width;
			_keyImg.x = _img.width/2.0-_keyImg.width/2.0;
			_keyImg.y = 8;
			
			var _keyText:FlxText = new FlxText(_img.width/2.0-_keyTextWidth/2.0,_keyImg.y+1,_keyTextWidth,"   "+_keyString+"   ");
			_keyText.alignment = "center";
			add(_keyText);
			_keyText.color = 0xff444444;
			
			var _commandTextWidth:Number = _commandString.length*kCharLength;
			var _commandText:FlxText = new FlxText(_img.width/2.0-_commandTextWidth/2.0,22,_commandTextWidth,_commandString);
			_commandText.alignment = "center";
			add(_commandText);
			
		}
		
		/*
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
		*/
	}
}