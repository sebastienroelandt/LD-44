package lib.sro.entity.process.impl;

import lib.sro.engine.CollisionBox;
import lib.sro.engine.CollisionPolygon;
import lib.sro.engine.CollisionUtils;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.constraint.AbstractCollisionProcess;
import lib.sro.entity.process.constraint.IProcess;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class PolygonCollisionProcess extends AbstractCollisionProcess implements IProcess
{
	private var priority			: Int;
	
	private var collisionPolygon	: CollisionPolygon;
	
	public function new(entity:ICollisionableEntity, collisionPolygon:CollisionPolygon) 
	{
		super(entity, isBlocking);
		
		this.priority = ProcessesOrder.BOX_COLLISION_PRIORITY;
		this.entity = entity;
		
		this.collisionPolygon = collisionPolygon;
	}
	
	override public function getType():CollisionProcessType 
	{
		return CollisionProcessType.BOX;
	}
	
	public function check() {
		var collisionInformation = CollisionUtils.polygonCollision(entity, collisionPolygon);
		if (collisionInformation.getIsCollision()) {
			//Collision
			onCollision();
		}
	}
	
	public function beforeEntityUpdate(delta:Float):Void 
	{
		check();
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
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