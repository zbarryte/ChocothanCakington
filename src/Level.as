package
{
	public class Level extends ZNode
	{
		public var previous:Level;
		public var next:Level;
		
		public function Level(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y, _simpleGraphic);
			previous = null;
			next = null;
		}
	}
}