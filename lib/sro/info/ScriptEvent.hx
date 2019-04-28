package lib.sro.info;

/**
 * ...
 * @author Sebastien roelandt
 */
class ScriptEvent
{
	private var observers:Array<ScriptObserver>;
	private var name:String;
	
	public function new(name:String) 
	{
		observers = new Array<ScriptObserver>();
		this.name = name;
	}
	
	public function register(observer:ScriptObserver) {
		observers.push(observer);
	}
	
	public function unregister(observer:ScriptObserver):Bool {
		return observers.remove(observer);
	}
	
	public function alert() {
		for (observer in observers) {
			observer.onAlert(name);
		}
	}
	
}