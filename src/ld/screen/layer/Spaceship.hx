package ld.screen.layer;

import ld.engine.Target;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.GameController;
import openfl.display.Bitmap;

/**
 * ...
 * @author Roelandt Sebastien
 */
class Spaceship extends DrawableLayer
{
	var targets : Array<Target>;
	var prison : Bitmap;
	var isDestroyed : Bool;

	public function new() 
	{
		super();
		
		this.y = 70;
		this.x = 800/2 - 70;
		
		this.prison = new Bitmap(GameController.assets.getBitmapData("prison"));
		this.addChild(prison);
		
		this.targets = new Array<Target>();
		this.isDestroyed = false;
	}
	
	public function addTarget(target: Target) {
		var positionX = Std.random(140 - 28);
		target.setDx(0);
		target.setDy(0);
		target.setXx(positionX);
		target.setYy(7);
		this.add(target);
		this.setChildIndex(target, 0);
		
		targets.push(target);
	}
	
	public function getAndRemoveTargets(): Array<Target> {
		for (target in targets) {
			this.remove(target);
		}
		
		var result = targets;
		targets = new Array<Target>();
		
		return result;
	}
	
	public function destroy() {
		for (target in targets) {
			this.remove(target);
		}
		this.targets = new Array<Target>();
		this.prison.bitmapData = GameController.assets.getBitmapData("prison_destroyed");
		this.isDestroyed = true;
	}
	
	public function getIsDestroyed() {
		return isDestroyed;
	}
	
	public function repareSpaceship() {
		if (isDestroyed) {
			this.prison.bitmapData = GameController.assets.getBitmapData("prison");
			this.isDestroyed = false;
		}
	}
	
}