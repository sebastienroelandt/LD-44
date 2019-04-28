package ld.engine;

/**
 * ...
 * @author Roelandt Sebastien
 */
class TargetType
{
	public static var blue = "blue";
	public static var blue_square = "blue_square";
	public static var blue_point = "blue_point";
	public static var blue_cross = "blue_cross";
	public static var brown = "brown";
	public static var gray = "gray";
	public static var green = "green";
	public static var purple = "purple";
	public static var red = "red";
	public static var red_square = "red_square";
	public static var red_point = "red_point";
	public static var red_cross = "red_cross";
	public static var yellow = "yellow";
	public static var tnt = "tnt";
	public static var chameleon = "chameleon";
	public static var explosion = "explosion";
	
	public static function getAll() {
		return [blue, blue_square, blue_point, blue_cross,
			brown, gray, green, purple, red,
			red_square, red_point, red_cross,
			yellow, tnt, chameleon, explosion
		];
	}
	
}