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
			
			W = 100;
			
			if (_simpleGraphic) {
				loadGraphic(_simpleGraphic,true,false,W,H);
			} else {
				loadGraphic(Glob.buttonCakeMiddleSheet,true,false,W,H);
			}
			addAnimation(kCurseAnim,[0]);
			addAnimation(kUncurseAnim,[1]);
			addAnimation(kSelectAnim,[2]);
			
			text = new FlxText(0,0,width,_label);
			text.alignment = kAlignment;
			add(text);
		}
		
		override public function curse():void {
			play(kCurseAnim);
			super.curse();
		}
		
		override public function uncurse():void {
			play(kUncurseAnim);
			super.uncurse();
		}
		
		override public function select():void {
			play(kSelectAnim);
			super.select();
		}
	}
}