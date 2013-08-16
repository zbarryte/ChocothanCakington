package
{
	import org.flixel.*;
	
	public class ZState extends FlxState
	{
		protected var prev:ZState; // previous state
		protected var isControllable:Boolean; // can the state be controlled?
		protected var transToTime:Number; // time to transition to the next state
		protected var transBackTime:Number; // time to transition to the previous state

		public function ZState(_prev:ZState=null)
		{
			super();
			prev = _prev;
			isControllable = true;
			transToTime = 0;
			transBackTime = 0;
		}
		
		override public function update():void {
			if (isControllable) {
				detectControls();
			}
			super.update();
		}
		
		protected function detectControls():void {
			// implemented by children
		}
		
		protected function goBack():void {
			isControllable = false;
			add(new ZTimedEvent(transBackTime,function():void{FlxG.switchState(prev);}));
		}
		
		protected function goForwardToState(_class:Class):void {
			var state:ZState = new _class(this);
			add(new ZTimedEvent(transToTime,function():void{FlxG.switchState(state);}));
		}
	}
}