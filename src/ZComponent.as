package
{
	import org.flixel.*;
	
	public class ZComponent extends FlxSprite
	{
		private var host:FlxSprite;
		private var dx:Number;
		private var dy:Number;
		private var dAngle:Number;
		
		public function ZComponent(_host:FlxSprite=null,_dx:Number=0,_dy:Number=0,_simpleGraphic:Class=null,_dAngle:Number=0,_w:Number=0,_h:Number=0)
		{
			host = _host;
			dx = _dx;
			dy = _dy;
			dAngle = _dAngle;
			super(_host.x + _dx,_host.y + _dy);
			loadGraphic(_simpleGraphic,true,true,_w,_h,true);
		}
		
		override public function update():void {
			angle = host.angle + dAngle;
			var theta:Number = -angle*Math.PI/180.0;
			x = host.x + Math.cos(theta)*dx + Math.sin(theta)*dy;
			y = host.y - Math.sin(theta)*dx + Math.cos(theta)*dy;
		}
	}
}