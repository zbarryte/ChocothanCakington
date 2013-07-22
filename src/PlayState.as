package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private const SPAWN_PLAYER:Array = [2];
		
		private var player:Cake;
		private var level:FlxTilemap;
		
		override public function create():void {
			FlxG.bgColor = 0xff002222;
			
			level = new FlxTilemap().loadMap(new Glob.levelCSV,Glob.tilesetLevelSheet,32,32);
			add(level);
			
			player = groupFromSpawn(SPAWN_PLAYER,Cake,level).members[0];
			add(player);
			add(player.components);
			
			FlxG.worldBounds = new FlxRect(0, 0, level.width,level.height);
			FlxG.camera.bounds = FlxG.worldBounds;
			FlxG.camera.follow(player,FlxCamera.STYLE_PLATFORMER);
		}
		
		override public function update():void {
			super.update();
			FlxG.collide(player,level);
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
	}
}