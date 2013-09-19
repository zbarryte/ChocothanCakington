package
{
	public class SprAcidBubble extends ZNode
	{
		public function SprAcidBubble(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y);
			loadGraphic(Glob.acidBubbleSheet);
			
			// maybe now add some logic to make bubbles randomly appear on top of it, use a ztimedevent?
		}
	}
}