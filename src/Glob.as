package
{
	import org.flixel.*;
	
	public class Glob
	{	
		// Debug
		public static const DEBUG_ON:Boolean = true;
		
		// General
		public static const CENT:FlxPoint = new FlxPoint(FlxG.width/2.0,FlxG.height/2.0);
		
		// Save Data
		private static var save:FlxSave;
		private static var loaded:Boolean = false;
		public static function load():void {
			save = new FlxSave();
			loaded = save.bind("saveData");
			if (loaded && save.data.soundOn == null) {
				save.data.soundOn = soundOnTmp;
			}
			if (loaded && save.data.musicOn == null) {
				save.data.musicOn = musicOnTmp;
			}
		}
		// saving sound on
		private static var soundOnTmp:Boolean = false;
		public static function get soundOn():Boolean {
			if (loaded) {
				return save.data.soundOn;
			} else {
				return soundOnTmp;
			}
		}
		public static function set soundOn(_soundOn:Boolean):void {
			if (loaded) {
				save.data.soundOn = _soundOn;
				save.flush();
			}
			else {
				soundOnTmp = _soundOn;
			}
		}
		// saving music on
		private static var musicOnTmp:Boolean = true;
		public static function get musicOn():Boolean {
			if (loaded) {
				return save.data.musicOn;
			} else {
				return musicOnTmp;
			}
		}
		public static function set musicOn(_musicOn:Boolean):void {
			if (loaded) {
				save.data.musicOn = _musicOn;
				save.flush();
			}
			else {
				soundOnTmp = _musicOn;
			}
		}
		
		// Title State
		
		// Menu State
		[Embed("assets/spr_menu_balloon.png")] public static const menuBalloonSheet:Class;
		
		// Options State
		
		// Controls State
		
		// Credits State
		
		// Map State
		[Embed("assets/spr_map_node.png")] public static const mapNodeSheet:Class;
		[Embed("assets/spr_map_marker.png")] public static const mapMarkerSheet:Class;
		
		// Play State
		// environmental constants
		public static const GRAV_ACCEL:Number = 2222;
		// player
		[Embed("assets/spr_cake_face.png")] public static const cakeFaceSheet:Class;
		[Embed("assets/spr_cake_jaw.png")] public static const cakeJawSheet:Class;
		[Embed("assets/spr_cake_feet.png")] public static const cakeFeetSheet:Class;
		[Embed("assets/spr_cake_eyeL.png")] public static const cakeEyeLSheet:Class;
		[Embed("assets/spr_cake_eyeR.png")] public static const cakeEyeRSheet:Class;
		[Embed("assets/sprite_balloon.png")] public static const balloonSheet:Class;
		[Embed("assets/sprite_balloon_string.png")] public static const balloonStringSheet:Class;
		[Embed("assets/spr_cake_candle.png")] public static const cakeCandleSheet:Class;
		[Embed("assets/spr_cake_candle_flame.png")] public static const cakeCandleFlameSheet:Class;
		
		
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
		
		[Embed("assets/spr_key.png")] public static const keySheet:Class;
		
		// Level
		public static var levelNum:uint = 0;
		[Embed("assets/tileset_level.png")] public static const tilesetLevelSheet:Class;
		[Embed("assets/mapCSV_level_000.csv", mimeType = 'application/octet-stream')] public static const level000CSV:Class;
		[Embed("assets/mapCSV_level_001.csv", mimeType = 'application/octet-stream')] public static const level001CSV:Class;
		[Embed("assets/mapCSV_level_002.csv", mimeType = 'application/octet-stream')] public static const level002CSV:Class;
		public static var levels:Array = [[level000CSV,"name000",1,200],
									      [level001CSV,"name001",3,180],
										  [level002CSV,"name002",15,120],
										  ];
		public static function get levelCSV():Class {return levels[levelNum][0];}
		public static function levelName(_levelNum:uint):String {return levels[_levelNum][1];}
		public static function levelGoal(_levelNum:uint):uint {return levels[_levelNum][2];}
		public static function get goal():uint {return levelGoal(levelNum);}
		public static function get levelTime():uint {return levels[levelNum][3];}
		public static function get nextLevelNum():uint {return (levelNum + 1 < levels.length) ? levelNum + 1 : levelNum;}
		
		// Titles
		[Embed("assets/title-01.png")] public static const titleSheet:Class;
		[Embed("assets/spr_controls.png")] public static const controlsSheet:Class;
		[Embed("assets/spr_credits.png")] public static const creditsSheet:Class;
		
		// Letters
		[Embed("assets/alphabet.png")] public static const alphabetSheet:Class;
		
		// Music
		[Embed("assets/title.mp3")] public static const titleMP3:Class;
		public static const titleMusic:FlxSound = new FlxSound().loadEmbedded(titleMP3,true);
		[Embed("assets/menu.mp3")] public static const menuMP3:Class;
		public static const menuMusic:FlxSound = new FlxSound().loadEmbedded(menuMP3,true);
		[Embed("assets/level.mp3")] public static const levelMP3:Class;
		public static const levelMusic:FlxSound = new FlxSound().loadEmbedded(levelMP3,true);
		
		[Embed("assets/sfx_curse.mp3")] public static const curseSFX:Class;
		public static const curseSound:FlxSound = new FlxSound().loadEmbedded(curseSFX);
		[Embed("assets/sfx_death.mp3")] public static const deathSFX:Class;
		public static const deathSound:FlxSound = new FlxSound().loadEmbedded(deathSFX);
		[Embed("assets/sfx_present_get.mp3")] public static const presentGetSFX:Class;
		public static const presentGetSound:FlxSound = new FlxSound().loadEmbedded(presentGetSFX);
		[Embed("assets/sfx_select.mp3")] public static const selectSFX:Class;
		public static const selectSound:FlxSound = new FlxSound().loadEmbedded(selectSFX);
		// Sounds
		[Embed("assets/sfx_jump_01.mp3")] public static const jump01SFX:Class;
		public static const jump01Sound:FlxSound = new FlxSound().loadEmbedded(jump01SFX);
		[Embed("assets/sfx_jump_02.mp3")] public static const jump02SFX:Class;
		public static const jump02Sound:FlxSound = new FlxSound().loadEmbedded(jump02SFX);
		[Embed("assets/sfx_jump_03.mp3")] public static const jump03SFX:Class;
		public static const jump03Sound:FlxSound = new FlxSound().loadEmbedded(jump03SFX);
		[Embed("assets/sfx_jump_04.mp3")] public static const jump04SFX:Class;
		public static const jump04Sound:FlxSound = new FlxSound().loadEmbedded(jump04SFX);
		public static const jumpSounds:Array = [jump01Sound,jump02Sound,jump03Sound,jump04Sound];
		
		public static function get jumpSound():FlxSound {
			var index:uint = Math.random()*jumpSounds.length;
			return jumpSounds[index];
		}
		
		[Embed("assets/sfx_step01.mp3")] public static const step01SFX:Class;
		public static const step01Sound:FlxSound = new FlxSound().loadEmbedded(step01SFX);
		[Embed("assets/sfx_step02.mp3")] public static const step02SFX:Class;
		public static const step02Sound:FlxSound = new FlxSound().loadEmbedded(step02SFX);
		[Embed("assets/sfx_step03.mp3")] public static const step03SFX:Class;
		public static const step03Sound:FlxSound = new FlxSound().loadEmbedded(step03SFX);
		[Embed("assets/sfx_step04.mp3")] public static const step04SFX:Class;
		public static const step04Sound:FlxSound = new FlxSound().loadEmbedded(step04SFX);
		public static const stepSounds:Array = [step01Sound,jump02Sound,jump03Sound,step04Sound];
		
		public static function get stepSound():FlxSound {
			var index:uint = Math.random()*stepSounds.length;
			return stepSounds[index];
		}
		
		// Key Press Macros
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
		
		// centering
		public static function centerNodeX(_node:FlxSprite):void {
			_node.x = Glob.CENT.x - _node.width/2.0;
		}
		public static function centerNodeY(_node:FlxSprite):void {
			_node.y = Glob.CENT.y - _node.height/2.0;
		}
		public static function centerNode(_node:FlxSprite):void {
			centerNodeX(_node);
			centerNodeY(_node);
		}
		
		public static function bottomNode(_node:FlxSprite):void {
			_node.y = FlxG.height - _node.height;
		}
		
		public static function topNode(_node:FlxSprite):void {
			_node.y = _node.height;
		}
		
		public static function leftNode(_node:FlxSprite):void {
			_node.x = 0;
		}
		
		public static function rightNode(_node:FlxSprite):void {
			_node.x = FlxG.width - _node.width;
		}
		
	}
}