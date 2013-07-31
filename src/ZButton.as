package 
{
	import org.flixel.*;
	
	public class ZButton extends FlxSprite
	{
		public static const W:Number = 100;
		public static const H:Number = 50;
		
		public var name:String; // can be used for debugging
		private var callback:Function; // called when button is selected
		private var label:FlxText; // appears on button
		
		private var state:String;
		// state string corresponds to animation
		public static const UNCURSED:String = "UNCURSED";
		public static const CURSED:String = "CURSED";
		public static const SELECTED:String = "SELECTED";
		
		public function ZButton(_x:Number=0,_y:Number=0,_graphic:Class=null,_callback:Function=null,_name:String="no name",_startState:String=ZButton.UNCURSED)
		{
			super(_x,_y);
			loadGraphic(_graphic,true,false,W,H,true);
			
			name = _name;
			callback = _callback;
			
			addAnimation(UNCURSED,[0]);
			addAnimation(CURSED,[1]);
			addAnimation(SELECTED,[2]);
			
			switchState(_startState);
			
			label = new FlxText(x+width/4.0,y+height/4.0,W,name);
			
			label.scrollFactor = new FlxPoint(0,0);
			scrollFactor = new FlxPoint(0,0);
		}
		
		private function switchState(_state:String):void {
			state = _state;
			play(state);
			//FlxG.log(name + " in state: " + state);
		}
		
		public function stateIs(_state:String):Boolean {
			return (state == _state);
		}
		
		public function curse():void {
			label.color = 0xff0000;
			switchState(CURSED);
		}
		
		public function uncurse():void {
			label.color = 0xffffff;
			switchState(UNCURSED);
		}
		
		public function select():void {
			switchState(SELECTED);
		}
		
		override public function update():void {
			super.update();
			if (stateIs(SELECTED) && finished) {
				callback();
				switchState(ZButton.CURSED);
			}
		}
		
		override public function draw():void {
			super.draw();
			label.draw();
		}
	}
}