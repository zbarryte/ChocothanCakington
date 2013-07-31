package
{
	import org.flixel.*;
	
	public class ZLetter extends FlxSprite
	{
		public static const W:Number = 8;
		public static const H:Number = 8;
		
		public function ZLetter(_x:Number=0,_y:Number=0,_letter:String=null)
		{			
			super(_x,_y);
			loadGraphic(Glob.alphabetSheet,true,false,W,H,true);
			// set frame
			if (_letter == "a") {
				frame = 1;
			} else if (_letter == "b") {
				frame = 2;
			} else if (_letter == "c") {
				frame = 3;
			} else if (_letter == "d") {
				frame = 4;
			} else if (_letter == "e") {
				frame = 5;
			} else if (_letter == "f") {
				frame = 6;
			} else if (_letter == "g") {
				frame = 7;
			} else if (_letter == "h") {
				frame = 8;
			} else if (_letter == "i") {
				frame = 9;
			} else if (_letter == "j") {
				frame = 10;
			} else if (_letter == "k") {
				frame = 11;
			} else if (_letter == "l") {
				frame = 12;
			} else if (_letter == "m") {
				frame = 13;
			} else if (_letter == "n") {
				frame = 14;
			} else if (_letter == "o") {
				frame = 15;
			} else if (_letter == "p") {
				frame = 16;
			} else if (_letter == "q") {
				frame = 17;
			} else if (_letter == "r") {
				frame = 18;
			} else if (_letter == "s") {
				frame = 19;
			} else if (_letter == "t") {
				frame = 20;
			} else if (_letter == "u") {
				frame = 21;
			} else if (_letter == "v") {
				frame = 22;
			} else if (_letter == "w") {
				frame = 23;
			} else if (_letter == "x") {
				frame = 24;
			} else if (_letter == "y") {
				frame = 25;
			} else if (_letter == "z") {
				frame = 26;
			} else if (_letter == "0") {
				frame = 27;
			} else if (_letter == "1") {
				frame = 28;
			} else if (_letter == "2") {
				frame = 29;
			} else if (_letter == "3") {
				frame = 30;
			} else if (_letter == "4") {
				frame = 31;
			} else if (_letter == "5") {
				frame = 32;
			} else if (_letter == "6") {
				frame = 33;
			} else if (_letter == "7") {
				frame = 34;
			} else if (_letter == "8") {
				frame = 35;
			} else if (_letter == "9") {
				frame = 36;
			} else if (_letter == " ") {
				frame = 0;
			}
		}
	}
}