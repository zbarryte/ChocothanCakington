package
{
	public class Level extends ZNode
	{
		import org.flixel.*;
		
		public var previous:Level; // the level before
		public var next:Level; // the level after
		public var name:String;
		public var index:uint;
		public var goal:uint;
		
		private var flag:SprFlag;
		
		private const SCALE_UNCURSED:Number = 0.5; // scale for x and y when uncursed
		private const SCALE_CURSED:Number = 0.7; // scale for x and y when cursed
		
		private const kOpenAnim:String = "OPEN";
		private const kBeatenAnim:String = "BEATEN";
		private const kLockedAnim:String = "LOCKED";
		
		public function Level(_levelNum:uint)
		{
			super();
			index = _levelNum;
			name = Glob.levelName(_levelNum);
			goal = Glob.levelGoal(_levelNum);
			loadGraphic(Glob.mapNodeSheet,true,false,64,64); // this could also be retreived from data
			addAnimation(kOpenAnim,[0]);
			addAnimation(kBeatenAnim,[1]);
			addAnimation(kLockedAnim,[2]);
			previous = null;
			next = null;
			flag = new SprFlag();
			add(flag);
			flag.x = flag.width/2.0 + width/2.0;
			//flag.y = height/2.0;
			flag.y = -flag.height;
			status = status;
		}
		
		public function curse():void {
			scale.x = SCALE_CURSED;
			scale.y = SCALE_CURSED;
		}
		
		public function uncurse():void {
			scale.x = SCALE_UNCURSED;
			scale.y = SCALE_UNCURSED;
		}
		
		public function select():void {
			// do nothing for now
		}
		
		public function set status(_status:String):void {
			if (_status == Glob.kLocked) {
				flag.alpha = 0;
				//flag.makeSad();
				play(kLockedAnim);
			} else if (_status == Glob.kBeaten) {
				flag.alpha = 1;
				flag.makeHappy();
				play(kBeatenAnim);
			} else if (_status == Glob.kUnlocked) {
				flag.alpha = 1;
				flag.makeSad();
				play(kOpenAnim);
			}
		}
		public function get status():String {
			return Glob.levelStatus(index);
		}
		
		public function isUnlocked():Boolean {
			return (status == Glob.kBeaten || status == Glob.kUnlocked);
		}
	}
}