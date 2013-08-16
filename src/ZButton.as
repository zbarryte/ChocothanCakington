package 
{
	import org.flixel.*;
	
	public class ZButton extends FlxGroup
	{
		public static const W:Number = 222;
		public static const H:Number = 44;
		
		public var x:Number;
		public var y:Number;
		
		private var callback:Function; // called when button is selected
		
		protected var state:String;
		// state string corresponds to animation
		public static const UNCURSED:String = "UNCURSED";
		public static const CURSED:String = "CURSED";
		public static const SELECTED:String = "SELECTED";
		
		public function ZButton(_callback:Function=null,_state:String=ZButton.UNCURSED,_maxSize:uint=0)
		{
			super(_maxSize);
			callback = _callback;
			switchState(_state);
		}
		
		protected function switchState(_state:String):void {
			state = _state;
		}
		
		public function stateIs(_state:String):Boolean {
			return (state == _state);
		}
		
		public function curse():void {
			switchState(CURSED);
		}
		public function uncurse():void {
			switchState(UNCURSED);
		}
		public function select():void {
			switchState(SELECTED);
			callback();
		}
		
		public function setXY(_x:Number,_y:Number):void {
			for (var i:uint = 0; i < length; i++) {
				members[i].x = _x;
				members[i].y = _y;
				x = _x;
				y = _y;
			}
		}
		
	}
}