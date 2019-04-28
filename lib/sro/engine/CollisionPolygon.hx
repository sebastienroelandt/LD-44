package lib.sro.engine;

import openfl.geom.Point;
/**
 * ...
 * @author Sebastien roelandt
 */
class CollisionPolygon
{
	var points			: Array<Point>;
	
	public function new(points:Array<Point>) 
	{
		this.points = points;
	}
	
	public function getPoints(): Array<Point> {
		return points;
	}
	
}