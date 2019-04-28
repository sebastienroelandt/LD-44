package lib.sro.input;

import openfl.events.MouseEvent;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class Mouse
{
	static var down:Bool;
	static var endDown:Bool;
	static var beginDown:Bool;
	
	static var endClick:Bool;
	static var beginClick:Bool;
	static var downClick:Bool;
	
	static var scrollUp:Bool;
	static var scrollDown:Bool;
	
	static var x:Float;
	static var y:Float;
	
	static var verticalDelta:Float;

	public static function init(){
		down = endDown = beginDown = false;
		endClick = beginClick = downClick = false;
		x = 0;
		y = 0;
		verticalDelta = 0;
	}
	
	//Update
	public static function onKeyDown(e:MouseEvent) {
		if (!down) {
			beginDown = true;
		}
		down = true;
	}
	
	public static function onKeyUp(e:MouseEvent) {
		if (down) {
			endDown = true;
		}
		down = false;
	}
	
	public static function onMove(e:MouseEvent) {
		x = e.stageX;
		y = e.stageY;
	}
	
	public static function onScroll(e:MouseEvent) {
		if (e.delta > 0) {
			scrollUp = true;
		} else if (e.delta < 0) {
			scrollDown = true;
		}
		
		if (scrollUp && scrollDown) {
			scrollUp = scrollDown = false;
		}
	}
	
	public static function reset() {
		endClick = false;
		if (endDown) {
			endDown = false;
			endClick = true;
			downClick = false;
		}
		beginClick = false;
		if (beginDown) {
			beginDown = false;
			beginClick = true;
			downClick = true;
		}
		scrollUp = scrollDown = false;
	}
	
	//Listen methods
	public static function isDown():Bool {
		return downClick;
	}
	
	public static function isBeginClick():Bool {
		return beginClick;
	}
	
	public static function isEndClick():Bool {
		return endClick;
	}
	
	public static function getXY():Point{
		return new Point(x,y);
	}
	
	public static function getXYwithDelta():Point{
		return new Point(x,y + verticalDelta);
	}
	
	public static function isScrollUp():Bool {
		return scrollUp;
	}
	
	public static function isScrollDown():Bool {
		return scrollDown;
	}
	
	public static function setVerticalDelta(value:Float) {
		verticalDelta = value;
	}
	
}