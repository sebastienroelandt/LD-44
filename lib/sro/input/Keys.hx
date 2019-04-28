package lib.sro.input;

import haxe.Log;
import openfl.events.KeyboardEvent;

/**
 * ...
 * @author Sebastien roelandt
 */
class Keys
{
	public static var downCodes	= new Map< Int, Bool >();
	public static var click		=  new Map< Int, Bool >();

	public static function init() {
		downCodes = new Map();
	}
	
	//Update
	public static function onKeyDown(e:KeyboardEvent) {
		if (!downCodes.exists(e.keyCode)) {
			onKey(e.keyCode, true);
		}
	}
	
	public static function onKeyUp(e:KeyboardEvent) {
		onKey(e.keyCode, false);
	}
	
	public static function onKey( code:Int, down:Bool ) {
		if (down) {
			if (!downCodes.exists(code)) {
				click.set(code, false);
			}
			downCodes.set(code, true);
		}else {
			downCodes.remove(code);
		}
	}
	
	public static function reset() {
		var toClean = new List<Int>();
		for (i in click.keys()) {
			if (click.get(i)) {
				toClean.add(i);
			} else {
				click.set(i, true);
			}
		}
		for (i in toClean) {
			click.remove(i);
		}
	}
	
	//Listen methods
	public static function isDown(k:Int) {
		return downCodes.get(k);
	}
	
	public static function isUp(k:Int) {
		return !isDown(k);
	}
	
	public static function isClick(k:Int) {
		return click.exists(k) && click.get(k);
	}
}