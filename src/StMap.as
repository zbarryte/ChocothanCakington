package
{
	import org.flixel.*;
	
	public class StMap extends ZState
	{
		private const BACK_KEY:Array = ["ESCAPE"];
		private const FORWARD_KEY:Array = ["ENTER","SPACE"];
		
		private const LEFT_KEY:Array = ["LEFT"];
		private const RIGHT_KEY:Array = ["RIGHT"];
		private const UP_KEY:Array = ["UP"];
		private const DOWN_KEY:Array = ["DOWN"];
		
		private var lvlGrp:ZLevelGroup;
		
		private var marker:ZNode;
		private var markerDir:FlxPoint;
		private var markerDirActual:FlxPoint;
		private var target:Level;
		
		private var isIdle:Boolean;
		private var nextOrPrevious:Function;
		
		override public function create():void {
			FlxG.bgColor = 0xff333333;
			super.create();
		}
		
		override public function createObjects():void {
			lvlGrp = new ZLevelGroup();
			add(lvlGrp);
			
			var _level:Level = currentLevel;
			marker = new ZNode(_level.x,_level.y);
			marker.loadGraphic(Glob.mapMarkerSheet,true,false,64,64);
			marker.addAnimation("IDLE",[0,1],5,true);
			marker.play("IDLE");
			add(marker);
			
			markerDir = new FlxPoint(0,0);
			markerDirActual = new FlxPoint(0,0);
			
			isIdle = true;
			target = null;
		}
		
		override protected function updateAnimations():void {
			
			moveMarkerToTarget();
			
			/*
			// pick the node towards which the marker's attempting to move
			// to do this, compare the marker's current distance to the next, prev (if they exist)
			// to the marker's distance to them were it to move along its desired trajectory
			var _lvl:Level = targetLevel();
			if (_lvl!=null) {
				FlxG.log(_lvl.x + ',' + _lvl.y);
			}*/
			
			/*
			if (marked().previous!=null) {
				marker.x += markerDir.x;
				marker.y += markerDir.y;
			}*/
		}
		
		private function targetLevel():Level {
			
			if (!isIdle) {return target;}
			
			var _lvl:Level = null;
			
			var _pos:FlxPoint = new FlxPoint(marker.x,marker.y);
			var _posNew:FlxPoint = new FlxPoint(marker.x+markerDir.x,marker.y+markerDir.y);
			
			var _distSq:Number;
			var _distSqNew:Number;
			
			var _cur:Level = currentLevel;
			if (_cur.next) {
				_distSq = Math.pow(_pos.x-_cur.next.x,2.0) + Math.pow(_pos.y-_cur.next.y,2.0);
				_distSqNew = Math.pow(_posNew.x-_cur.next.x,2.0) + Math.pow(_posNew.y-_cur.next.y,2.0);
				if (_distSqNew < _distSq) {
					nextOrPrevious = lvlGrp.next;
					return _cur.next;
				}
			}
			
			if (_cur.previous) {
				_distSq = Math.pow(_pos.x-_cur.previous.x,2.0) + Math.pow(_pos.y-_cur.previous.y,2.0);
				_distSqNew = Math.pow(_posNew.x-_cur.previous.x,2.0) + Math.pow(_posNew.y-_cur.previous.y,2.0);
				if (_distSqNew < _distSq) {
					nextOrPrevious = lvlGrp.previous;
					return _cur.previous;
				}
			}
			
			nextOrPrevious = null;
			return _lvl;
		}
		
		private function moveMarkerToTarget():void {
			target = targetLevel();
			if (target != null && isIdle) {
				isIdle = false;
				var _dist:Number = Math.pow(Math.pow(marker.x-target.x,2.0) + Math.pow(marker.y-target.y,2.0),0.5);
				markerDirActual = new FlxPoint((-marker.x+target.x)/_dist,(-marker.y+target.y)/_dist);
			}
			marker.x += 5*markerDirActual.x;
			marker.y += 5*markerDirActual.y;
			
			if (target != null) {
				
				// make sure the marker doesn't pass the target...
				if ((markerDirActual.x < 0 && marker.x < target.x) ||
					(markerDirActual.x > 0 && marker.x > target.x)) {
										
					marker.x = target.x;
					markerDirActual.x = 0;
				}
				if ((markerDirActual.y < 0 && marker.y < target.y) ||
					(markerDirActual.y > 0 && marker.y > target.y)) {
					
					marker.y = target.y;
					markerDirActual.y = 0;
				}
				
				if (marker.x == target.x && marker.y == target.y) {
					isIdle = true;
					nextOrPrevious();
				}
			}
			
			//FlxG.log(marker.x + ',' + marker.y);
		}
		
		private function get currentLevel():Level {
			return lvlGrp.currentLevel;
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(BACK_KEY) && isIdle) {
				goBack();
			} else if (Glob.justPressed(FORWARD_KEY) && isIdle) {
				goTo(StPlay);
			}
			
			controlMarker();
		}
		
		private function controlMarker():void {
			markerDir.x = 0;
			markerDir.y = 0;
			if (Glob.pressed(LEFT_KEY)) {
				markerDir.x -= 1;
			}
			if (Glob.pressed(RIGHT_KEY)) {
				markerDir.x += 1;
			}
			if (Glob.pressed(UP_KEY)) {
				markerDir.y -= 1;
			}
			if (Glob.pressed(DOWN_KEY)) {
				markerDir.y += 1;
			}
			// maybe this should also be normalized?
		}
	}
}