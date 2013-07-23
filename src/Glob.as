package
{
	import org.flixel.*;
	
	public class Glob
	{
		// Internal
		public static const DEBUG_ON:Boolean = true;
		
		// Environment
		public static const GRAV_ACCEL:Number = 888;
		
		// Player sprite
		[Embed("assets/sprite_cake.png")] public static var cakeSheet:Class;
		[Embed("assets/sprite_cake_eyes.png")] public static var cakeEyesSheet:Class;
		
		// Presents
		[Embed("assets/sprite_present.png")] public static var presentSheet:Class;
		
		// Level
		[Embed("assets/tileset_level.png")] public static var tilesetLevelSheet:Class;
		[Embed("assets/mapCSV_level_000.csv", mimeType = 'application/octet-stream')] public static const levelCSV:Class;
	}
}