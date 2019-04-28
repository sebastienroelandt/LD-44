package lib.sro.particles;

import lib.sro.core.Bezier.BezierType;
import lib.sro.core.Bezier.Bezier;
import lib.sro.core.Bresenham;
import lib.sro.ui.impl.BasicUI;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class ParticlesGenerator extends BasicUI
{
	/*private static var TIME_PER_SECOND = 1000;
	
	private var autogenerator		: Bool;
	private var probability			: Float;
	private var layer				: BasicUI;
	private var loop				: Bool;
	
	//Bezier
	private var bezier				: Bezier;
	private var loopTime			: Float;
	private var totalTime			: Float;

	private var currentTempo		: Float;
	private var tempo				: Bool;
	private var tempoLoop			: Float;
	
	private var particles			: Array<Particle>;

	
	public function new(layer:BasicUI, ?bezierType:BezierType, ?autogenerator = true, 
		?loop = true, ?loopTime = 10000, ?tempo = true, ?tempoLoop = 200) 
	{
		super();
		
		this.particles = new Array();
		this.bezier = new Bezier(bezierType);
		this.layer = layer;
		this.autogenerator = autogenerator;
		this.totalTime = 0;
		this.loop = loop;
		this.loopTime = loopTime;
		this.currentTempo = 0;
		this.tempo = tempo;
		this.tempoLoop = tempoLoop;
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (autogenerator) {
			totalTime += delta;
			currentTempo -= delta;
			
			if (loop || loopTime < totalTime)
			{
				totalTime = totalTime % loopTime;
				if (!tempo || currentTempo < 0) {
					currentTempo = tempoLoop;
					
					var random = Std.random(100);
					var value = bezier.getValue(totalTime / loopTime) * 100;
					if (random >= value) {
						generateParticle();
					}
				}
			}
		}
	}
	
	public function reset() {
		totalTime = 0;
	}
	
	//particule
	private function generateParticle() {
		var particle = getNewParticle();
		if (particle != null) {
			addParticle(particle);
		}
	}
	
	public dynamic function getNewParticle():BasicParticle {
		return null;
	}
	
	public function addParticle(particle:BasicParticle) {
		particle.init(this, false);
		layer.add(particle);
		particles.push(particle);
	}
	
	public function removeParticle(particle:BasicParticle) {
		particle.visible = false;
		layer.remove(particle);
		particles.remove(particle);
	}
	
	//Getter & setter
	public function getAutogenerator():Bool {
		return this.autogenerator;
	}
	
	public function setAutogenerator(autogenerator:Bool) {
		this.autogenerator = autogenerator;
	}
	
	public function getProbability():Float {
		return this.probability;
	}
	
	public function setProbability(probability:Float) {
		this.probability = probability;
	}
	
	public function getLayer():BasicUI {
		return this.layer;
	}
	
	public function setLayer(layer:BasicUI) {
		this.layer = layer;
	}
	
	public function getPosition():Point {
		return new Point(x, y);
	}
	
	public function setPosition(position:Point) {
		this.x = position.x;
		this.y = position.y;
	}*/
}