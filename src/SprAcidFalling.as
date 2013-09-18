package
{
	public class SprAcidFalling extends ZNode
	{
		public function SprAcidFalling(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y);
			loadGraphic(Glob.acidFallingSheet,true,false,32,32);
			addAnimation("fall",[0,1,2,3],22,true);
			play("fall");
		}
		
		/*
		override public function update():void {
			super.update();
			scale.x = (10.0-frame%2)/10.0;
		}*/
	}
}