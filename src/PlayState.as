package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private const SPAWN_PLAYER:Array = [2];
		private const SPAWN_PRESENT:Array = [3];
		private const SPAWN_FLAG:Array = [4];
		
		private var player:Cake;
		private var presentGroup:FlxGroup;
		private var level:FlxTilemap;
		private var flag:FlxSprite;
		
		private var presentsCollected:uint;
		private var presentsTotal:uint;
		private var presentsCollectedDisplay:FlxText;
		
		private var HUD:FlxGroup;
		
		private var pauseGroup:PauseGroup;
		
		override public function create():void {
			FlxG.bgColor = 0xff002222;
			
			// Info
			presentsCollected = 0;
			
			// Level
			level = new FlxTilemap().loadMap(new Glob.level001CSV,Glob.tilesetLevelSheet,32,32);
			add(level);
			
			// Flag
			flag = groupFromSpawn(SPAWN_FLAG,Flag,level).members[0];
			add(flag);
			
			// Presents
			presentGroup = groupFromSpawn(SPAWN_PRESENT,Present,level);
			presentsTotal = presentGroup.length;
			add(presentGroup);
			
			// Player
			player = groupFromSpawn(SPAWN_PLAYER,Cake,level).members[0];
			add(player);
			add(player.components);
			add(player.balloon);
			
			FlxG.worldBounds = new FlxRect(0, 0, level.width,level.height);
			FlxG.camera.bounds = FlxG.worldBounds;
			FlxG.camera.follow(player,FlxCamera.STYLE_PLATFORMER);
			
			// HUD
			HUD = new FlxGroup;
			presentsCollectedDisplay = new FlxText(0,0,100,"You've collected " + presentsCollected + " of " + presentsTotal + " presents!",true);
			presentsCollectedDisplay.scrollFactor = new FlxPoint(0,0);
			HUD.add(presentsCollectedDisplay);
			
			add(HUD);
			
			pauseGroup = new PauseGroup();
			add(pauseGroup);
		}
		
		override public function update():void {
			if (!pauseGroup.isOn()) {
				super.update();
				FlxG.collide(player,level);
				//FlxG.collide(player.balloon,level);
				
				var _present:Present = presentOverlappedByPlayer();
				if (_present) {
					removePresent(_present);
				}
				
				if (player.overlaps(flag)) {
					completeLevel();
				}
			} else {
				pauseGroup.update();
			}
		}
		
		private function groupFromSpawn(_spawn:Array,_class:Class,_map:FlxTilemap,_hide:Boolean=true):FlxGroup {
			var _group:FlxGroup = new FlxGroup();
			for (var i:uint = 0; i <_spawn.length; i++) {
				var _array:Array = level.getTileInstances(_spawn[i]);
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
		
		private function pointForTile(_tile:uint,_map:FlxTilemap):FlxPoint {
			var _x:Number = (_map.width/_map.widthInTiles)*(int)(_tile%_map.widthInTiles);
			var _y:Number = (_map.width/_map.widthInTiles)*(int)(_tile/_map.widthInTiles);
			var _point:FlxPoint = new FlxPoint(_x,_y);
			return _point;
		}
		
		private function presentOverlappedByPlayer():Present {
			var _playerCent:FlxPoint = new FlxPoint(player.x-player.width/2.0,player.y-player.height/2.0);
			var _distSqMin:Number = Number.MAX_VALUE;
			var _presentOverlapped:Present = null;
			for (var i:uint = 0; i < presentGroup.length; i++) {
				var _present:Present = presentGroup.members[i];
				var _presentCent:FlxPoint = new FlxPoint(_present.x-_present.width/2.0,_present.y-_present.height/2.0);
				var _distSq:Number = Math.pow(_playerCent.x-_presentCent.x,2.0) + Math.pow(_playerCent.y-_presentCent.y/2.0,2.0);
				if (_distSq < _distSqMin && player.overlaps(_present)) {
					_presentOverlapped = _present;
					_distSqMin = _distSq;
				}
			}
			return _presentOverlapped;
		}
		
		private function removePresent(_present:Present):void {
			// audio and animation?
			presentGroup.remove(_present,true);
			presentsCollected ++;
			presentsCollectedDisplay.text = "You've collected " + presentsCollected + " of " + presentsTotal + " presents!";
		}
		
		private function completeLevel():void {//AtFlag(_flag:Flag):void {
			//FlxG.switchState(new ScoreState(presentsCollected/presentsTotal));
			FlxG.switchState(new MapState());
		}
	}
}