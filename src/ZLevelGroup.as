package
{
	import org.flixel.*;
	
	public class ZLevelGroup extends ZNode
	{		
		public function ZLevelGroup()
		{	
			var _spacing:Number = 111;
						
			super();
			
			for (var i:uint = 0; i < Glob.levels.length; i++) {
				var _lvl:Level = new Level(Glob.CENT.x + _spacing*i, Glob.CENT.y + _spacing*i,Glob.mapNodeSheet);
				_lvl.uncurse();
				add(_lvl);
			}
			
			linkLevelNodes();
			
			// curse the current node
			currentLevel.curse();
		}
		
		private function linkLevelNodes():void {
			var _prev:Level = null;
			for (var i:uint = 0; i < children.length; i++) {
				var _cur:Level = children.members[i];
				// set this node to be the next node of the previous
				if (_prev != null) {
					_prev.next = _cur;
				}
				// set this node's previous to be the previous
				_cur.previous = _prev;
				// the next loop around, this node will be the next node's previous
				_prev = _cur;
			}
		}
		
		public function get currentLevel():Level {
			return children.members[Glob.levelNum];
		}
		
		public static function next():void {
			Glob.levelNum ++;
		}
		
		public static function previous():void {
			Glob.levelNum --;
		}
	}
}