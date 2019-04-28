package ld.engine;
import flash.display.Bitmap;
import ld.event.IExplodeListener;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.GameController;

/**
 * ...
 * @author Roelandt Sebastien
 */
class TntTarget extends Target
{
	var explosionEffect : Bitmap;
	
	var explosionEffectCount : Int;
	var isExplosionEffectAppeared : Bool;
	var isEffectEnd : Bool;
	
	var conclusionTimer : Float;
	
	var listener : IExplodeListener;
	
	public function new(targetType: String, world: DrawableLayer) 
	{
		super(targetType, world);
		
		explosionEffect = new Bitmap();
		explosionEffect.bitmapData = GameController.assets.getBitmapData(TargetType.explosion);
		explosionEffect.alpha = 0;
		explosionEffect.visible = false;
		this.addChildAt(explosionEffect, 1);
		
		explosionEffectCount = 5;
		isExplosionEffectAppeared = true;
		isEffectEnd = false;
		conclusionTimer = 1500;
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (explosionEffect.visible) {
			if (isExplosionEffectAppeared) {
				explosionEffect.alpha += 0.05;
				if (explosionEffect.alpha >= 1) {
					isExplosionEffectAppeared = false;
					explosionEffectCount --;
					if (explosionEffectCount == 0) {
						isEffectEnd = true;
						fireExplodeEvent();
					}
				}
			} else {
				explosionEffect.alpha -= 0.05;
				if (explosionEffect.alpha <= 0) {
					isExplosionEffectAppeared = true;
				}
			}
		}
	}
	
	override public function kill() 
	{
		super.kill();
		explode();
		fireBeginExplodeEvent();
	}
	
	private function explode() {
		explosionEffect.visible = true;
	}
	
	public function setExplodeListener(listener: IExplodeListener) {
		this.listener = listener;
	}
	
	private function fireBeginExplodeEvent() {
		if (this.listener != null) {
			this.listener.onBeginExplode();
		}
	}
	
	private function fireExplodeEvent() {
		if (this.listener != null) {
			this.listener.onExplode();
		}
	}
}