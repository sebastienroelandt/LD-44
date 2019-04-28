package lib.sro.entity.process.impl;

import lib.sro.entity.constraint.IMovableEntity;
import lib.sro.input.Keys;
import lib.sro.entity.process.constraint.IProcess;

/**
 * ...
 * @author Sebastien roelandt
 */
class FrictionProcess implements IProcess
{
	private var priority				: Int;
	private var entity					: IMovableEntity;
	private var frictionX				: Float;
	private var frictionY				: Float;
		
	public function new(entity : IMovableEntity, ?frictionX = 0.90, ?frictionY = 0.94) 
	{
		this.entity = entity;
		this.priority = ProcessesOrder.FRICTION_PRIORITY;
		this.frictionX = frictionX;
		this.frictionY = frictionY;
	}

	public function beforeEntityUpdate(delta:Float):Void 
	{
		entity.setDx(entity.getDx() * frictionX);
		entity.setDy(entity.getDy() * frictionY);
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	/* Getter & setter */
	
	public function setPriority(priority:Int) : Void {
		this.priority = priority;
	}
	
	public function getPriority():Int {
		return priority;
	}
	
	public function setFrictionX(frictionX : Float) {
		this.frictionX = frictionX;
	}

	public function getFrictionX() : Float {
		return this.frictionX;
	}

	public function setFrictionY(frictionY : Float) {
		this.frictionY = frictionY;
	}

	public function getFrictionY() : Float {
		return this.frictionY;
	}

}