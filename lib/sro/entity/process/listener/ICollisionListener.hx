package lib.sro.entity.process.listener;

import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.constraint.AbstractCollisionProcess;

/**
 * @author Sebastien roelandt
 */
interface ICollisionListener 
{
	public function onCollision(entity:ICollisionableEntity, isBlocking:Bool, process:AbstractCollisionProcess):Void;
}