package
{
	import org.flixel.*;
	
	public class ZTimedEvent extends FlxBasic
	{
		protected var time:Number; // the amount of time elapsed, in seconds
		protected var period:Number; // the amount of time to complete 1 cycle, in seconds
		protected var event:Function; // the event fired each cycle
		protected var isLooped:Boolean; // does the cycle repeat?
		protected var isPlaying:Boolean; // is the cycle progressing?
		
		public function ZTimedEvent(_period:Number,_event:Function,_pulseItems:Array=null,_isAutomatic:Boolean=true,_isLooped:Boolean=true)
		{
			time = 0;
			period = _period;
			event = _event;
			isLooped = _isLooped;
			isPlaying = _isAutomatic;
			
			super();
		}
		
		public static function stallOthersEvent(_period:Number,_event:Function,_time:Number=0):void {
			if (_time < _period) {
				ZTimedEvent.stallOthersEvent(_period,_event,_time++);
			}
			_event();
		}
		
		public function start():void {
			isPlaying = true;
		}
		
		public function stop():void {
			isPlaying = false;
			// restart the timer
			time = 0;
		}
		
		override public function update():void {
			// start timing if playing
			if (isPlaying) {
				time += FlxG.elapsed;
				// every cycle...
				if (time >= period) {
					// restart the timer and fire the event
					time = 0;
					event();
					// stop non-looping events after the first cycle
					if (!isLooped) {
						stop();
					}
				}
			}
		}
	}
}