package
{
	import org.flixel.*;
	import org.osmf.events.TimeEvent;
	
	public class StMenu extends ZState
	{
		// Keys
		private const BACK_KEY:Array = ["ESCAPE"];
		private const SELECT_KEY:Array = ["SPACE","ENTER"];
		private const CURSE_FORWARD_KEY:Array = ["DOWN","RIGHT"];
		private const CURSE_BACK_KEY:Array = ["UP","LEFT"];
		
		private var buttonGroup:ZButtonGroup;
		
		private var cursor:ZCursor;
		
		private var exitHint:FlxSprite;
		private var selectHint:FlxSprite;
		
		private var PERIOD:Number = 0.33;
		
		private var pulseSelectedEvent:ZTimedEvent;
		
		private var balloons:FlxGroup;
		
		override public function create():void {
			// color background
			FlxG.bgColor = 0xff444444;
			super.create();
			//cursor.restart();
			//buttonGroup.restart();
			pulseSelectedEvent.reset();
			
			//transToTime = 2;
			isTransitioning = true;
			fadeFromColor(0xffffffff,10);
		}
		
		override public function createObjects():void {
			
			balloons = new FlxGroup();
			add(balloons);
			
			// set up data array to build buttons
			var buttonDataArray:Array = new Array(new Array(startReaction,"start"),
												  new Array(optionsReaction,"options"),
												  new Array(controlsReaction,"controls"),
												  new Array(creditsReaction,"credits"));
			// pick the start point for the button group
			buttonGroup = new ZButtonGroup(Glob.CENT.x-ZButton.W/2.0,FlxG.height/(buttonDataArray.length + 1),ZButton.H);
			
			// build the buttons using the data
			for (var i:uint = 0; i < buttonDataArray.length; i++) {
				
				// create the button
				var startButton:ZButton = new BtnMenu(buttonDataArray[i][0],buttonDataArray[i][1]);
				
				// add the button to the button group
				buttonGroup.addButton(startButton);
			}
			
			// add the button group to the state
			add(buttonGroup);
			//add(buttonGroup.event);
			
			// add a cursor to point to the cursed button
			cursor = new ZCursor(buttonGroup);
			add(cursor);
			//add(cursor.event);
			
			/*
			// create and add the exit button
			exitHint = new FlxSprite();
			exitHint.loadGraphic(Glob.exitHintSheet);
			exitHint.x = 0;
			exitHint.y = FlxG.height - exitHint.height;
			add(exitHint);
			add(new FlxText(exitHint.x+8,exitHint.y+4,exitHint.width,"[Esc]"));
			add(new FlxText(exitHint.x+8,exitHint.y+16,exitHint.width,"back"));
			
			// create and add the exit button
			selectHint = new FlxSprite();
			selectHint.loadGraphic(Glob.exitHintSheet);
			selectHint.scale.x *= -1;
			selectHint.x = FlxG.width - selectHint.width;
			selectHint.y = FlxG.height - selectHint.height;
			add(selectHint);
			add(new FlxText(selectHint.x+8,selectHint.y+4,exitHint.width,"[Space]"));
			add(new FlxText(selectHint.x+8,selectHint.y+16,exitHint.width,"select"));
			*/
			
			
			var selectHint:HintButton = new HintButton("Space","select",true);
			Glob.bottomNode(selectHint);
			Glob.rightNode(selectHint);
			add(selectHint);
			
			var exitHint:HintButton = new HintButton("Esc","back");
			Glob.bottomNode(exitHint);
			Glob.leftNode(exitHint);
			add(exitHint);
			
			var _pulse:Function = function(_dir:int):void {
				cursor.pulse(_dir);
				buttonGroup.pulse(_dir);
			};
			
			var _resetPulse:Function = function():void {
				cursor.resetPulse();
				buttonGroup.resetPulse();
			};
			
			pulseSelectedEvent = new ZTimedEvent(PERIOD,null,true,true,_pulse,_resetPulse);
			add(pulseSelectedEvent);
			//add(cursor.pulseEvent(PERIOD));
			
			var spawnBalloonsEvent:ZTimedEvent = new ZTimedEvent(0.11,spawnMultipleBalloons);
			add(spawnBalloonsEvent);
			
			//fadeFromColor(0xffffffff);
		}
		
		override protected function updateAnimations():void {
			
			removeOutOfFrameBalloons();
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(BACK_KEY)) {
				ZAudioHandler.clearAll();
				goBack();
			} else if (Glob.justPressed(CURSE_FORWARD_KEY)) {
				buttonGroup.curseFoward();
				//cursor.restart();
				pulseSelectedEvent.reset();
			} else if (Glob.justPressed(CURSE_BACK_KEY)) {
				buttonGroup.curseBack();
				//cursor.restart();
				pulseSelectedEvent.reset();
			} else if (Glob.justPressed(SELECT_KEY)) {
				buttonGroup.select();
				pulseSelectedEvent.reset();
			}
		}
		
		override protected function updatePause():void {
			// do nothing
		}
		
		// Button Reactions
		private function startReaction():void {
			//ZAudioHandler.clearAll();
			goTo(StMap);
		}
		private function optionsReaction():void {
			goTo(StOptions);
		}
		private function controlsReaction():void {
			goTo(StControls);
		}
		private function creditsReaction():void {
			goTo(StCredits);
		}
		
		private function spawnMultipleBalloons():void {
			var _numBalloons:uint = Math.random()*2 + 1;
			for (var i:uint = 0; i < _numBalloons; i++) {
				spawnBalloon();
			}
		}
		
		private function spawnBalloon():void {
			var _balloon:ZNode = new ZNode();
			_balloon.loadGraphic(Glob.menuBalloonSheet,true,false,32,64);
			_balloon.x = Math.random()*(FlxG.width - _balloon.width);
			_balloon.y = FlxG.height; // + some buffer distance?
			var _speed:Number = -44 -Math.random()*44;
			_balloon.addAnimation("IDLE",[0,1,2,3,4,5],-_speed/10,true);
			_balloon.play("IDLE");
			_balloon.velocity.y = _speed;
			_balloon.velocity.x = -1*Math.random()*2;
			var _scale:Number = -_speed/88;
			_balloon.scale.x = _scale;
			_balloon.scale.y = _scale;
			_balloon.color = Math.random()*0xffffff;
			_balloon.alpha = 0.77;
			balloons.add(_balloon);
		}
		
		private function removeOutOfFrameBalloons():void {
			var i:uint;
			var _balloon:ZNode;
			for (i = 0; i < balloons.length; i++) {
				_balloon = balloons.members[i];
				if (_balloon.y < -_balloon.height) {
					_balloon.kill();
				}
			}
		}
	}
}