package
{
	public class SprHintMove extends ZNode
	{
		public function SprHintMove(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y);
			loadGraphic(Glob.hintMoveSheet);
		}
	}
}