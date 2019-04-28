package lib.sro.entity.process.constraint;

/**
 * @author Sebastien roelandt
 */
interface IProcess 
{
	public function beforeEntityUpdate(delta:Float):Void;
	public function afterEntityUpdate(delta:Float):Void;
	
	public function stop():Void;
		
	//Getter & Setter
	public function getPriority():Int;
	public function setPriority(priority:Int):Void;
	
	
}