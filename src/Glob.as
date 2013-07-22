package
{
	import org.flixel.*;
	
	public class Glob
	{
		public static const DEBUG_ON:Boolean = true;
		
		public static const GRAV_ACCEL:Number = 888;
		
		[Embed("assets/sprite_cake.png")] public static var cakeSheet:Class;
		[Embed("assets/sprite_cake_eyes.png")] public static var cakeEyesSheet:Class;
		
		[Embed("assets/tileset_level.png")] public static var tilesetLevelSheet:Class;
		[Embed("assets/mapCSV_level_000.csv", mimeType = 'application/octet-stream')] public static const levelCSV:Class;
	}
}