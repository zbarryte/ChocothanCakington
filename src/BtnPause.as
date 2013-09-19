package
{
	import org.flixel.*;

	public class BtnPause extends ZButton
	{
		private const kAlignment:String = "center";
		private static const kCurseAnim:String = "CURSE";
		private static const kUncurseAnim:String = "UNCURSE";
		private static const kSelectAnim:String = "SELECT";
		
		private var text:FlxText;
		
		public function BtnPause(_callback:Function,_label:String,_simpleGraphic:Class=null)
		{
			super(_callback);
			
			var ww:Number = 100;
			
			if (_simpleGraphic) {
				//loadGraphic(_simpleGraphic,true,false,ww,H);
			} else {
				//loadGraphic(Glob.buttonCakeMiddleSheet,true,false,ww,H);
			}
			//addAnimation(kCurseAnim,[0]);
			//addAnimation(kUncurseAnim,[1]);
			//addAnimation(kSelectAnim,[2]);
			
			text = new FlxText(0,0,ww,_label);
			text.alignment = kAlignment;
			add(text);
		}
		
		override public function curse():void {
			//play(kCurseAnim);
			text.color = 0xffffffff;
			text.size = 14;
			super.curse();
		}
		
		override public function uncurse():void {
			//play(kUncurseAnim);
			text.color = 0x88888888;
			text.size = 9;
			super.uncurse();
		}
		
		override public function select():void {
			//play(kSelectAnim);
			text.color = 0xaaaaaaaa;
			super.select();
		}
	}
}