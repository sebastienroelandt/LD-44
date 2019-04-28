package lib.sro.particles;

import lib.sro.data.StatedAnimationData;
import lib.sro.ui.impl.BasicUI;

/**
 * ...
 * @author Sebastien roelandt
 */
class BasicParticle// extends Entity implements Particle
{/*
	private var generator 		: ParticlesGenerator;
	private var time			: Float;
	private var infinity		: Bool;
	
	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		super(statedAnimationData, parent, deltaUp, deltaDown, deltaLeft, deltaRight);
	}
	
	public function init(generator:ParticlesGenerator, ?infinity=false) {
		this.generator = generator;
		this.infinity = infinity;
		this.time = statedAnimationData.getAnimationTime();
		setPosition(generator.x, generator.y);
	}
	
	public function onCreate() {
		
	}
	
	public function onDelete() {
		
	}
	
	override public function beforeUpdate(delta:Float) 
	{
		super.beforeUpdate(delta);
		
		moveParticule();
		
		if (!infinity) {
			time -= delta;
			if (time < 0 && generator != null) {
				generator.removeParticle(this);
			}
		}
	}
		
	public function moveParticule() {
		dy = -0.1;
	}*/
	
}