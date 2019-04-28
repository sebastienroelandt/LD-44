package ld.event;
import ld.engine.Target;

/**
 * @author Roelandt Sebastien
 */
interface ITargetCaughtListener 
{
	public function onTargetCaught(target: Target): Void;
	public function onMunitionUse(): Void;
	
}