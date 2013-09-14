package
{
	import org.flixel.*;
	
	public class SprCandle extends ZNode
	{
		private var burnEvent:ZTimedEvent;
		
		public function SprCandle(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y);
			loadGraphic(Glob.cakeCandleSheet);
		}
		
		override public function update():void {
			super.update();
			if (burnEvent) {burnEvent.update();}
		}
		
		public function addFlame():void {
			var flame:ZNode = new ZNode();
			flame.loadGraphic(Glob.cakeCandleFlameSheet,true,false,8,8,true);
			add(flame);
			flame.y = -flame.height*scale.y;
			flame.x = -flame.width/2.0+scale.x*width/2.0;
			
			burnEvent = new ZTimedEvent(0.022,function():void {
				flame.frame = Math.random()*16;
				//FlxG.log(flame.frame);
			});
		}
	}
}