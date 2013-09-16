package
{
	import org.flixel.*;
	import org.osmf.events.TimeEvent;
	
	public class StOptions extends ZState
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
		
		override public function create():void {
			// color background
			FlxG.bgColor = 0xff222222;
			super.create();
			pulseSelectedEvent.reset();
		}
		
		override public function createObjects():void {
			
			// set up data array to build buttons
			var buttonDataArray:Array = new Array(
				new Array(soundReaction,"sound",function():Boolean{return Glob.soundOn}),
				new Array(musicReaction,"music",function():Boolean{return Glob.musicOn})
				);
			// pick the start point for the button group
			buttonGroup = new ZButtonGroup(Glob.CENT.x-ZButton.W/2.0,FlxG.height/(buttonDataArray.length + 1),ZButton.H);
			
			// build the buttons using the data
			for (var i:uint = 0; i < buttonDataArray.length; i++) {
				
				// create the button
				var startButton:ZButton = new BtnOptions(buttonDataArray[i][0],buttonDataArray[i][1],buttonDataArray[i][2]);
				
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
		}
		
		override protected function updateAnimations():void {
			// do nothing
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(BACK_KEY)) {
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
		private function soundReaction():void {
			Glob.soundOn = !Glob.soundOn;
		}
		private function musicReaction():void {
			Glob.musicOn = !Glob.musicOn;
		}
	}
}