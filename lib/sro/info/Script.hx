package lib.sro.info;

/**
 * ...
 * @author Sebastien roelandt
 */
class Script
{
	private var scriptEvents		:Map<String,ScriptEvent>;
	
	public function new() 
	{
		scriptEvents = new Map();
	}
	
	public function addScriptEvent(name:String):ScriptEvent {
		var scriptEvent = new ScriptEvent(name);
		scriptEvents.set(name, scriptEvent);
		return scriptEvent;
	}
	
	public function register(observer:ScriptObserver, scriptEventName:String) {
		var scriptEvent:ScriptEvent = scriptEvents.get(scriptEventName);
		if (scriptEvent == null) {
			scriptEvent = addScriptEvent(scriptEventName);
		}
		scriptEvent.register(observer);
	}
	
	public function unregister(observer:ScriptObserver, scriptEventName:String) {
		var scriptEvent:ScriptEvent = scriptEvents.get(scriptEventName);
		if (scriptEvent != null ) {
			scriptEvent.unregister(observer);
		}
	}
	
	public function unregisterAll(observer:ScriptObserver) {
		var iterator = scriptEvents.iterator();
		while (iterator.hasNext()) {
			var scriptEvent:ScriptEvent = iterator.next();
			if (scriptEvent != null) {
				scriptEvent.unregister(observer);
			}
		}
	}
	
	public function alert(scriptEventName:String) {
		var scriptEvent:ScriptEvent = scriptEvents.get(scriptEventName);
		if (scriptEvent != null ) {
			scriptEvent.alert();
		}
	}
	
}