package ld.event;

/**
 * @author Roelandt Sebastien
 */
interface IExplodeListener 
{
	public function onBeginExplode(): Void;
	
	public function onExplode(): Void;
}