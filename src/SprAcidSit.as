package
{
	import org.flixel.*;
	
	public class SprAcidSit extends ZNode
	{
		
		private var randomBubble:ZTimedEvent;
		
		public function SprAcidSit(_x:Number=0, _y:Number=0, _simpleGraphic:Class=null)
		{
			super(_x, _y);
			loadGraphic(Glob.acidSitSheet,true,false,32,32);
			
			
			randomBubble = new ZTimedEvent(0.11,function():void {
				frame = Math.random()*4;
			});
		}
		
		override public function update():void {
			randomBubble.update();
			super.update();
		}
	}
}