package
{
	import org.flixel.*;
	
	public class ZButtonGroup extends FlxGroup
	{
		public var x:Number;
		public var y:Number;
		protected var spacing:int;
		
		private var buttonIndex:int;
		
		public function ZButtonGroup(_x:Number=0,_y:Number=0,_spacing:int=0,_maxSize:uint=0) {
			super(_maxSize);
			x = _x;
			y = _y;
			spacing = _spacing;
			buttonIndex = 0;
		}
		
		public function curseFoward():void {
			// uncurse current button
			var _buttonIndexNext:uint = (buttonIndex + 1 < length) ? buttonIndex + 1 : 0;
			members[buttonIndex].uncurse();
			// curse new button
			buttonIndex = _buttonIndexNext;
			members[buttonIndex].curse();
		}
		
		public function curseBack():void {
			// uncurse current button
			var _buttonIndexNext:uint = (buttonIndex - 1 >= 0) ? buttonIndex - 1 : length - 1;
			members[buttonIndex].uncurse();
			// curse new button
			buttonIndex = _buttonIndexNext;
			members[buttonIndex].curse();
		}
		
		public function select():void {
			members[buttonIndex].select();
			members[buttonIndex].curse();
		}
		
		public function reset():void {
			members[buttonIndex].uncurse();
			
			buttonIndex = 0;
			members[buttonIndex].curse();
		}
		
		public function getCursed():ZButton {
			return members[buttonIndex];
		}
		
		public function addButton(_button:ZButton):void {
			
			// curse first button
			if (length<=0) {
				_button.curse();
			} else {
				_button.uncurse();
			}
			// position buttons
			_button.setXY(x,y);
			
			y += spacing;
			super.add(_button);
		}
	}
}