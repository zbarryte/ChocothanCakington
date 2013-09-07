package
{
	import org.flixel.*;
	
	public class StTitle extends ZState
	{	
		private const SELECT_KEY:Array = ["SPACE"];
		
		private var prompt:FlxText;
		private var promptTime:Number = 0;
		private const PROMPT_PERIOD:Number = 0.44;
		private var promptDir:int = 1;
		private var fadeTime:Number = 0;
		private const FADE_PERIOD:Number = 2.22;
		
		override public function create():void {
			
			FlxG.bgColor = 0xff881111;
			
			// begin music
			//Glob.titleMusic.play();
			ZAudioHandler.addMusic(Glob.titleMusic);
			
			super.create();
		}
		
		override public function createObjects():void {
			// set up ZState vars
			transToTime = 0.22;
			
			// set up prompt
			var promptW:Number = 100;
			var promptAlignH:Number = 100;
			prompt = new FlxText(Glob.CENT.x-promptW/2.0,Glob.CENT.y+promptAlignH,promptW,"press space bar");
			prompt.alignment = "center";
			prompt.scale.x = 2;
			prompt.scale.y = 2;
			add(prompt);
		}
		
		override public function update():void {
			pulsePrompt();
			super.update();
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(SELECT_KEY)) {
				ZAudioHandler.clearAll();
				goTo(StMenu);
			}
		}
		
		// Prompt Stuff
		private function pulsePrompt():void {
			if (fadeTime < FADE_PERIOD) {
				fadeTime += FlxG.elapsed;
				prompt.alpha = 1.0 - (FADE_PERIOD-fadeTime)/FADE_PERIOD;
			}
			promptTime += FlxG.elapsed;
			prompt.scale.x += promptDir*0.022;
			prompt.scale.y += promptDir*0.022;
			if (promptTime >= PROMPT_PERIOD) {
				promptTime = 0;
				promptDir *= -1;
			}
		}
		public function resetPrompt():void {
			promptTime = 0;
			promptDir = 1;
			prompt.scale.x = 1;
			prompt.scale.y = 1;
		}
	}
}