package
{
	import org.flixel.*;
	
	public class Glob
	{
		private static var save:FlxSave;
		private static var tmp:Boolean = true;
		private static var loaded:Boolean = false;
		
		public static function get sound():Boolean {
			if (loaded) {
				FlxG.log("get loaded");
				return save.data.sound;
			} else {
				return tmp;
			}
		}
		
		public static function set sound(_sound:Boolean):void {
			if (loaded) {
				FlxG.log("set loaded");
				save.data.sound = _sound;
				save.flush();
			}
			else {
				tmp = _sound;
			}
		}
		
		public static function load():void {
			save = new FlxSave();
			loaded = save.bind("saveData");
			if (loaded && save.data.sound == null) {
				save.data.sound = tmp;
			}
		}
		
		// Internal
		public static const DEBUG_ON:Boolean = true;
		public static var soundOn:Boolean = sound;
		
		// Environmental constants
		public static const GRAV_ACCEL:Number = 888;
		public static const CENT:FlxPoint = new FlxPoint(FlxG.width/2.0,FlxG.height/2.0);
		
		// Player sprite
		//[Embed("assets/sprite_cake.png")] public static const cakeSheet:Class;
		[Embed("assets/sprite_cake_base.png")] public static const cakeBaseSheet:Class;
		[Embed("assets/sprite_cake_head.png")] public static const cakeHeadSheet:Class;
		[Embed("assets/sprite_cake_eyes.png")] public static const cakeEyesSheet:Class;
		[Embed("assets/sprite_cake_feet.png")] public static const cakeFeetSheet:Class;
		[Embed("assets/sprite_balloon.png")] public static const balloonSheet:Class;
		[Embed("assets/sprite_balloon_string.png")] public static const balloonStringSheet:Class;
		
		// Present sprite
		[Embed("assets/sprite_present.png")] public static const presentSheet:Class;
		
		// Flag sprite
		[Embed("assets/sprite_flag.png")] public static const flagSheet:Class;
		
		// Button sprite
		[Embed("assets/button_menu.png")] public static const buttonSheet:Class;
		[Embed("assets/button_cake_middle.png")] public static const buttonCakeMiddleSheet:Class;
		[Embed("assets/button_cake_bottom.png")] public static const buttonCakeBottomSheet:Class;
		[Embed("assets/btn_toggle.png")] public static const btnToggleSheet:Class;
		
		[Embed("assets/sprite_cursor.png")] public static const cursorSheet:Class;
		[Embed("assets/button_exit_hint.png")] public static const exitHintSheet:Class;
		
		// Level
		[Embed("assets/tileset_level.png")] public static const tilesetLevelSheet:Class;
		[Embed("assets/mapCSV_level_000.csv", mimeType = 'application/octet-stream')] public static const level000CSV:Class;
		[Embed("assets/mapCSV_level_001.csv", mimeType = 'application/octet-stream')] public static const level001CSV:Class;
		
		// Titles
		[Embed("assets/title-01.png")] public static const titleSheet:Class;
		
		// Letters
		[Embed("assets/alphabet.png")] public static const alphabetSheet:Class;
		
		// Sounds
		[Embed("assets/title.mp3")] public static const titleMP3:Class;
		public static const titleMusic:FlxSound = new FlxSound().loadEmbedded(titleMP3,true);
		
		// Key presses
		public static function pressed(_keys:Array):Boolean {
			for (var i:uint = 0; i < _keys.length; i++) {
				if (FlxG.keys.pressed(_keys[i])) {
					return true;
				}
			}
			return false;
		}
		public static function justPressed(_keys:Array):Boolean {
			for (var i:uint = 0; i < _keys.length; i++) {
				if (FlxG.keys.justPressed(_keys[i])) {
					return true;
				}
			}
			return false;
		}
		public static function justReleased(_keys:Array):Boolean {
			for (var i:uint = 0; i <_keys.length; i++) {
				if (FlxG.keys.justReleased(_keys[i])) {
					return true;
				}
			}
			return false;
		}
		public static function pressedAfter(_keysPrimary:Array,_keysSecondary:Array):Boolean {
			return pressed(_keysPrimary) && (justPressed(_keysPrimary) || !pressed(_keysSecondary));
		}
		
	}
}