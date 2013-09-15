package
{
	import org.flixel.*;

	public class BtnPause extends ZButton
	{
		private const kAlignment:String = "center";
		private static const kCurseAnim:String = "CURSE";
		private static const kUncurseAnim:String = "UNCURSE";
		private static const kSelectAnim:String = "SELECT";
		
		private var spr:FlxSprite;
		private var text:FlxText;
		
		public function BtnPause(_callback:Function,_label:String,_simpleGraphic:Class=null)
		{
			super(_callback);
			
			spr = new FlxSprite();
			if (_simpleGraphic) {
				spr.loadGraphic(_simpleGraphic,true,false,ZButton.W,ZButton.H);
			} else {
				spr.loadGraphic(Glob.buttonCakeMiddleSheet,true,false,100,50);
			}
			spr.addAnimation(kCurseAnim,[0]);
			spr.addAnimation(kUncurseAnim,[1]);
			spr.addAnimation(kSelectAnim,[2]);
			add(spr);
			
			text = new FlxText(0,0,ZButton.W,_label);
			text.alignment = kAlignment;
			add(text);
		}
		
		override public function curse():void {
			spr.play(kCurseAnim);
			super.curse();
		}
		
		override public function uncurse():void {
			spr.play(kUncurseAnim);
			super.uncurse();
		}
		
		override public function select():void {
			spr.play(kSelectAnim);
			FlxG.log("selected " + text.text);
			super.select();
		}
	}
}