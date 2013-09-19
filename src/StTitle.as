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
		
		private const kEyeAnimBlink:String = "BLINK";
		
		
		
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
			
			var head:FlxText = new FlxText(0,0,FlxG.width,"Chocothan Cakington in...");
			head.size = 11;
			head.alignment = "left";
			var title:FlxText = new FlxText(0,head.height+22,FlxG.width,"Michael's Birthday Capers!");
			title.size = 33;
			title.alignment = "center";
			add(head);
			add(title);
			
			// set up the face
			var face:ZNode = new ZNode();
			face.loadGraphic(Glob.cakeFaceSheet);
			add(face);
			// set up eyes
			var eyeL:ZNode = new ZNode();
			eyeL.loadGraphic(Glob.cakeEyeLSheet,true,true,32,32);
			eyeL.addAnimation(kEyeAnimBlink,[0,1,2,1,0],22,false);
			var eyeR:ZNode = new ZNode();
			eyeR.loadGraphic(Glob.cakeEyeRSheet,true,true,32,32);
			eyeR.addAnimation(kEyeAnimBlink,[0,1,2,1,0],22,false);
			face.add(eyeL);
			face.add(eyeR);
			face.scale.x = 22.0;
			face.scale.y = 22.0;
			Glob.centerNodeX(face);
			Glob.bottomNode(face);
			
			
			// set up prompt
			var promptW:Number = 100;
			var promptAlignH:Number = 100;
			prompt = new FlxText(Glob.CENT.x-promptW/2.0,Glob.CENT.y+promptAlignH,promptW,"press space bar");
			prompt.alignment = "center";
			prompt.scale.x = 2;
			prompt.scale.y = 2;
			prompt.y -= face.scale.y*face.height/3.0;
			add(prompt);
			
			var alpha:ZNode = new ZNode();
			alpha.loadGraphic(Glob.alphaSheet);
			alpha.angle =22;
			alpha.scale.x = 0.52;
			alpha.scale.y = 0.52;
			alpha.x = FlxG.width-alpha.width;
			alpha.y = alpha.height*2;
			
			add(alpha);
			
			var te:ZTimedEvent = new ZTimedEvent(0.22,null,true,true,function(_dir:int):void {
				alpha.scale.x += 0.022*_dir;
				alpha.scale.y += 0.022*_dir;
				alpha.angle += _dir*2;
			},function():void {
				alpha.angle = 22;
				alpha.scale.x = 0.52;
				alpha.scale.y = 0.52;
			});
			add(te);
			
			
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