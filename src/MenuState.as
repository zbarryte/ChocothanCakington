package
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		private const BACK_KEY:Array = ["ESCAPE"];
		private const SELECT_KEY:Array = ["SPACE","ENTER"];
		private const CURSE_FORWARD_KEY:Array = ["DOWN","RIGHT"];
		private const CURSE_BACK_KEY:Array = ["UP","LEFT"];
		
		private var buttonGroup:ZGroup;
		
		override public function create():void {
			add(new FlxText(FlxG.width/2.0,FlxG.height/2.0,100,"Menu State"));
			
			var _spacing:Number = 100;
			buttonGroup = new ZGroup();
			buttonGroup.add(new ZButton(FlxG.width/2.0,0*_spacing,Glob.buttonSheet,playReaction,"play",ZButton.CURSED));
			buttonGroup.add(new ZButton(FlxG.width/2.0,1*_spacing,Glob.buttonSheet,optionsReaction,"options"));
			buttonGroup.add(new ZButton(FlxG.width/2.0,2*_spacing,Glob.buttonSheet,controlsReaction,"controls"));
			add(buttonGroup);
		}
		
		override public function update():void {
			super.update();
			if (Glob.justPressed(BACK_KEY)) {
				FlxG.switchState(new TitleState());
			}
			if (Glob.justPressed(SELECT_KEY)) {
				
			}	
		}
		
		// Button Reactions
		private function playReaction():void {
			FlxG.switchState(new MapState());
		}
		private function optionsReaction():void {
			FlxG.log("options pressed");
		}
		private function controlsReaction():void {
			FlxG.log("control pressed");
		}
	}
}