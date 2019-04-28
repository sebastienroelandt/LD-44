package ld.screen.layer;
import flash.display.Sprite;
import ld.engine.Sniper;
import ld.engine.Target;
import ld.engine.TntTarget;
import ld.event.IConclusionListener;
import ld.event.IExplodeListener;
import ld.event.ITargetCaughtListener;
import ld.event.ITimeOutListener;
import lib.sro.layers.DrawableLayer;
import ld.engine.TargetType;
import lib.sro.core.GameController;
import openfl.display.Bitmap;
import lib.sro.input.Mouse;
import ld.engine.ChameleonTarget;

/**
 * ...
 * @author Roelandt Sebastien
 */
class TargetLayer extends DrawableLayer implements ITimeOutListener
{
	var targets : Array<Target>;
	var sniper : Sniper;
	
	var targetCaughtListener : ITargetCaughtListener;
	var conclusionListener : IConclusionListener;
	var explodeListener: IExplodeListener;
	
	var isPaused : Bool;

	public function new() 
	{
		super();
		
		this.x = 40;
		this.y = 240;
		
		addBackground();
		
		sniper = new Sniper(this);
		sniper.desactivate();
		
		this.add(sniper);
		this.isPaused = false;
	}
	
	private function addBackground() {
		var background = new Sprite();
		background.graphics.beginFill(0xF3F3F3);
		background.graphics.drawRect(0, 0, 720, 350);
		background.graphics.endFill();
		this.addChild(background);
	}
	
	public function setTargets(data: Array<{color: String, quantity: Int}>){
		resetTargetList();
		
		for (targetData in data) {
			for (i in 0...targetData.quantity) {
				var target : Target;
				if (targetData.color == TargetType.chameleon) {
					target = new ChameleonTarget(this);
				} else if (targetData.color == TargetType.tnt)  {
					var tntTarger = new TntTarget(targetData.color, this);
					tntTarger.setExplodeListener(explodeListener);
					target = tntTarger;
				} else {
					target = new Target(targetData.color, this);
				}
				target.visible = false;
				this.targets.push(target);
				this.add(target);
			}
		}
		
		this.setChildIndex(sniper, this.targets.length + 1);
	}
	
	public function start() {
		for (target in targets) {
			target.visible = true;
		}
		sniper.activate();
		isPaused = false;
	}
	
	private function resetTargetList() {
		if (targets != null) {
			for (target in targets) {
				this.remove(target);
			}
		}
		
		this.targets = new Array<Target>();
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (Mouse.isEndClick() && this.sniper.isActivated()) {
			for (target in targets) {
				if (target.isCollideWith(sniper.getCollisionBox())) {
					fireOnTargetCaughtEvent(target);
				}
			}
			fireOnMunitionUseEvent();
		}
		
		if (!isPaused && targets != null) {
			var runConclusion = true && targets.length != 0;
			var index = 0;
			while (index != targets.length && runConclusion) {
				runConclusion = targets[index].getIsKilled();
				index ++;
			}
			if (runConclusion) {
				fireOnConclusionEvent();
				isPaused = true;
			}
		}
	}
	
	public function setTargetCaughtListener(listener : ITargetCaughtListener) {
		this.targetCaughtListener = listener;
	}
	
	private function fireOnTargetCaughtEvent(target : Target) {
		if (this.targetCaughtListener != null) {
			this.targetCaughtListener.onTargetCaught(target);
		}
	}
	
	private function fireOnMunitionUseEvent() {
		if (this.targetCaughtListener != null) {
			this.targetCaughtListener.onMunitionUse();
		}
	}
	
	public function setConclusionListener(listener : IConclusionListener) {
		this.conclusionListener = listener;
	}
	
	private function fireOnConclusionEvent() {
		if (this.conclusionListener != null) {
			this.conclusionListener.onConclusion();
			this.sniper.desactivate();
		}
	}
	
	public function onTimeOut() {
		this.sniper.desactivate();
		for (target in targets) {
			target.end();
		}
	}
	
	public function setExplodeListener(listener) {
		this.explodeListener = listener;
	}
	
}