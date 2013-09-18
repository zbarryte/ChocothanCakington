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
		
		private const SCALE_UNCURSED:Number = 0.5; // scale for x and y when uncursed
		private const SCALE_CURSED:Number = 0.7; // scale for x and y when cursed
		
		public function Level(_levelNum:uint)
		{
			super();
			index = _levelNum;
			name = Glob.levelName(_levelNum);
			goal = Glob.levelGoal(_levelNum);
			loadGraphic(Glob.mapNodeSheet); // this could also be retreived from data
			previous = null;
			next = null;
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
	}
}