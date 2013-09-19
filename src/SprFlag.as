package
{
	import org.flixel.FlxSprite;
	
	public class SprFlag extends FlxSprite
	{
		private var happyEvent:ZTimedEvent;
		
		public function SprFlag(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(Glob.flagSheet,true,false,32,32);
			addAnimation("happy",[1,2,3,4,5,6,1],22,false);
			makeSad();
		}
		
		public function makeSad():void {
			frame = 0;
			happyEvent = null;
		}
		
		public function makeHappy():void {
			frame = 1;
			happyEvent = new ZTimedEvent(3,function():void {play("happy");});
		}
		
		override public function update():void {
			if (happyEvent) {
				happyEvent.update();
			}
			super.update();
		}
	}
}