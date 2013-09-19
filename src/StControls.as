package
{
	import org.flixel.*;
	
	public class StControls extends ZState
	{
		private const ESCAPE_KEY:Array = ["ESCAPE"];
		
		private var exitHint:FlxSprite;
		private var width:Number;
		
		override public function create():void {
			//FlxG.bgColor = 0xff555555;
			super.create();
		}
		
		override public function createObjects():void {
			
			var _node:ZNode = new ZNode(Glob.CENT.x,Glob.CENT.y,Glob.controlsSheet);
			_node.scale.x = 1.5;
			_node.scale.y = 1.5;
			_node.x -= _node.width/2.0;
			_node.y -= _node.height/2.0;
			add(_node);
			
			width = _node.width;
			
			var iconMove:ZNode = new ZNode();
			iconMove.loadGraphic(Glob.iconMoveSheet);
			add(iconMove);
			iconMove.x = _node.x + 0*_node.width/3.0 - iconMove.width/2.0;
			iconMove.y = _node.y + _node.height/4.0;
			
			var iconJump:ZNode = new ZNode();
			iconJump.loadGraphic(Glob.iconJumpSheet);
			add(iconJump);
			iconJump.x = _node.x + 1*_node.width/3.0 - iconJump.width/2.0;
			iconJump.y = _node.y + _node.height/4.0;
			
			var jumpKey:ZNode = keyWithString("space");
			jumpKey.x = iconJump.x-width/2.0+jumpKey.width*2;
			jumpKey.y = iconJump.y;
			add(jumpKey);
			
			var iconRun:ZNode = new ZNode();
			iconRun.loadGraphic(Glob.iconRunSheet);
			add(iconRun);
			iconRun.x = _node.x + 2*_node.width/3.0 - iconRun.width/2.0;
			iconRun.y = _node.y + _node.height/4.0;
			
			var runKey:ZNode = keyWithString("shift");
			runKey.x = iconRun.x-width/2.0+runKey.width*2;
			runKey.y = iconRun.y;
			add(runKey);
			
			var iconBalloon:ZNode = new ZNode();
			iconBalloon.loadGraphic(Glob.iconBalloonSheet);
			add(iconBalloon);
			iconBalloon.x = _node.x + 3*_node.width/3.0 - iconBalloon.width/2.0;
			iconBalloon.y = _node.y + _node.height/4.0 + 22;
			
			var balloonKey:ZNode = keyWithString("space");
			balloonKey.x = iconBalloon.x-width/2.0+balloonKey.width*2;
			balloonKey.y = iconRun.y;
			add(balloonKey);
			
			var label:FlxText = new FlxText(0,0,width,"in air");
			label.alignment = "center";
			add(label);
			label.color = 0xff444444;
			label.x = balloonKey.x;
			label.y = balloonKey.y-label.height/2.0;
			
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
		
		private function keyWithString(_str:String):ZNode
		{
			var _node:ZNode = new ZNode();
			
			var _keyImg:FlxSprite = new FlxSprite();
			_keyImg.loadGraphic(Glob.keySheet);
			_node.add(_keyImg);
			
			var _keyString:String = _str;
			var kCharLength:uint = 10;
			
			var _keyTextWidth:Number = _keyString.length*kCharLength;
			_keyImg.scale.x = _keyTextWidth/_keyImg.width;
			_keyImg.x = width/2.0-_keyImg.width/2.0;
			_keyImg.y = 8;
			
			var _keyText:FlxText = new FlxText(width/2.0-_keyTextWidth/2.0,_keyImg.y+1,_keyTextWidth,"   "+_keyString+"   ");
			_keyText.alignment = "center";
			_node.add(_keyText);
			_keyText.color = 0xff444444;
			
			return _node;
		}
	}
}