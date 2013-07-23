package
{
	import org.flixel.*;
	
	public class Glob
	{
		// Internal
		public static const DEBUG_ON:Boolean = true;
		
		// Environmental constants
		public static const GRAV_ACCEL:Number = 888;
		
		// Player sprite
		[Embed("assets/sprite_cake.png")] public static var cakeSheet:Class;
		[Embed("assets/sprite_cake_eyes.png")] public static var cakeEyesSheet:Class;
		[Embed("assets/sprite_balloon.png")] public static var balloonSheet:Class;
		[Embed("assets/sprite_balloon_string.png")] public static var balloonStringSheet:Class;
		
		// Present sprites
		[Embed("assets/sprite_present.png")] public static var presentSheet:Class;
		
		// Level
		[Embed("assets/tileset_level.png")] public static var tilesetLevelSheet:Class;
		[Embed("assets/mapCSV_level_000.csv", mimeType = 'application/octet-stream')] public static const levelCSV:Class;
		
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