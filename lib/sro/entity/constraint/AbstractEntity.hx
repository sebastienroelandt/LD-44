package lib.sro.entity.constraint;

import lib.sro.data.StatedAnimationData;
import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.process.ProcessesOrder;
import lib.sro.ui.constraint.IBasicUI;
import lib.sro.ui.impl.AnimatedSprite;
import lib.sro.ui.impl.BasicUI;

/**
 * ...
 * @author Sebastien roelandt
 */
class AbstractEntity extends BasicUI implements IBasicUI
{
	private var processes		: Array<IProcess>;
	
	public function new (?parent:BasicUI = null) {
		super(parent);
		processes = new Array<IProcess>();
	}
	
	override public function update(delta:Float) 
	{
		for (process in processes) {
			process.beforeEntityUpdate(delta);
		}
		
		entityUpdate(delta);
		super.update(delta);
		
		for (process in processes) {
			process.afterEntityUpdate(delta);
		}
	}
	
	public function entityUpdate(delta:Float) {
		
	}
	
	public function addProcess(process:IProcess):Void {
		processes.push(process);
		updateProcessesOrder();
	}
	
	public function removeProcess(process:IProcess):Void {
		processes.remove(process);
		updateProcessesOrder();
	}
	
	public function resetProcesses():Void {
		for (process in processes) {
			process.stop();
		}
		processes = new Array<IProcess>();
	}
	
	private function updateProcessesOrder():Void {
		processes = ProcessesOrder.sort(processes);
	}
}