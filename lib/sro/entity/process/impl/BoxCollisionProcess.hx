package lib.sro.entity.process.impl;

import lib.sro.engine.CollisionBox;
import lib.sro.engine.CollisionUtils;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.constraint.AbstractCollisionProcess;
import lib.sro.entity.process.constraint.IProcess;

/**
 * ...
 * @author Sebastien roelandt
 */
class BoxCollisionProcess extends AbstractCollisionProcess implements IProcess
{
	private var priority			: Int;
	
	private var collisionBox		: CollisionBox;
	
	public function new(entity:ICollisionableEntity, collisionBox:CollisionBox, ?isBlocking = true) 
	{
		super(entity, isBlocking);
		
		this.priority = ProcessesOrder.BOX_COLLISION_PRIORITY;
		this.entity = entity;
		
		this.collisionBox = collisionBox;
	}
	
	override public function getType():CollisionProcessType 
	{
		return CollisionProcessType.BOX;
	}
	
	public function check() {
		var collisionInformation = CollisionUtils.boxCollision(entity, collisionBox);
		if (collisionInformation.getIsCollision()) {
			//Collision
			if (collisionInformation.getCalculatedX() != 0) {
				onCollision();
				if (isBlocking) {
					entity.setDx(0);
					entity.setXx(collisionInformation.getCalculatedX());
				}
			}
			
			if (collisionInformation.getCalculatedY() != 0) {
				onCollision();
				if (isBlocking) {
					entity.setDy(0);
					entity.setYy(collisionInformation.getCalculatedY());
				}
			}
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