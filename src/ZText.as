package
{
	import org.flixel.*;
	
	public class ZText extends FlxGroup
	{
		public function ZText(_x:Number=0,_y:Number=0,_string:String=null,_spacing:Number=2.2)
		{
			super(0);
			
			for (var i:uint = 0; i < _string.length; i++) {
				add(new ZLetter(_x+_spacing+ZLetter.W*i,_y,_string.charAt(i)));
			}
		}
	}
}