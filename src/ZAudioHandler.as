package
{
	import org.flixel.*;
	
	public class ZAudioHandler
	{
		private static var sounds:FlxGroup = new FlxGroup();
		private static var music:FlxGroup = new FlxGroup();
		
		public static function addSound(_sound:FlxSound,_isAutomatic:Boolean=true):void {
			sounds.add(_sound);
			if (_isAutomatic) {_sound.play();}
		}
		
		public static function addMusic(_music:FlxSound,_isAutomatic:Boolean=true):void {
			music.add(_music);
			if (_isAutomatic) {_music.play();}
		}
		
		public static function clearSounds():void {
			for (var i:uint = 0; i < sounds.length; i++) {
				sounds.members[i].stop();
			}
			sounds.clear();
		}
		
		public static function clearMusic():void {
			for (var i:uint = 0; i < music.length; i++) {
				music.members[i].stop();
			}
			music.clear();
		}
		
		public static function clearAll():void {
			clearSounds();
			clearMusic();
		}
		
		public static function update():void {
			for (var i:uint = 0; i < sounds.length; i++) {
				sounds.members[i].volume = Glob.soundOn;
			}
			for (var j:uint = 0; j < music.length; j++) {
				music.members[j].volume = Glob.musicOn;
			}
		}
		
		public static function removeSound(_sound:FlxSound):void {
			_sound.stop();
			sounds.remove(_sound);
		}
		
		public static function removeMusic(_music:FlxSound):void {
			_music.stop();
			music.remove(_music);
		}
	}
}