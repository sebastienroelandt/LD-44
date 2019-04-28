package lib.sro.entity.process;

import haxe.ds.ArraySort;
import lib.sro.entity.process.constraint.IProcess;

/**
 * ...
 * @author Sebastien roelandt
 */
class ProcessesOrder
{
	// Deplacements
	public static var MOVE_PRIORITY							=  1;
	public static var GRAVITY_PRIORITY						=  2;
	public static var FRICTION_PRIORITY						=  5;
	
	//Contre Deplacement	
	public static var BOX_COLLISION_PRIORITY				= 11;
	public static var GRID_BOX_COLLISION_PRIORITY			= 12;
	public static var POLYGON_COLLISION_PRIORITY			= 13;
	public static var GRID_POLYGON_COLLISION_PRIORITY		= 14;
	
	//Visual effect	
	public static var DEFAULT_EFFECT_PRIORITY				= 21;
	public static var TRANSPARENCY_EFFECT_PRIORITY			= 22;
	public static var ROTATION_EFFECT_PRIORITY				= 23;
	public static var LOOK_AT_ROTATION_EFFECT_PRIORITY		= 24;

	public static function sort(list:Array<IProcess>):Array<IProcess> {
		ArraySort.sort(list,
			function (p1:IProcess, p2:IProcess):Int {
				if (p1.getPriority() < p2.getPriority()) return -1;
				else if (p1.getPriority() > p2.getPriority()) return 1;
				else return 0;
			}
		);
		return list;
	} 
	
}