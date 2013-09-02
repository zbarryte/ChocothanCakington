package
{
	import org.flixel.*;
	
	public class ZButtonGroup extends ZNode//FlxGroup
	{
		//public var x:Number;
		//public var y:Number;
		protected var spacing:int;
		
		private var buttonIndex:int;
		
		// arbitrary period for now
		public function ZButtonGroup(_x:Number=0,_y:Number=0,_spacing:int=0) {
			//super(0);
			//x = _x;
			//y = _y;
			super(_x,_y);
			spacing = _spacing;
			buttonIndex = 0;
		}
		
		public function pulse(_dir:int):void {
			if (children.length > buttonIndex) {
				getCursed().pulse(_dir);
			}
		}
		
		public function resetPulse():void {
			if (children.length > buttonIndex) {
				getCursed().resetPulse();
			}
		}
		
		public function curseFoward():void {
			// uncurse current button
			var _buttonIndexNext:uint = (buttonIndex + 1 < children.length) ? buttonIndex + 1 : 0;
			children.members[buttonIndex].uncurse();
			// curse new button
			buttonIndex = _buttonIndexNext;
			children.members[buttonIndex].curse();
		}
		
		public function curseBack():void {
			// uncurse current button
			var _buttonIndexNext:uint = (buttonIndex - 1 >= 0) ? buttonIndex - 1 : children.length - 1;
			children.members[buttonIndex].uncurse();
			// curse new button
			buttonIndex = _buttonIndexNext;
			children.members[buttonIndex].curse();
		}
		
		public function select():void {
			children.members[buttonIndex].select();
			children.members[buttonIndex].curse();
		}
		
		public function /*reset*/restart():void {
			children.members[buttonIndex].uncurse();
			
			buttonIndex = 0;
			children.members[buttonIndex].curse();
		}
		
		public function getCursed():ZButton {
			return children.members[buttonIndex];
		}
		
		public function getCursedX():Number {
			return children.members[buttonIndex].x+x;
		}
		
		public function getCursedY():Number {
			return children.members[buttonIndex].y+y;
		}
		
		public function addButton(_button:ZButton):void {
			
			// curse first button
			if (children.length<=0) {
				_button.curse();
			} else {
				_button.uncurse();
			}
			// position buttons
			//_button.x = x;
			_button.y = spacing*children.length;
			super.add(_button);
		}
	}
}