package
{
	public class Level extends ZNode
	{
		import org.flixel.*;
		
		public var previous:Level; // the level before
		public var next:Level; // the level after
		
		private const SCALE_UNCURSED:Number = 0.5; // scale for x and y when uncursed
		private const SCALE_CURSED:Number = 1.0; // scale for x and y when cursed
		
		public function Level(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y, _simpleGraphic);
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