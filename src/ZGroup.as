package
{
	import org.flixel.*;
	
	public class ZGroup extends FlxGroup
	{
		private var buttonIndex:int; // current button
		public static const SPACING:uint = 5; // spacing between buttons
		
		// Controls
		private const SELECT_BUTTON_KEY:Array = ["SPACE"];
		private const CURSE_FORWARD_KEY:Array = ["DOWN","RIGHT"];
		private const CURSE_BACK_KEY:Array = ["UP","LEFT"];
		
		public function ZGroup(MaxSize:uint=0)
		{	
			super(MaxSize);
			buttonIndex = 0;
		}
		
		public function curseFoward():void {
			// uncurse current button
			var _buttonIndexNext:uint = (buttonIndex + 1 < length) ? buttonIndex + 1 : 0;
			members[buttonIndex].switchState(ZButton.UNCURSED);
			// curse new button
			buttonIndex = _buttonIndexNext;
			members[buttonIndex].switchState(ZButton.CURSED);
			
		}
		
		public function curseBack():void {
			// uncurse current button
			var _buttonIndexNext:uint = (buttonIndex - 1 >= 0) ? buttonIndex - 1 : length - 1;
			members[buttonIndex].switchState(ZButton.UNCURSED);
			// curse new button
			buttonIndex = _buttonIndexNext;
			members[buttonIndex].switchState(ZButton.CURSED);
		}
		
		public function select():void {
			members[buttonIndex].switchState(ZButton.SELECTED);
		}
		
		public function reset():void {
			members[buttonIndex].switchState(ZButton.UNCURSED);
			
			buttonIndex = 0;
			members[buttonIndex].switchState(ZButton.CURSED);
		}
		
		override public function update():void {
			super.update();
			if (Glob.justPressed(CURSE_FORWARD_KEY)) {
				curseFoward();
			} else if (Glob.justPressed(CURSE_BACK_KEY)) {
				curseBack();
			} else if (Glob.justPressed(SELECT_BUTTON_KEY)) {
				select();
			}
		}
		
	}
}