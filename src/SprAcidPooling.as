package
{
	public class SprAcidPooling extends ZNode
	{
		public function SprAcidPooling(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y);
			loadGraphic(Glob.acidPoolingSheet,true,false,32,32);
			addAnimation("pool",[0,1,2,3],22,true);
			play("pool");
		}
	}
}