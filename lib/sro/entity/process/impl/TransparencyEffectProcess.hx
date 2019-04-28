package lib.sro.entity.process.impl;

import lib.sro.core.Bezier.BezierType;
import lib.sro.entity.constraint.IBasicEntity;
import lib.sro.entity.process.constraint.AbstractEffetProcess;
import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.process.listener.IEffectListener;
import lib.sro.entity.process.ProcessesOrder;

/**
 * ...
 * @author Sebastien roelandt
 */
class TransparencyEffectProcess extends AbstractEffetProcess implements IProcess
{
	private var transparency: Float;

	public function new(entity:IBasicEntity, time:Float, ?bezierType:BezierType, ?listener:IEffectListener=null) 
	{
		super(entity, time, bezierType, listener);
		
		this.priority = ProcessesOrder.TRANSPARENCY_EFFECT_PRIORITY;
	}
	
	override private function update(value:Float, diff:Float) {
		transparency = value;
		
		entity.getSprite().alpha = transparency;
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