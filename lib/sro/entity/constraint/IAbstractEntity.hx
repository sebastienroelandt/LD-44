package lib.sro.entity.constraint;

import lib.sro.entity.process.constraint.IProcess;
import lib.sro.ui.constraint.IAnimatedSprite;
import lib.sro.ui.constraint.IBasicUI;

/**
 * @author Sebastien roelandt
 */
interface IAbstractEntity extends IBasicUI
{
	public function addProcess(process:IProcess):Void;
	public function removeProcess(process:IProcess):Void;
	public function resetProcesses():Void;
	
	public function entityUpdate(delta:Float):Void;
}