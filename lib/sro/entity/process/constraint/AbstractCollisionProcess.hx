package lib.sro.entity.process.constraint;

import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.listener.ICollisionListener;

/**
 * ...
 * @author Sebastien roelandt
 */
enum CollisionProcessType {
	GRID;
	BOX;
	UNDEFINED;
}
 
class AbstractCollisionProcess
{
	private var collisionListeners		: Array<ICollisionListener>;
	private var entity					: ICollisionableEntity;
	private var isBlocking				: Bool;
	
	public function new(entity:ICollisionableEntity, ?isBlocking = true) {
		this.entity = entity;
		this.isBlocking = isBlocking;
		this.collisionListeners = new Array<ICollisionListener>();
	}
	
	public function getType():CollisionProcessType {
		return CollisionProcessType.UNDEFINED;
	}
	
	public function onCollision() {
		for (collisionListener in collisionListeners) {
			collisionListener.onCollision(entity, isBlocking, this);
		}
	}
	
	public function addListener(collisionListener:ICollisionListener) {
		collisionListeners.push(collisionListener);
	}
	
	public function removeListener(collisionListener:ICollisionListener) {
		collisionListeners.remove(collisionListener);
	}
}