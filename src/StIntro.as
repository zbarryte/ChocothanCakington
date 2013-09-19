package
{
	import org.flixel.*;
	
	public class StIntro extends ZState
	{
		
		private var kSkipKey:Array = ["ESCAPE","SPACE","ENTER"];
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			ZAudioHandler.clearAll();
			ZAudioHandler.addMusic(Glob.introMusic);
			super.create();
		}
		
		override public function createObjects():void {
			
			var text:FlxText = new FlxText(0,0,FlxG.width);
			text.y = FlxG.height/2.0;
			text.alignment = "center";
			text.size = 22;
			text.alpha = 0;
			add(text);
			
			text.text = "Chocothan...";
			
			var step1:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 1;
				add(step2);
			},false,true,function():void {
				text.alpha += 0.005;
			},null);
			
			var step2:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 0;
				text.text = "Chocothan Cakington..."
				add(step3);
			},false,true,function():void {
				text.alpha -= 0.005;
			},null);
			
			var step3:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 1;
				add(step4);
			},false,true,function():void {
				text.alpha += 0.005;
			},null);
			
			var step4:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 0;
				text.text = "You need to wake up.  There's a birthday today, and you haven't collected the presents...";
				add(step5);
			},false,true,function():void {
				text.alpha -= 0.005;
			},null);
			
			var step5:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 1;
				add(step6);
			},false,true,function():void {
				text.alpha += 0.005;
			},null);
			
			var step6:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 0;
				text.text = "You have to go to the Birthday Mines, Chocothan Cakington."
				add(step7);
			},false,true,function():void {
				text.alpha -= 0.005;
			},null);
			
			var step7:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 1;
				add(step8);
			},false,true,function():void {
				text.alpha += 0.005;
			},null);
			
			var step8:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 0;
				text.text = "Now Go!"
				add(step9);
			},false,true,function():void {
				text.alpha -= 0.005;
			},null);
			
			var step9:ZTimedEvent = new ZTimedEvent(3,function():void {
				text.alpha = 1;
				add(step10);
			},false,true,function():void {
				text.alpha += 0.05;
			},null);
			
			var step10:ZTimedEvent = new ZTimedEvent(2,function():void {
				text.alpha = 0;
				text.text = "Now Go!"
				fadeToColor(0xffffffff,0.22);
				goTo(StTitle,0.22);
			},false,true,function():void {
				text.alpha -= 0.005;
			},null);
			
			add(step1);
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(kSkipKey)) {
				fadeToColor(0xffffffff,0.22);
				goTo(StTitle,0.22);
			}
		}
		
		
	}
}