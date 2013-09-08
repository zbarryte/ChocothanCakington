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
		protected var transResetTime:Number;
		protected var areObjectsCreated:Boolean; // have we created objects?
		
		public function ZState()
		{
			super();
			
			transToTime = 0;
			transBackTime = 0;
			transResetTime = 0;
			isControllable = true;
			isPlaying = true;
			areObjectsCreated = false;
		}
		
		override public function create():void {
			resume();
			if (prev!=null) {prev.pause();}
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
				ZAudioHandler.update();
				super.update();
				updateAnimations();
				if (isControllable) {
					updateControls();
				}
			} else {
				updatePause();
			}
		}
		
		protected function updateAnimations():void {
			// implemented by children, for animating objects
		}
		
		protected function updateControls():void {
			// implemented by children, for listening to controls
		}
		
		protected function updatePause():void {
			// implemented by children, updates even when paused
		}
		
		protected function goBack():void {
			if (prev != null) {
				add(new ZTimedEvent(transBackTime,function():void{actuallyDestroy(); FlxG.switchState(prev);},false));
			}
		}
		
		protected function goBackRefreshed():void {
			prev.refresh();
			goBack();
		}
		
		protected function goTo(_class:Class):void {
			var _state:ZState = new _class();
			_state.prev = this;
			add(new ZTimedEvent(transToTime,function():void{FlxG.switchState(_state);},false));
		}
		
		protected function refresh():void {
			var _class:Class = FlxU.getClass(FlxU.getClassName(this));
			goTo(_class);
		}
		
		override public function destroy():void {
			// do nothing
		}
		
		public function pause():void {
			isPlaying = false;
		}
		
		public function resume():void {
			isPlaying = true;
		}
		
		public function actuallyDestroy():void {
			super.destroy();
		}
	}
}