package lib.sro.entity.process.impl;

import lib.sro.entity.constraint.IBasicEntity;
import lib.sro.entity.process.constraint.IProcess;
import openfl.geom.Point;
import lib.sro.core.Transformation;
import lib.sro.core.Bresenham;
import lib.sro.input.Mouse;

/**
 * ...
 * @author Sebastien roelandt
 */
class LookAtRotationEffectProcess implements IProcess
{
	private var priority			:	Int;
	private var lookAtPoint			:	Point;
	private var entity				:	IBasicEntity;
	private var centerPoint				: Point;
	
	public function new(entity:IBasicEntity) 
	{
		this.priority = ProcessesOrder.LOOK_AT_ROTATION_EFFECT_PRIORITY;
		this.lookAtPoint = null;
		this.entity = entity;
		this.centerPoint = new Point(entity.getWidth() / 2, entity.getHeight() / 2);
	}
	
	/* INTERFACE lib.sro.entity.process.constraint.IProcess */
	
	public function beforeEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		if (getLookAtPoint() != null) {
			Transformation.rotateDegree(entity, centerPoint, getRotation());
		}
	}
	
	public function getRotation():Float {
		var center = new Point(entity.getXx() + centerPoint.x, entity.getYy() + centerPoint.y);
		var up = new Point(center.x, center.y - 20);
		var other = getLookAtPoint();
		
		return Bresenham.getAngle(Std.int(center.x), Std.int(center.y), Std.int(up.x), Std.int(up.y), Std.int(other.x), Std.int(other.y));
	}
	
	public function stop():Void 
	{
		
	}
	
	public function getPriority():Int 
	{
		return this.priority;
	}
	
	public function setPriority(priority:Int):Void 
	{
		this.priority = priority;
	}
	
	public function getLookAtPoint():Point
	{
		return this.lookAtPoint;
	}
	
	public function setLookAtPoint(lookAtPoint:Point) 
	{
		this.lookAtPoint = lookAtPoint;
	}
	
}