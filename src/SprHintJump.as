package
{
	import org.flixel.*;
	
	public class SprHintJump extends ZNode
	{
		public function SprHintJump(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y);
			loadGraphic(Glob.hintJumpSheet);
			
			var _keyImg:FlxSprite = new FlxSprite();
			_keyImg.loadGraphic(Glob.keySheet);
			add(_keyImg);
			
			var _keyString:String = "space";
			var kCharLength:uint = 10;
			
			var _keyTextWidth:Number = _keyString.length*kCharLength;
			_keyImg.scale.x = _keyTextWidth/_keyImg.width;
			_keyImg.x = width/2.0-_keyImg.width/2.0;
			_keyImg.y = 8;
			
			var _keyText:FlxText = new FlxText(width/2.0-_keyTextWidth/2.0,_keyImg.y+1,_keyTextWidth,"   "+_keyString+"   ");
			_keyText.alignment = "center";
			add(_keyText);
			_keyText.color = 0xff444444;
			
			x = x + 16 - width/2.0;
			y = y + 32 - height;
		}
	}
}