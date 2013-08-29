package
{
	import org.flixel.*;
	
	public class ZState extends FlxState
	{
		public var prev:ZState; // previous state
		protected var isControllable:Boolean; // can the state be controlled?
		protected var isPlaying:Boolean; // is the state playing?
		protected var transToTime:Number; // time to transition to the next state
		protected var transBackTime:Number; // time to transition to the previous state
		protected var areObjectsCreated:Boolean; // have we created objects?
		
		public function ZState()
		{
			super();
			
			transToTime = 0;
			transBackTime = 0;
			isControllable = true;
			isPlaying = true;
			areObjectsCreated = false;
		}
		
		override public function create():void {
			if (!areObjectsCreated) {
				createObjects();
				areObjectsCreated = true;
			}
		}
		
		public function createObjects():void {
			// implemented by children, for creating objects
		}
		
		override public function update():void {
			if (isPlaying) {
				super.update();
				updateAnimations();
				if (isControllable) {
					updateControls();
				}
			}
		}
		
		protected function updateAnimations():void {
			// implemented by children
		}
		
		protected function updateControls():void {
			// implemented by children
		}
		
		protected function goBack():void {
			//prev.revive();
			add(new ZTimedEvent(transBackTime,function():void{FlxG.switchState(prev);},false));
		}
		
		protected function goTo(_class:Class):void {
			var _state:ZState = new _class();
			_state.prev = this;
			//_state.create();
			add(new ZTimedEvent(transToTime,function():void{/*add(_state);*/FlxG.switchState(_state);},false));
		}
		
		override public function destroy():void {
			// implmented by children
		}
	}
}