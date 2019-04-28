package lib.sro.entity.process.impl;

import lib.sro.core.Bezier.BezierType;
import lib.sro.entity.constraint.IBasicEntity;
import lib.sro.entity.process.constraint.AbstractEffetProcess;
import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.process.listener.IEffectListener;
import openfl.geom.Point;
import lib.sro.core.Transformation;

/**
 * ...
 * @author Sebastien roelandt
 */
class RotationEffectProcess extends AbstractEffetProcess implements IProcess
{
	private var rotationInDegrees		: Float;
	private var centerPoint				: Point;

	public function new(entity:IBasicEntity, time:Float, ?bezierType:BezierType, ?listener:IEffectListener=null) 
	{
		super(entity, time, bezierType, listener);
		
		this.rotationInDegrees = 0;
		
		this.centerPoint = new Point(entity.getWidth() / 2, entity.getHeight() / 2);
	}
	
	override function update(value:Float, diff:Float) 
	{
		rotationInDegrees = value * 360;
		
		Transformation.rotateDegree(entity, centerPoint, rotationInDegrees);
	}
	
	/* INTERFACE lib.sro.entity.process.constraint.IProcess */
	
	override public function beforeEntityUpdate(delta:Float) 
	{
		super.beforeEntityUpdate(delta);
	}
	
	override public function afterEntityUpdate(delta:Float) 
	{
		super.afterEntityUpdate(delta);
	}
	
	override public function stop() 
	{
		super.stop();
	}
	
	override public function getPriority():Int 
	{
		return super.getPriority();
	}
	
	override public function setPriority(priority:Int) 
	{
		super.setPriority(priority);
	}
	
}