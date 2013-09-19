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
		private const FADE_PERIOD:Number = 4.44;
		
		//private var brightness:FlxSprite;
		
		override public function create():void {
			
			//FlxG.bgColor = 0xff881111;
			FlxG.bgColor = 0xff443333;
			
			// begin music
			//Glob.titleMusic.play();
			ZAudioHandler.addMusic(Glob.titleMusic);
			
			super.create();
			
			//fadeFromColor(0xffffffff);
		}
		
		override public function createObjects():void {
			// set up ZState vars
			transToTime = 0.22;//5;
			
			var cake:SprCake = new SprCake();
			cake.canMove = false;
			cake.scale.x = 10;
			cake.scale.y = 10;
			Glob.centerNodeX(cake);
			Glob.bottomNode(cake);
			cake.y += cake.scale.y*cake.height/5.0;
			add(cake);
			
			// set up prompt
			var promptW:Number = 100;
			var promptAlignH:Number = 100;
			prompt = new FlxText(Glob.CENT.x-promptW/2.0,Glob.CENT.y+promptAlignH,promptW,"press space bar");
			prompt.alignment = "center";
			prompt.scale.x = 2;
			prompt.scale.y = 2;
			prompt.y -= cake.scale.y*cake.height/3.0;
			add(prompt);
			
			/*
			brightness = new FlxSprite(0,0);
			brightness.makeGraphic(FlxG.width,FlxG.height,0xffffffff);
			//brightness.blend = "multiply";
			brightness.alpha = 0;
			add(brightness);*/
		}
		
		override public function update():void {
			pulsePrompt();
			super.update();
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(SELECT_KEY)) {
				ZAudioHandler.clearAll();
				ZAudioHandler.addMusic(Glob.menuMusic);
				fadeToColor(0xffffffff,transToTime);
				goTo(StMenu,transToTime);
				/*addTimedEvent(new ZTimedEvent(transToTime,null,false,true,function():void {
					brightness.alpha += 0.1;
				}));*/
			}
		}
		
		/*
		override protected function goTo(_class:Class):void {
			var _state:ZState = new _class();
			_state.prev = this;
			_state.create();
			_state.isControllable = false;
			FlxG.bgColor = 0xff881111;
			addTimedEvent(new ZTimedEvent(transToTime,function():void{_state.isControllable = true; FlxG.switchState(_state);},false,true,function():void{darkness.alpha += 0.01; _state.update();}));
		}*/
		
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