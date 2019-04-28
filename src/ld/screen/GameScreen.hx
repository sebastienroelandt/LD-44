package ld.screen;
import flash.display.Sprite;
import ld.event.IConclusionListener;
import ld.event.IExplodeListener;
import ld.event.IInfoDisplayClosedListener;
import ld.event.ITargetCaughtListener;
import ld.screen.layer.AlertLayer;
import ld.screen.layer.ConclusionLayer;
import ld.screen.layer.EndLayer;
import ld.screen.layer.InstructionsLayer;
import ld.screen.layer.Spaceship;
import ld.screen.layer.TargetLayer;
import ld.screen.layer.WantedLayer;
import lib.sro.engine.CollisionBox;
import lib.sro.screen.Screen;
import ld.engine.Target;
import ld.event.ITimeOutListener;
import ld.core.LevelManager;

/**
 * ...
 * @author Roelandt Sebastien
 */
class GameScreen extends Screen implements ITargetCaughtListener 
	implements ITimeOutListener 
	implements IConclusionListener 
	implements IInfoDisplayClosedListener
	implements IExplodeListener
{
	private var instructionsLayer : InstructionsLayer;
	private var targetLayer : TargetLayer;
	private var wantedLayer : WantedLayer;
	private var spaceship : Spaceship;
	private var alertLayer : AlertLayer;
	private var conclusionLayer: ConclusionLayer;

	public function new() 
	{
		super();
		
		addBackground();
		
		this.wantedLayer = new WantedLayer();
		this.add(wantedLayer);
		
		this.targetLayer = new TargetLayer();
		this.targetLayer.setTargetCaughtListener(this);
		this.targetLayer.setConclusionListener(this);
		this.targetLayer.setExplodeListener(this);
		this.wantedLayer.setTimeOutListener(this.targetLayer);
		this.add(targetLayer);
		
		this.spaceship = new Spaceship();
		this.add(spaceship);
		
		this.alertLayer = new AlertLayer();
		this.wantedLayer.setAlertListener(this.alertLayer);
		this.add(alertLayer);
		
		this.instructionsLayer = new InstructionsLayer();
		this.instructionsLayer.setInfoDisplayClosedListener(this);
		this.add(instructionsLayer);
		
		loadNextLevel();
	}
	
	private function addBackground() {
		var background = new Sprite();
		background.graphics.beginFill(0xEEEEEE);
		background.graphics.drawRect(0, 0, 800, 600);
		background.graphics.endFill();
		this.addChild(background);
	}
	
	private function loadNextLevel() {
		var data = LevelManager.getNextLevel();
		if (data == null) {
			this.add(new EndLayer(this.wantedLayer.getScore()));
		} else {
			for (instruction in data.instructions) {
				this.instructionsLayer.displayMessage(instruction);
			}
			this.instructionsLayer.displayMessage(getInfosLevel(data.targets));
			
			this.targetLayer.setTargets(data.targets);
			
			this.wantedLayer.displayContracts(data.contracts);
			this.wantedLayer.resetMunitions(data.munitions);
			this.wantedLayer.resetTimer(data.timer);
		}
	}
	
	public function onTargetCaught(target: Target) {
		if (this.wantedLayer.getMunitionsQuantity() != 0) {
			this.targetLayer.remove(target);
			target.kill();
			this.spaceship.addTarget(target);
		}
	}
	
	public function onTimeOut() {
		this.targetLayer.onTimeOut();
	}
	
	public function onMunitionUse() {
		this.wantedLayer.useMunition();
		if (this.wantedLayer.getMunitionsQuantity() == 0) {
			this.wantedLayer.pauseTimer();
			onTimeOut();
		}
	}
	
	public function onConclusion() {
		var targets = new Array<Target>();
		var isSpaceshipDestroyed = this.spaceship.getIsDestroyed();
		if (!isSpaceshipDestroyed) {
			targets = this.spaceship.getAndRemoveTargets();
		}
		
		conclusionLayer = new ConclusionLayer(targets, this.wantedLayer.getContracts(), this.wantedLayer.getScore(), isSpaceshipDestroyed);
		conclusionLayer.setInfoDisplayClosedListener(this);
		this.wantedLayer.pauseTimer();
		this.add(conclusionLayer);
	}
	
	public function onInfoClosedEvent(type: String) {
		if (type == this.instructionsLayer.getType()) {
			startLevel();
		} else {
			//On tranfert le total
			this.wantedLayer.setScore(this.conclusionLayer.getTotal());
			
			loadNextLevel();
			
			this.remove(conclusionLayer);
			conclusionLayer = null;
		}
	}
	
	public function startLevel() {
		this.targetLayer.start();
		this.wantedLayer.start();
		this.spaceship.repareSpaceship();
	}
	
	public function onBeginExplode() {
		this.wantedLayer.pauseTimer();
		onTimeOut();
	}
	
	public function onExplode() {
		this.alertLayer.onAlert();
		this.spaceship.destroy();
	}
	
	private function getInfosLevel(targets: Array<{color: String, quantity: Int}>): String {
		var result = "Next Level\n";
		for (target in targets) {
			result += "[" + target.color + "] x" + target.quantity + "\n";
		}
		result += "Ready ?";
		return result;
	}
}