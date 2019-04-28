package lib.sro.info;

/**
 * @author Sebastien roelandt
 */
interface ScriptObserver 
{
	public function onAlert(alert:String):Void;
}