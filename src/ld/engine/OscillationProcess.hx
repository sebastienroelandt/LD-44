package ld.engine;

import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.constraint.IMovableEntity;

/**
 * ...
 * @author Roelandt Sebastien
 */
class OscillationProcess implements IProcess
{
	private static var ORDER = 4;
	
	var entity : Target;
	var power: Float;
	var time : Float;
	var currentTime: Float;
	var isUp : Bool;
	
	public function new(entity : Target, power: Float, time: Float) 
	{
		this.entity = entity;
		this.power = power;
		this.time = time;
		
		this.currentTime = Std.random(Std.int(time));
		this.isUp = true;
	}
	
	/* INTERFACE lib.sro.entity.process.constraint.IProcess */
	
	public function beforeEntityUpdate(delta:Float):Void 
	{
		if (!entity.getIdle()) {
			currentTime -= delta;
			if (currentTime < 0) {
				currentTime = time;
				this.isUp = !this.isUp;
			}
			
			if (isUp) {
				entity.setDy(entity.getDy() - power);
			} else {
				entity.setDy(entity.getDy() + power);
			}
		}
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	public function getPriority():Int 
	{
		return ORDER;
	}
	
	public function setPriority(priority:Int):Void 
	{
		
	}
	
}