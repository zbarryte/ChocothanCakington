package
{
	import org.flixel.*;
	import org.osmf.events.TimeEvent;
	
	public class StMenu extends ZState
	{
		private const BACK_KEY:Array = ["ESCAPE"];
		private const SELECT_KEY:Array = ["SPACE","ENTER"];
		private const CURSE_FORWARD_KEY:Array = ["DOWN","RIGHT"];
		private const CURSE_BACK_KEY:Array = ["UP","LEFT"];
		
		private var buttonGroup:ZButtonGroup;
		private var cursor:ZNode;
		private var cursorTimer:ZTimedEvent;
		
		private var cursorTime:Number = 0;
		private const CURSOR_PERIOD:Number = 0.33;
		private var cursorDir:int = 1;
		private var cursorSize:Number = 0.022;
		
		private var exitHint:FlxSprite;
		private var selectHint:FlxSprite;
		
		override public function create():void {
			// color background
			FlxG.bgColor = 0xff222222;
			super.create();
			resetCursor();
		}
		
		override public function createObjects():void {
			
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
				var startButton:ZButton = new ZTextButton(buttonDataArray[i][0],buttonDataArray[i][1]);
				
				// add the button to the button group
				buttonGroup.addButton(startButton);
			}
			
			// add the button group to the state
			add(buttonGroup);
			
			cursor = new ZNode();
			cursor.alpha = 0;
			var curs:ZNode = new ZNode();
			curs.loadGraphic(Glob.cursorSheet);
			cursor.add(curs);
			add(cursor);
			cursorTimer = 
				new ZTimedEvent(CURSOR_PERIOD,
								function():void {
									cursorDir *= -1;
								},
								true,
								true,
								function():void {
									cursor.scale.x += cursorDir*cursorSize;
									cursor.scale.y -= cursorDir*cursorSize;
									cursor.xOffset += cursorDir*1.22;
								},
								function():void {
									cursorDir = 1;
									cursor.scale.x = 1;
									cursor.scale.y = 1;
									cursor.xOffset = buttonGroup.x-ZButton.W/3.5;
									cursor.yOffset = buttonGroup.getCursed().y - cursor.height/2.0 + ZButton.H/2.0;
								});
			add(cursorTimer);
			
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
		}
		
		override protected function updateAnimations():void {
			//pulseCursor();
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(BACK_KEY)) {
				goBack();
			} else if (Glob.justPressed(CURSE_FORWARD_KEY)) {
				buttonGroup.curseFoward();
				resetCursor();
			} else if (Glob.justPressed(CURSE_BACK_KEY)) {
				buttonGroup.curseBack();
				resetCursor();
			} else if (Glob.justPressed(SELECT_KEY)) {
				buttonGroup.select();
			}
		}
		
		override protected function updatePause():void {
			
		}
		
		public function resetCursor():void {
			cursorTimer.stop();
			cursorTimer.start();
		}
		
		// Button Reactions
		private function startReaction():void {
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
	}
}