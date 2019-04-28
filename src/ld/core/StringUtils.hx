package ld.core;

/**
 * ...
 * @author Roelandt Sebastien
 */
class StringUtils
{
	public static function intToString(value: Int, length: Int): String {
		var isNegatif = false;
		if (value < 0) {
			value = -value;
			isNegatif = true;
		}
		
		var result = value + "";
		while (result.length < length) {
			result = "0" + result;
		}
		
		if (isNegatif) {
			result = "-" + result;
		} else {
			result = " " + result;
		}
		return result;
	}
}