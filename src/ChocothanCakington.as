package
{
	import flash.events.Event;
	
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	<body onLoad="var f = document.getElementById('flashObject'); f.tabIndex = 0; f.focus();">
	
	public class ChocothanCakington extends FlxGame
	{
		public function ChocothanCakington()
		{
			super(640,480,StTitle,1,60,60,true);
			Glob.load();
			
			forceDebugger = Glob.DEBUG_ON;
		}
		
		override protected function create(FlashEvent:Event):void {
			super.create(FlashEvent);
			stage.removeEventListener(Event.DEACTIVATE,onFocusLost);
			stage.removeEventListener(Event.ACTIVATE,onFocus);
			stage.align = "TOP";
		}
	}
}