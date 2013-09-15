package
{
	import org.flixel.*;
	
	public class StPlay extends ZState
	{
		private const kLeftKey:Array = ["LEFT"];
		private const kRightKey:Array = ["RIGHT"];
		private const kJumpKey:Array = ["SPACE","UP","X"];
		private const kRunKey:Array = ["SHIFT","Z"];
		private const kTogglePauseKey:Array = ["P","ENTER"];
		
		private const kCurseForwardKey:Array = ["RIGHT","DOWN"];
		private const kCurseBackKey:Array = ["LEFT","UP"];
		private const kSelectKey:Array = ["SPACE"];
		
		private const SPAWN_PLAYER:Array = [2];
		private const SPAWN_PRESENT:Array = [3];
		private const SPAWN_FLAG:Array = [4];
		private const SPAWN_DEATHTOUCH:Array = [5];
		
		private var player:SprCake;
		private var presentGroup:FlxGroup;
		private var level:FlxTilemap;
		private var flag:FlxSprite;
		
		private var presentsCollected:uint;
		private var presentsTotal:uint;
		private var presentsCollectedDisplay:FlxText;
		
		private var timeDisplay:FlxText;
		
		private var HUD:FlxGroup;
		
		private var pauseGroup:PauseGroup;
		
		private var timeRemaining:Number;
				
		override public function create():void {
			FlxG.bgColor = 0xff004400;
			super.create();
			FlxG.worldBounds = new FlxRect(0, 0, level.width,level.height);
			FlxG.camera.bounds = FlxG.worldBounds;
			FlxG.camera.follow(player,FlxCamera.STYLE_PLATFORMER);
		}
		
		override public function createObjects():void {
			
			timeRemaining = 600;
			
			// Info
			presentsCollected = 0;
			
			// Level
			level = new FlxTilemap().loadMap(new Glob.levelCSV,Glob.tilesetLevelSheet,32,32);
			add(level);
			
			// Death Touch
			setCallbackFromSpawn(SPAWN_DEATHTOUCH,function():void {playerDies();},level,!Glob.DEBUG_ON);
						
			// Flag
			flag = groupFromSpawn(SPAWN_FLAG,SprFlag,level).members[0];
			add(flag);
			
			// Presents
			presentGroup = groupFromSpawn(SPAWN_PRESENT,SprPresent,level);
			presentsTotal = presentGroup.length;
			add(presentGroup);
			
			// Player
			player = groupFromSpawn(SPAWN_PLAYER,SprCake,level).members[0];
			add(player);
			
			/*
			FlxG.worldBounds = new FlxRect(0, 0, level.width,level.height);
			FlxG.camera.bounds = FlxG.worldBounds;
			FlxG.camera.follow(player,FlxCamera.STYLE_PLATFORMER);
			*/
			
			// HUD
			HUD = new FlxGroup;
			presentsCollectedDisplay = new FlxText(0,0,100,"You've collected " + presentsCollected + " of " + presentsTotal + " presents!");
			presentsCollectedDisplay.scrollFactor = new FlxPoint(0,0);
			HUD.add(presentsCollectedDisplay);
			timeDisplay = new FlxText(FlxG.width-100,0,100,""+int(timeRemaining)+"");
			timeDisplay.scrollFactor = new FlxPoint(0,0);
			timeDisplay.size = 10;
			HUD.add(timeDisplay);
			
			add(HUD);
			
			// Pause
			pauseGroup = new PauseGroup();
			//pauseGroup.x = Glob.CENT.x;
			/*
			pauseGroup.x = Glob.CENT.x-ZButton.W/2.0;
			pauseGroup.y = FlxG.height/5;*/
			
			//pauseGroup.x = 100;
			//pauseGroup.y = 100;
			
			pauseGroup.addButton(new BtnPause(resume,"continue"));
			pauseGroup.addButton(new BtnPause(refresh,"restart"));
			pauseGroup.addButton(new BtnPause(function():void {goTo(StControls);},"controls"));
			pauseGroup.addButton(new BtnPause(goBack,"go back"));//,Glob.buttonCakeBottomSheet));
			add(pauseGroup);
			
			pauseGroup.scrollFactor.x = 0;
			pauseGroup.scrollFactor.y = 0;
		}
		
		override protected function updateAnimations():void {
			FlxG.collide(player,level);
			
			var _present:SprPresent = presentOverlappedByPlayer();
			if (_present) {
				removePresent(_present);
			}
			
			timeRemaining -= FlxG.elapsed;
			timeDisplay.text = ""+int(timeRemaining)+"";
			if (timeRemaining < 0) {
				playerDies();
			}
			
			if (player.overlaps(flag)) {
				completeLevel();
			}
		}
		
		override protected function updateControls():void {
			// move the player left and right
			if (Glob.pressedAfter(kLeftKey,kRightKey)) {
				player.moveLeft();
			} if (Glob.pressedAfter(kRightKey,kLeftKey)) {
				player.moveRight();
			}
			// jump or deploy the balloon
			if (Glob.justPressed(kJumpKey)) {
				player.jump();
			} else if (Glob.pressed(kJumpKey)) {
				player.launchBalloon();
			} else if (Glob.justReleased(kJumpKey)) {
				player.fall();
			}
			// add some speed to movement
			if (Glob.pressed(kRunKey)) {
				player.run();
			}
			
			if (Glob.justPressed(kTogglePauseKey)) {
				pauseGroup.visible = true;
				pause();
			}
		}
		
		override protected function updatePause():void {
						
			if (Glob.justPressed(kCurseForwardKey)) {
				pauseGroup.curseFoward();
			}
			if (Glob.justPressed(kCurseBackKey)) {
				pauseGroup.curseBack();
			}
			if (Glob.justPressed(kSelectKey)) {
				pauseGroup.select();
			}
			if (Glob.justPressed(kTogglePauseKey)) {
				pauseGroup.visible = false;
				resume();
			}
		}
		
		private function groupFromSpawn(_spawn:Array,_class:Class,_map:FlxTilemap,_hide:Boolean=true):FlxGroup {
			var _group:FlxGroup = new FlxGroup();
			for (var i:uint = 0; i <_spawn.length; i++) {
				var _array:Array = _map.getTileInstances(_spawn[i]);
				if (_array) {
					for (var j:uint = 0; j < _array.length; j++) {
						var _point:FlxPoint = pointForTile(_array[j],_map);
						_group.add(new _class(_point.x,_point.y));
						if (_hide) {
							_map.setTileByIndex(_array[j],0);
						}
					}
				}
			}
			return _group;
		}
		
		private function setCallbackFromSpawn(_spawn:Array,_callback:Function,_map:FlxTilemap,_hide:Boolean=true):void {
			for (var i:uint = 0; i <_spawn.length; i++) {
				_map.setTileProperties(_spawn[i],FlxObject.ANY,_callback);
				var _array:Array = _map.getTileInstances(_spawn[i]);
				if (_array && _hide) {
					for (var j:uint = 0; j < _array.length; j++) {
						_map.setTileByIndex(_array[j],0);
					}
				}
			}
		}
		
		private function pointForTile(_tile:uint,_map:FlxTilemap):FlxPoint {
			var _x:Number = (_map.width/_map.widthInTiles)*(int)(_tile%_map.widthInTiles);
			var _y:Number = (_map.width/_map.widthInTiles)*(int)(_tile/_map.widthInTiles);
			var _point:FlxPoint = new FlxPoint(_x,_y);
			return _point;
		}
		
		private function presentOverlappedByPlayer():SprPresent {
			var _playerCent:FlxPoint = new FlxPoint(player.x-player.width/2.0,player.y-player.height/2.0);
			var _distSqMin:Number = Number.MAX_VALUE;
			var _presentOverlapped:SprPresent = null;
			for (var i:uint = 0; i < presentGroup.length; i++) {
				var _present:SprPresent = presentGroup.members[i];
				var _presentCent:FlxPoint = new FlxPoint(_present.x-_present.width/2.0,_present.y-_present.height/2.0);
				var _distSq:Number = Math.pow(_playerCent.x-_presentCent.x,2.0) + Math.pow(_playerCent.y-_presentCent.y/2.0,2.0);
				if (_distSq < _distSqMin && player.overlaps(_present)) {
					_presentOverlapped = _present;
					_distSqMin = _distSq;
				}
			}
			return _presentOverlapped;
		}
		
		private function removePresent(_present:SprPresent):void {
			// audio and animation?
			presentGroup.remove(_present,true);
			presentsCollected ++;
			presentsCollectedDisplay.text = "You've collected " + presentsCollected + " of " + presentsTotal + " presents!";
		}
		
		private function completeLevel():void {
			goBack();
		}
		
		private function playerDies():void {
			refresh();
		}
	}
}