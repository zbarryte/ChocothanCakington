package
{
	import org.flixel.*;
	
	public class PauseGroup extends ZButtonGroup
	{	
		//private const PAUSE_KEY:Array = ["ENTER"];
		
		public function PauseGroup()
		{
			super(0,0,ZButton.H/2.0);
			//Glob.centerNode(this);
			
			visible = false;
			//toggle();
			
			/*
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y-ZButton.H-spacing,Glob.buttonCakeMiddleSheet,continueReaction,"continue",ZButton.CURSED));
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y,Glob.buttonCakeMiddleSheet,restartReaction,"restart"));
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y+ZButton.H+spacing,Glob.buttonCakeBottomSheet,exitToMenuReaction,"exit to menu"));
			*/
		}
		
		/*
		// Button Reactions
		private function continueReaction():void {
			toggle();
		}
		private function restartReaction():void {
			FlxG.switchState(new StPlay());
		}
		private function exitToMenuReaction():void {
			FlxG.switchState(new StMap());
		}
		*/
		/*
		public function isOn():Boolean {
			return visible;
		}
		*/
		/*
		public function toggle():void {
			visible = !visible;
		}*/
		
		/*
		override public function reset():void {
			super.reset();
			toggle();
		}*/
		
		/*
		override public function update():void {
			if (isOn()) {
				super.update();
			}
			if (Glob.justPressed(PAUSE_KEY)) {
				//reset();
			}
		}*/
		
		/*
		override public function draw():void {
			for (var i:uint = children.length-1; i >= 0; i--) {
				//members[i].draw();
				children.members[i].draw();
			}
		}
		*/
	}
}