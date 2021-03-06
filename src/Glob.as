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
			if (loaded && save.data.level01Status == null) {
				save.data.level01Status = level01StatusTmp;
			}
			if (loaded && save.data.level02Status == null) {
				save.data.level02Status = level02StatusTmp;
			}
			if (loaded && save.data.level03Status == null) {
				save.data.level03Status = level03StatusTmp;
			}
			if (loaded && save.data.levelPresentsCollected == null) {
				save.data.levelPresentsCollected = levelPresentsCollectedTmp;
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
		
		// saving number of presents collected in each level
		private static var levelPresentsCollectedTmp:Array = [0,0,0];
		public static function get levelPresentsCollected():Array {
			if (loaded) {
				return save.data.levelPresentsCollected;
			} else {
				return levelPresentsCollectedTmp;
			}
		}
		public static function set levelPresentsCollected(_levelPresentsCollected:Array):void {
			if (loaded) {
				save.data.levelPresentsCollected = _levelPresentsCollected;
			} else {
				levelPresentsCollected = _levelPresentsCollected;
			}
		}
		
		
		public static const kLocked:String = "LOCKED";
		public static const kBeaten:String = "BEATEN";
		public static const kUnlocked:String = "UNLOCKED";
		// saving level lockedness
		private static var level01StatusTmp:String = kUnlocked;
		private static var level02StatusTmp:String = kLocked;
		private static var level03StatusTmp:String = kLocked;
		public static function get level01Status():String {
			if (loaded) {
				return save.data.level01Status;
			} else {
				return level01StatusTmp;
			}
		}
		public static function set level01Status(_level01Status:String):void {
			if (loaded) {
				save.data.level01Status = _level01Status;
				save.flush();
			} else {
				level01Status = _level01Status;
			}
		}
		public static function level01StatusFn():String {
			return level01Status;
		}
		public static function level01SetStatusFn(_status:String):void {
			level01Status = _status;
		}
		public static function get level02Status():String {
			if (loaded) {
				return save.data.level02Status;
			} else {
				return level02StatusTmp;
			}
		}
		public static function set level02Status(_level02Status:String):void {
			if (loaded) {
				save.data.level02Status = _level02Status;
				save.flush();
			} else {
				level02Status = _level02Status;
			}
		}
		public static function level02StatusFn():String {
			return level02Status;
		}
		public static function level02SetStatusFn(_status:String):void {
			level02Status = _status;
		}
		public static function get level03Status():String {
			
			if (loaded) {
				return save.data.level03Status;
			} else {
				return level03StatusTmp;
			}
		}
		public static function set level03Status(_level03Status:String):void {
			if (loaded) {
				save.data.level03Status = _level03Status;
				save.flush();
			} else {
				level03Status = _level03Status;
			}
		}
		public static function level03StatusFn():String {
			return level03Status;
		}
		public static function level03SetStatusFn(_status:String):void {
			level03Status = _status;
		}
		
		public static function clearAllData():void {
			level01Status = level01StatusTmp;
			level02Status = level02StatusTmp;
			level03Status = level03StatusTmp;
			levelPresentsCollected = levelPresentsCollectedTmp;
			levelNum = 0;
		}
		
		public static function cheat():void {
			level01Status = kBeaten;
			level02Status = kBeaten;
			level03Status = kBeaten;
			for (var i:uint = 0; i < levels.length; i++) {
				levelPresentsCollected[i] = levelMaxPres(i);
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
		[Embed("assets/spr_cake_death_anim.png")] public static const cakeDeathAnimSheet:Class;
		
		// icons
		[Embed("assets/spr_icon_move.png")] public static const iconMoveSheet:Class;
		[Embed("assets/spr_icon_jump.png")] public static const iconJumpSheet:Class;
		[Embed("assets/spr_icon_run.png")] public static const iconRunSheet:Class;
		[Embed("assets/spr_icon_balloon.png")] public static const iconBalloonSheet:Class;
		
		
		[Embed("assets/spr_alpha.png")] public static const alphaSheet:Class;
		
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
		
		[Embed("assets/spr_hint_move.png")] public static const hintMoveSheet:Class;
		[Embed("assets/spr_hint_jump.png")] public static const hintJumpSheet:Class;
		[Embed("assets/spr_hint_balloon.png")] public static const hintBalloonSheet:Class;
		
		[Embed("assets/spr_key.png")] public static const keySheet:Class;
		
		// Acid
		[Embed("assets/spr_acid_fall.png")] public static const acidFallingSheet:Class;
		[Embed("assets/spr_acid_pool.png")] public static const acidPoolingSheet:Class;
		[Embed("assets/spr_acid_sit.png")] public static const acidSitSheet:Class;
		[Embed("assets/spr_acid_bubble.png")] public static const acidBubbleSheet:Class;
		
		// Level
		public static var levelNum:uint = 0;
		[Embed("assets/tileset_level.png")] public static const tilesetLevelSheet:Class;
		[Embed("assets/tileset_level_front.png")] public static const cosmeticTilesetLevelSheet:Class;
		[Embed("assets/mapCSV_level_000.csv", mimeType = 'application/octet-stream')] public static const level000CSV:Class;
		[Embed("assets/mapCSV_level_000-front.csv", mimeType = 'application/octet-stream')] public static const level000FrontCSV:Class;
		[Embed("assets/mapCSV_level_000-back.csv", mimeType = 'application/octet-stream')] public static const level000BackCSV:Class;
		[Embed("assets/mapCSV_level_001.csv", mimeType = 'application/octet-stream')] public static const level001CSV:Class;
		[Embed("assets/mapCSV_level_001-front.csv", mimeType = 'application/octet-stream')] public static const level001FrontCSV:Class;
		[Embed("assets/mapCSV_level_001-back.csv", mimeType = 'application/octet-stream')] public static const level001BackCSV:Class;
		[Embed("assets/mapCSV_level_002.csv", mimeType = 'application/octet-stream')] public static const level002CSV:Class;
		[Embed("assets/mapCSV_level_002-front.csv", mimeType = 'application/octet-stream')] public static const level002FrontCSV:Class;
		[Embed("assets/mapCSV_level_002-back.csv", mimeType = 'application/octet-stream')] public static const level002BackCSV:Class;
		
		public static var levels:Array = [[level000CSV,"name000",1,200,level000FrontCSV,level01StatusFn,level01SetStatusFn,1,level000BackCSV],
									      [level001CSV,"name001",3,180,level001FrontCSV,level02StatusFn,level02SetStatusFn,4,level001BackCSV],
										  [level002CSV,"name002",15,120,level002FrontCSV,level03StatusFn,level03SetStatusFn,20,level002BackCSV],
										  ];
		public static function get levelCSV():Class {return levels[levelNum][0];}
		public static function get cosmeticLevelCSV():Class {return levels[levelNum][4];}
		public static function levelName(_levelNum:uint):String {return levels[_levelNum][1];}
		public static function levelGoal(_levelNum:uint):uint {return levels[_levelNum][2];}
		public static function get goal():uint {return levelGoal(levelNum);}
		public static function get levelTime():uint {return levels[levelNum][3];}
		public static function levelTimeWith(_levelNum:uint):uint {return levels[_levelNum][3];}
		public static function get nextLevelNum():uint {return (levelNum + 1 < levels.length) ? levelNum + 1 : levelNum;}
		public static function levelStatus(_levelNum:uint):String {return levels[_levelNum][5]();}
		public static function setLevelStatusForLevelNum(_levelNum:uint,_status:String):void {levels[_levelNum][6](_status);}
		public static function getLevelPresentsCollectedRecord(_levelNum:uint):uint {return levelPresentsCollected[_levelNum];}
		public static function setLevelPresentsCollectedRecord(_levelNum:uint,_record:uint):void {levelPresentsCollected[_levelNum]=_record;}
		public static function levelMaxPres(_levelNum:uint):uint {return levels[_levelNum][7];}
		public static function get bkgLevelCSV():Class {return levels[levelNum][8];}
		
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
		[Embed("assets/intro.mp3")] public static const introMP3:Class;
		public static const introMusic:FlxSound = new FlxSound().loadEmbedded(introMP3,true);
		
		
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