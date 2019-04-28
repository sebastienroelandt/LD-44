package lib.sro.entity.process.constraint;

import lib.sro.core.Bezier;
import lib.sro.entity.process.constraint.IProcess;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import lib.sro.entity.constraint.IBasicEntity;
import lib.sro.entity.process.listener.IEffectListener;
import lib.sro.entity.process.ProcessesOrder;
import lib.sro.core.Bezier.BezierType;

/**
 * ...
 * @author Sebastien roelandt
 */
 
class AbstractEffetProcess implements IProcess
{
	private var priority				:	Int;
	
	private var entity					: 	IBasicEntity;
	private var listener				:	IEffectListener;

	private var bezier					:	Bezier;
	
	private var lastBezierValue			:	Float;
	private var beginTime				:	Float;
	private var time					:	Float;
	
	private var pause					:	Bool;
	private var loop					:	Bool;
	
	public function new(entity:IBasicEntity, time:Float, ?bezierType:BezierType, ?listener:IEffectListener = null) {		
		this.entity = entity;
		this.listener = listener;
		this.beginTime = Lib.getTimer();
		this.lastBezierValue = 0;
		this.bezier = new Bezier(bezierType);
		this.pause = false;
		this.loop = false;
		this.time = time;
		
		this.priority = ProcessesOrder.DEFAULT_EFFECT_PRIORITY;
	}

	private function update(value:Float, diff:Float) {
		throw "update function of Effect must be overrited !";
	}

	public function setPause(p:Bool) {
		if (p != pause) {
			if (p) {
				// begin pause
			} else {
				// end pause
			}
		}
	}
	
	public function setLoop(p:Bool) {
		if (p != pause) {
			loop = p;
		}
	}
	
	/* IProcess implements */
	public function beforeEntityUpdate(delta:Float) {
		
	}
	
	public function afterEntityUpdate(delta:Float) {
		var currentTime = Lib.getTimer();
		
		var bezierValue = bezier.getValue((currentTime - beginTime)/time);
		if (bezierValue == - 1.00) {
			if (loop) {
				beginTime = currentTime;
				bezierValue = lastBezierValue = 0;
			} else {
				stop();
				return;
			}
		}
		update(bezierValue, bezierValue - lastBezierValue);
		lastBezierValue = bezierValue;
	}
	
	public function stop() {
		if (listener != null) {
			listener.finish();
		}
		entity.removeProcess(this);
	}
		
	//Getter & Setter
	public function getPriority() {
		return this.priority;
	}
	
	public function setPriority(priority:Int) {
		this.priority = priority;
	}
}