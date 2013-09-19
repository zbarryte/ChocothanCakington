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
		
		private var marker:SprCake;//ZNode;
		private var markerDir:FlxPoint;
		private var markerDirActual:FlxPoint;
		private var target:Level;
		
		private var isIdle:Boolean;
		private var nextOrPrevious:Function;
		
		private var label:FlxText;
		
		override public function create():void {
			//FlxG.bgColor = 0xff333333;
			super.create();
			
			var _level:Level = currentLevel;
			marker.x = _level.x + marker.width/2.0;
			marker.y = _level.y + marker.height/2.0;
		}
		
		override public function createObjects():void {
			lvlGrp = new ZLevelGroup();
			add(lvlGrp);			
			
			var _level:Level = currentLevel;
			marker = new SprCake();
			marker.canMove = false;/*ZNode(_level.x,_level.y);
			marker.loadGraphic(Glob.mapMarkerSheet,true,false,32,32);
			marker.addAnimation("IDLE",[0,1],5,true);
			marker.play("IDLE");*/
			add(marker);
			
			markerDir = new FlxPoint(0,0);
			markerDirActual = new FlxPoint(0,0);
			
			isIdle = true;
			target = null;
			
			label = new FlxText(0,0,FlxG.width);
			Glob.centerNodeX(label);
			Glob.topNode(label);
			label.y += label.height;
			label.alignment = "center";
			label.size = 22;
			add(label);
			setLabel();
			
			// place levels
			/*
			var edgeBuffer:Number = marker.width;
			var xSpacing:Number = FlxG.width/5;
			var ySpacing:Number = FlxG.height/5;*/
			var padding:Number = 64;
			var nodeWidth:Number = 64;
			var xSpacing:Number = 96;
			var ySpacing:Number = 96;
			
			var lvlPts:Array = [
				/*
				new FlxPoint(edgeBuffer,FlxG.height-edgeBuffer-ySpacing),
				new FlxPoint(edgeBuffer+xSpacing*1,FlxG.height-edgeBuffer-ySpacing),
				new FlxPoint(edgeBuffer+xSpacing*2,FlxG.height-edgeBuffer-ySpacing),
				new FlxPoint(edgeBuffer+xSpacing*3,FlxG.height-edgeBuffer-ySpacing/2.0),
				new FlxPoint(edgeBuffer+xSpacing*2,FlxG.height-edgeBuffer-3*ySpacing/2),
				new FlxPoint(edgeBuffer+xSpacing,FlxG.height-edgeBuffer-3*ySpacing/2),
				new FlxPoint(edgeBuffer,FlxG.height-edgeBuffer-5*ySpacing/2),
				new FlxPoint(edgeBuffer+xSpacing*1,FlxG.height-edgeBuffer-5*ySpacing/2)*/
				new FlxPoint(padding + nodeWidth,FlxG.height - padding - nodeWidth),
				new FlxPoint(padding + nodeWidth*2 + xSpacing,FlxG.height -padding -nodeWidth),
				new FlxPoint(padding + nodeWidth*3 + xSpacing*2, FlxG.height - padding - nodeWidth)
			];
			
			lvlGrp.setPositionsWithPoints(lvlPts);
			
			var selectHint:HintButton = new HintButton("Space","select",true);
			Glob.bottomNode(selectHint);
			Glob.rightNode(selectHint);
			add(selectHint);
			
			var exitHint:HintButton = new HintButton("Esc","back");
			Glob.bottomNode(exitHint);
			Glob.leftNode(exitHint);
			add(exitHint);
			
			isTransitioning = true;
			fadeFromColor(0xffffffff,0.22);
		}
		
		private function setLabel():void {
			/*label.text = "Level  " + (currentLevel.index + 1) +
				": \n" + currentLevel.name +
				" \n collect at least " + currentLevel.goal + " presents!";*/
			label.text = /*"Level " + (currentLevel.index + 1) + ":\n" +*/
				"Collect at least " + currentLevel.goal + " Presents!"
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
			if (_cur.next && _cur.next.isUnlocked()) {
				_distSq = Math.pow(_pos.x-_cur.next.x,2.0) + Math.pow(_pos.y-_cur.next.y,2.0);
				_distSqNew = Math.pow(_posNew.x-_cur.next.x,2.0) + Math.pow(_posNew.y-_cur.next.y,2.0);
				if (_distSqNew < _distSq) {
					nextOrPrevious = lvlGrp.next;
					_lvl = _cur.next;
				}
			}
			
			if (_cur.previous && _cur.previous.isUnlocked()) {
				_distSq = Math.pow(_pos.x-_cur.previous.x,2.0) + Math.pow(_pos.y-_cur.previous.y,2.0);
				_distSqNew = Math.pow(_posNew.x-_cur.previous.x,2.0) + Math.pow(_posNew.y-_cur.previous.y,2.0);
				if (_distSqNew < _distSq) {
					nextOrPrevious = lvlGrp.previous;
					_lvl = _cur.previous;
				}
			}
			
			//nextOrPrevious = null;
			return _lvl;
		}
		
		private function moveMarkerToTarget():void {
			target = targetLevel();
			if (target != null && isIdle) {
				isIdle = false;
				var _dist:Number = Math.pow(Math.pow(marker.x + marker.width/2.0 -target.x - target.width/2.0,2.0) + Math.pow(marker.y+marker.height/2.0-target.y-target.height/2.0,2.0),0.5);
				markerDirActual = new FlxPoint((-marker.x-marker.width/2.0+target.x+target.width/2.0)/_dist,(-marker.y-marker.height/2.0+target.y+target.height/2.0)/_dist);
			}
			//marker.x += 5*markerDirActual.x;
			//marker.y += 5*markerDirActual.y;
			
			if (target != null) {
				
				// make sure the marker doesn't pass the target...
				if ((markerDirActual.x < 0 && marker.x + marker.width/2.0 < target.x + target.width/2.0) ||
					(markerDirActual.x > 0 && marker.x + marker.width/2.0 > target.x + target.width/2.0) ||
					(markerDirActual.x == 0)) {
										
					marker.x = target.x + target.width/2.0 - marker.width/2.0;
					markerDirActual.x = 0;
				} else {
					marker.x += 5*markerDirActual.x;
				}
				if ((markerDirActual.y < 0 && marker.y + marker.height/2.0 < target.y + target.height/2.0) ||
					(markerDirActual.y > 0 && marker.y + marker.height/2.0 > target.y + target.height/2.0) ||
					(markerDirActual.y == 0)) {
					
					marker.y = target.y + target.height/2.0 - marker.height/2.0;
					markerDirActual.y = 0;
				} else {
					marker.y += 5*markerDirActual.y;
				}
				
				if (marker.x + marker.width/2.0 == target.x + target.width/2.0 && marker.y + marker.height/2.0 == target.y + target.height/2.0) {
					isIdle = true;
					nextOrPrevious();
					setLabel();
					
					//FlxG.log(target.status);
				}
			}
			
			//FlxG.log(marker.x + ',' + marker.y);
		}
		
		private function get currentLevel():Level {
			return lvlGrp.currentLevel;
		}
		
		override protected function updateControls():void {
			if (Glob.justPressed(BACK_KEY) && isIdle) {
				goBack(0.22);
				fadeToColor(0xffffffff,0.22);
			} else if (Glob.justPressed(FORWARD_KEY) && isIdle) {
				ZAudioHandler.clearMusic();
				ZAudioHandler.addMusic(Glob.levelMusic);
				goTo(StPlay,0.44);
				fadeToColor(0xff000000,0.44);
			}
			
			controlMarker();
		}
		
		private function controlMarker():void {
			markerDir.x = 0;
			markerDir.y = 0;
			if (Glob.justPressed(LEFT_KEY) || Glob.justPressed(RIGHT_KEY) ||
				Glob.justPressed(UP_KEY) || Glob.justPressed(DOWN_KEY)) {
		
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
			}
			// maybe this should also be normalized?
		}
	}
}