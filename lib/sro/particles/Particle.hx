package lib.sro.particles;

/**
 * @author Sebastien roelandt
 */
interface Particle 
{
	public function init(generator:ParticlesGenerator, ?infinity:Bool):Void;
	public function onCreate():Void;
	public function onDelete():Void;
}