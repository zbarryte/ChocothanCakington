package
{
	import org.flixel.*;
	
	public class ZState extends FlxState
	{
		public var prev:ZState; // previous state
		public var isControllable:Boolean; // can the state be controlled?
		protected var isPlaying:Boolean; // is the state playing?
		protected var isTransitioning:Boolean;
		protected var wasPlaying:Boolean;
		protected var transToTime:Number; // time to transition to the next state
		protected var transBackTime:Number; // time to transition to the previous state
		protected var transResetTime:Number;
		protected var areObjectsCreated:Boolean; // have we created objects?
		protected var transitionObjects:FlxGroup;
		protected var canPause:Boolean;
		
		protected var overlay:FlxSprite;
		
		public function ZState()
		{
			super();
			
			transToTime = 0;
			transBackTime = 0;
			transResetTime = 0;
			isControllable = true;
			isPlaying = true;
			isTransitioning = false;
			areObjectsCreated = false;
			transitionObjects = new FlxGroup();
			canPause = true;
		}
		
		override public function create():void {
			remove(overlay);
			transitionObjects.clear();
			if (wasPlaying) {resume();}
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
			wasPlaying = false;
			if (isPlaying) {
				wasPlaying = true;
				ZAudioHandler.update();
				super.update();
				updateAnimations();
				if (isControllable) {
					updateControls();
				}
			} else if (canPause) {
				updatePause();
			}
			if (isTransitioning) {
				transitionObjects.update();
			}
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			if (isTransitioning) {
				transitionObjects.postUpdate();
			}
		}
		
		override public function preUpdate():void {
			super.preUpdate();
			if (isTransitioning) {
				transitionObjects.preUpdate();
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
		
		protected function goBack(_time:Number=0):void {
			if (prev != null) {
				addTransitionObject(new ZTimedEvent(_time,function():void{actuallyDestroy(); FlxG.switchState(prev);},false));
			}
		}
		
		protected function goBackRefreshed(_time:Number=0):void {
			//prev.refresh();
			//goBack(_time);
			var _tmpPrev:ZState;
			var _class:Class;
			if (prev.prev != null) {_tmpPrev = prev.prev;}
			_class = FlxU.getClass(FlxU.getClassName(prev));
			prev.actuallyDestroy();
			var _state:ZState = new _class();
			if (_tmpPrev != null) {_state.prev = _tmpPrev;}
			addTransitionObject(new ZTimedEvent(_time,function():void{FlxG.switchState(_state);},false));
			
		}
		
		protected function goTo(_class:Class,_time:Number=0):void {
			var _state:ZState = new _class();
			_state.prev = this;
			addTransitionObject(new ZTimedEvent(_time,function():void{FlxG.switchState(_state);},false));
		}
		
		
		protected function refresh(_time:Number=0):void {
			var _class:Class = FlxU.getClass(FlxU.getClassName(this));
			goToNoReturn(_class,_time);
		}
		
		protected function goToNoReturn(_class:Class,_time:Number=0):void {
			var _state:ZState = new _class();
			if (prev !=null) {_state.prev = prev;}
			addTransitionObject(new ZTimedEvent(_time,function():void{FlxG.switchState(_state);},false));
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
		
		protected function addTransitionObject(_obj:FlxBasic):void {
			isTransitioning = true;
			transitionObjects.add(_obj);
		}
		
		protected function removeTransitionObject(_obj:FlxBasic):void {
			transitionObjects.remove(_obj);
		}
		
		protected function fadeToColor(_color:Number,_time:Number):void {
			
			if (!isTransitioning) {
			overlay = new FlxSprite(0,0);
			overlay.makeGraphic(FlxG.width,FlxG.height,_color);
			overlay.alpha = 0;
			overlay.scrollFactor = new FlxPoint(0,0);
			add(overlay);
			var _fade:ZTimedEvent = new ZTimedEvent(_time,
													function():void {
														isTransitioning = false;
													},
													false,
													true,
													function():void {
														overlay.alpha += FlxG.elapsed/_time;
													});
			addTransitionObject(_fade);
			}
		}
		
		protected function fadeFromColor(_color:Number,_time:Number):void {
			if (!isTransitioning) {
				//FlxG.log("fadin from?");
			overlay = new FlxSprite(0,0);
			overlay.makeGraphic(FlxG.width,FlxG.height,_color);
			overlay.alpha = 1.0;
			add(overlay);
			var _fade:ZTimedEvent = new ZTimedEvent(_time,
													function():void {
														isTransitioning = false;
													},
													false,
													true,
													function():void {
														overlay.alpha -= FlxG.elapsed/_time;
													});
			addTransitionObject(_fade);
			}
		}
	}
}