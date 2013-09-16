package
{
	import org.flixel.*;
	
	public class StControls extends ZState
	{
		private const ESCAPE_KEY:Array = ["ESCAPE"];
		
		private var exitHint:FlxSprite;
		
		override public function create():void {
			FlxG.bgColor = 0xff555555;
			super.create();
		}
		
		override public function createObjects():void {
			
			var _node:ZNode = new ZNode(Glob.CENT.x,Glob.CENT.y,Glob.controlsSheet);
			_node.x -= _node.width/2.0;
			_node.y -= _node.height/2.0;
			add(_node);
			
			var exitHint:HintButton = new HintButton("Esc","back");
			Glob.bottomNode(exitHint);
			Glob.leftNode(exitHint);
			add(exitHint);
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(ESCAPE_KEY)) {
				goBack();
			}
		}
	}
}