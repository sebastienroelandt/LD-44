package process.impl;

import lib.sro.engine.CollisionInformation;
import lib.sro.engine.CollisionPolygon;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.process.impl.GridBoxCollisionProcess;
import lib.sro.entity.process.ProcessesOrder;
import lib.sro.engine.CollisionUtils;
import openfl.geom.Point;


/**
 * ...
 * @author Sebastien roelandt
 */
class GridPolygonCollisionProcess extends GridBoxCollisionProcess implements IProcess
{
	var polygon			: 	Array<Point>;
	var deltaX			:	Int;
	var deltaY			:	Int;
		
	public function new(entity:ICollisionableEntity, tileHeight:Int, tileWidth:Int, collisionMap:Array<Array<Bool>>, 
			polygon:Array<Point>, ?deltaX=0, ?deltaY=0, ?isBlocking=true) 
	{
		super(entity, tileHeight, tileWidth, collisionMap, isBlocking);

		this.priority = ProcessesOrder.GRID_POLYGON_COLLISION_PRIORITY;
		this.polygon = polygon;
		this.deltaX = deltaX;
		this.deltaY = deltaY;
	}
	
	private function getPolygonPoint(point:Point, i:Int, j:Int):Point {
		return new Point(point.x * i + deltaX, point.y * j + deltaY);
	}
	
	private function getPolygon(i:Int, j:Int) : Array<Point> {
		var collisionPolygon = new Array<Point>();
		for (var point in polygon) {
			collisionPolygon.push(getPolygonPoint(point, i, j);
		}
		return collisionPolygon;
	}
	
	private function getCollisionInformation(i:Int, j:Int) : CollisionInformation {
		return CollisionUtils.polygonCollision(entity, new CollisionPolygon(getPolygon(i,j)));
	}
	
	public function beforeEntityUpdate(delta:Float):Void 
	{
		super.beforeEntityUpdate(delta);
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		super.afterEntityUpdate(delta);
	}
	
	public function stop():Void 
	{
		super.stop();
	}
	
	public function getPriority():Int 
	{
		return priority;
	}
	
	public function setPriority(priority:Int):Void 
	{
		this.priority = priority;
	}
	
}