package
{
	public class Level extends ZNode
	{
		import org.flixel.*;
		
		public var previous:Level;
		public var next:Level;
		
		private const SCALE_UNCURSED:Number = 0.5;
		private const SCALE_CURSED:Number = 1.0;
		
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
			
		}
	}
}