package lib.sro.entity.process.impl;

import lib.sro.entity.constraint.IMovableEntity;
import lib.sro.entity.process.constraint.IProcess;

/**
 * ...
 * @author Sebastien roelandt
 */
class GravityProcess implements IProcess
{
	private var priority				: Int;
	private var entity					: IMovableEntity;
	private var gravity					: Float;
	
	public function new(entity : IMovableEntity, ?gravity = 0.04) 
	{
		this.entity = entity;
		this.priority = ProcessesOrder.GRAVITY_PRIORITY;
		this.gravity = gravity;
	}
	
	/* INTERFACE lib.sro.entity.process.constraint.IProcess */
	
	public function beforeEntityUpdate(delta:Float):Void 
	{
		entity.setDy(entity.getDy() + gravity);
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	/* Getter & setter */
	
	public function setPriority(priority:Int):Void {
		this.priority = priority;
	}
	
	public function getPriority():Int {
		return priority;
	}

	public function setGravity(gravity : Float) {
		this.gravity = gravity;
	}

	public function getGravity() : Float {
		return this.gravity;
	}

}