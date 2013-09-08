package
{
	import org.flixel.*;
	
	public class GrpCursor extends ZNode
	{
		protected const D_SCALE:Number = 0.022;
		protected const D_X:Number = 1.22;
		
		protected var btnGrp:ZButtonGroup;
		
		public function GrpCursor(_btnGroup:ZButtonGroup)
		{
			btnGrp = _btnGroup;
			super(locX(),locY(),Glob.cursorSheet);
		}
		
		private function locX():Number {
			return btnGrp.getCursedX() - ZButton.W/3.5;
		}
		
		private function locY():Number {
			return btnGrp.getCursedY() - height/2.0 + ZButton.H/2.0;
		}
		
		public function pulse(dir:int):void {
			scale.x += dir*D_SCALE;
			scale.y -= dir*D_SCALE;
			x += dir*D_X;
		}
			
		public function resetPulse():void {
			scale.x = 1.0;
			scale.y = 1.0;
			x = locX();
			y = locY();
		}
	}
}