package 
{
	import org.flixel.*;
	
	public class ZButton extends ZNode
	{
		public static const W:Number = 333;
		public static const H:Number = 44;
		
		private var callback:Function; // called when button is selected
		
		protected var state:String;
		// state string corresponds to animation
		public static const UNCURSED:String = "UNCURSED";
		public static const CURSED:String = "CURSED";
		public static const SELECTED:String = "SELECTED";
		
		public function ZButton(_callback:Function=null,_state:String=ZButton.UNCURSED)
		{
			super();
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
		
		public function pulse(dir:int):void {
			// implemented by children
		}
		public function resetPulse():void {
			// implemented by children
		}
		
	}
}