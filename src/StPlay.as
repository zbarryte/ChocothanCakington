package
{
	import org.flixel.*;
	
	public class StPlay extends ZState
	{
		private const kLeftKey:Array = ["LEFT"];
		private const kRightKey:Array = ["RIGHT"];
		private const kJumpKey:Array = ["SPACE","UP","X"];
		private const kRunKey:Array = ["SHIFT","Z"];
		private const kTogglePauseKey:Array = ["P","ENTER","ESCAPE"];
		
		private const kCurseForwardKey:Array = ["RIGHT","DOWN"];
		private const kCurseBackKey:Array = ["LEFT","UP"];
		private const kSelectKey:Array = ["SPACE"];
		
		// level spawn
		private const SPAWN_PLAYER:Array = [2];
		private const SPAWN_PRESENT:Array = [3];
		private const SPAWN_FLAG:Array = [4];
		private const SPAWN_DEATHTOUCH:Array = [5];
		private const SPAWN_HINT_MOVE:Array = [6];
		private const SPAWN_HINT_JUMP:Array = [7];
		private const SPAWN_HINT_RUN:Array = [8];
		private const SPAWN_HINT_BALLOON:Array = [9];
		
		// cosmetic level spawn
		private const kSpawnAcidFall:Array = [1];
		private const kSpawnAcidSit:Array = [2];
		private const kSpawnAcidPool:Array = [3];
		private const kSpawnAcidBubble:Array = [4];
		
		private var player:SprCake;
		private var presentGroup:FlxGroup;
		private var level:FlxTilemap;
		private var flag:SprFlag;
		private var hintMoveGroup:FlxGroup;
		private var hintJumpGroup:FlxGroup;
		private var hintRunGroup:FlxGroup;
		private var hintBalloonGroup:FlxGroup;
		
		private var cosmeticLevel:FlxTilemap;
		private var acidFallGroup:FlxGroup;
		private var acidPoolGroup:FlxGroup;
		private var acidSitGroup:FlxGroup;
		private var acidBubbleGroup:FlxGroup;
		
		private var presentsCollected:uint;
		private var presentsTotal:uint;
		private var presentsCollectedDisplay:ZNode;//FlxText;
		private var presCollectedLabel:FlxText;
		
		private var timeDisplay:FlxText;
		
		private var HUD:FlxGroup;
		
		private var pauseGroup:BtnGrpPause;
		
		private var timeRemaining:Number;
		
		private var darkness:FlxSprite;
		
		private var goal:uint;
		
		private var deathAnim:FlxSprite;
		private const kDeathAnim:String = "DEATH";
				
		override public function create():void {
			//FlxG.bgColor = 0xff004400;
			super.create();
			FlxG.worldBounds = new FlxRect(0, 0, level.width,level.height);
			FlxG.camera.bounds = FlxG.worldBounds;
			FlxG.camera.follow(player,FlxCamera.STYLE_PLATFORMER);
		}
		
		override public function createObjects():void {
			
			
			// unlock level
			var checkStatus:String = Glob.levelStatus(Glob.levelNum);
			//FlxG.log(checkStatus);
			if (checkStatus == Glob.kLocked) {
				Glob.setLevelStatusForLevelNum(Glob.levelNum,Glob.kUnlocked);
			}
			
			timeRemaining = Glob.levelTime;
			
			// Info
			presentsCollected = 0;
			
			// Level
			level = new FlxTilemap().loadMap(new Glob.levelCSV,Glob.tilesetLevelSheet,32,32);
			add(level);
			goal = Glob.goal;
			
			// Cosmetic Level
			cosmeticLevel = new FlxTilemap().loadMap(new Glob.cosmeticLevelCSV,Glob.cosmeticTilesetLevelSheet,32,32);
			add(cosmeticLevel);
			
			// Acid Fall
			acidFallGroup = groupFromSpawn(kSpawnAcidFall,SprAcidFalling,cosmeticLevel);
			add(acidFallGroup);
			acidPoolGroup = groupFromSpawn(kSpawnAcidPool,SprAcidPooling,cosmeticLevel);
			add(acidPoolGroup);
			acidSitGroup = groupFromSpawn(kSpawnAcidSit,SprAcidSit,cosmeticLevel);
			add(acidSitGroup);
			acidBubbleGroup = groupFromSpawn(kSpawnAcidBubble,SprAcidBubble,cosmeticLevel);
			add(acidBubbleGroup);
			
			// Death Touch
			setCallbackFromSpawn(SPAWN_DEATHTOUCH,function():void {playerDies();},level,false);
			
			level.visible = false;
			
			// Hints
			hintMoveGroup = groupFromSpawn(SPAWN_HINT_MOVE,SprHintMove,level);
			add(hintMoveGroup);
			hintJumpGroup = groupFromSpawn(SPAWN_HINT_JUMP,SprHintJump,level);
			add(hintJumpGroup);
			hintBalloonGroup = groupFromSpawn(SPAWN_HINT_BALLOON,SprHintBalloon,level);
			add(hintBalloonGroup);
			hintRunGroup = groupFromSpawn(SPAWN_HINT_RUN,SprHintRun,level);
			add(hintRunGroup);
			
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
			
			presentsCollectedDisplay = new ZNode();
			//Glob.topNode(presentsCollectedDisplay);
			//Glob.centerNodeX(presentsCollectedDisplay);
			presentsCollectedDisplay.x = 0;
			presentsCollectedDisplay.y = 0;
			presentsCollectedDisplay.scrollFactor = new FlxPoint(0,0);
			
			var presIcon:SprPresent = new SprPresent();
			presIcon.isIcon = true;
			presIcon.scale.x = 0.5;
			presIcon.scale.y = 0.5;
			presentsCollectedDisplay.add(presIcon);
			presIcon.x += 5;
			presIcon.y -= 5;
			
			presCollectedLabel = new FlxText(0,0,FlxG.width);//,"You've collected " + presentsCollected + " of " + presentsTotal + " presents!");
			presCollectedLabel.alignment = "center";
			presentsCollectedDisplay.add(presCollectedLabel);
			presCollectedLabel.x -= FlxG.width/2.0 -44;
			presCollectedLabel.y +=3;
			
			rewritePresCollectedText();
			
			HUD.add(presentsCollectedDisplay);
			timeDisplay = new FlxText(FlxG.width-100,0,100,""+int(timeRemaining)+"");
			timeDisplay.scrollFactor = new FlxPoint(0,0);
			timeDisplay.size = 10;
			timeDisplay.alignment = "right";
			HUD.add(timeDisplay);
			timeDisplay.x = FlxG.width-timeDisplay.width;
			
			add(HUD);
			
			darkness = new FlxSprite(0,0);
			darkness.makeGraphic(FlxG.width, FlxG.height, 0x88000000);
			darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			darkness.blend = "multiply";
			add(darkness);
			darkness.visible = false;
			
			// Pause
			pauseGroup = new BtnGrpPause();
			//pauseGroup.x = Glob.CENT.x;
			/*
			pauseGroup.x = Glob.CENT.x-ZButton.W/2.0;
			pauseGroup.y = FlxG.height/5;*/
			
			//pauseGroup.x = 100;
			//pauseGroup.y = 100;
			
			pauseGroup.addButton(new BtnPause(resume,"continue"));
			pauseGroup.addButton(new BtnPause(refresh,"restart"));
			pauseGroup.addButton(new BtnPause(function():void {goTo(StControls);},"controls"));
			pauseGroup.addButton(new BtnPause(goBack,"go back",Glob.buttonCakeBottomSheet));
			add(pauseGroup);
			
			pauseGroup.scrollFactor.x = 0;
			pauseGroup.scrollFactor.y = 0;
			
			deathAnim = new FlxSprite();
			deathAnim.loadGraphic(Glob.cakeDeathAnimSheet,true,false,32,40);
			deathAnim.addAnimation(kDeathAnim,[0,1,2,3,4,5,6,7],22,false);
			
			fadeFromColor(0xff000000,0.22);
			isTransitioning = true;
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
			
			if (presentsCollected >= goal && player.overlaps(flag)) {
				completeLevel();
			}
			
			if (deathAnim.frame==7) {
				canPause = false;
				fadeToColor(0xff000000,0.22);
				refresh(0.22);
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
				if (_distSq < _distSqMin && player.overlaps(_present) && !_present.captured) {
					_presentOverlapped = _present;
					_distSqMin = _distSq;
				}
			}
			return _presentOverlapped;
		}
		
		private function removePresent(_present:SprPresent):void {
			// audio and animation?
			
			ZAudioHandler.removeSound(Glob.presentGetSound);
			ZAudioHandler.addSound(Glob.presentGetSound);
			
			_present.captured = true;
			presentsCollected ++;
			rewritePresCollectedText();
			//presentsCollectedDisplay.text = "You've collected " + presentsCollected + " of " + presentsTotal + " presents!";
			if (presentsCollected >= goal) {
				presCollectedLabel.color = 0xffffff00;
				flag.makeHappy();
			}
			var _removal:ZTimedEvent = new ZTimedEvent(0.22,function():void {
			presentGroup.remove(_present,true);
			},false,true,function():void{_present.y-=3;_present.alpha-=0.1;});
			add(_removal);
		}
		
		private function rewritePresCollectedText():void {
			presCollectedLabel.text = "   = " + presentsCollected +"/"+presentsTotal + ((presentsCollected >= goal)? "":("\n\ncollect "+(goal-presentsCollected)+ " more"));
		}
		
		private function completeLevel():void {
			
			if (!isTransitioning) {
				
				canPause = false;
				pause();
				
				ZAudioHandler.removeSound(Glob.selectSound);
				ZAudioHandler.addSound(Glob.selectSound);
				
				Glob.setLevelStatusForLevelNum(Glob.levelNum,Glob.kBeaten);
				Glob.setLevelPresentsCollectedRecord(Glob.levelNum,presentsCollected);
				
				//FlxG.log(Glob.levelNum);
				
				if (Glob.nextLevelNum == Glob.levelNum) {
					goBack();
				} else {
					Glob.levelNum = Glob.nextLevelNum;
					fadeToColor(0xff000000,0.22);
					goToNoReturn(StPlay,0.22);
				}
			}
		}
		
		private function playerDies():void {
			ZAudioHandler.clearSounds();
			ZAudioHandler.addSound(Glob.deathSound);
			//player.death();
			deathAnim.x = player.x;
			deathAnim.y = player.y-8;
			remove(player,true);
			add(deathAnim);
			deathAnim.play(kDeathAnim);
			deathAnim.acceleration.y = Glob.GRAV_ACCEL/2.0;
			
			//refresh();
		}
		
		override public function pause():void {
			if (canPause) {
			pauseGroup.visible = true;
			darkness.visible = true;
			ZAudioHandler.half = true; }
			super.pause();
		}
		
		override public function resume():void {
			pauseGroup.visible = false;
			darkness.visible = false;
			ZAudioHandler.half = false;
			super.resume();
		}
		
		override protected function goBack(_time:Number=0):void {
			ZAudioHandler.clearMusic();
			ZAudioHandler.addMusic(Glob.menuMusic);
			fadeToColor(0xffffffff,0.22);
			super.goBackRefreshed(0.22);
		}
	}
}