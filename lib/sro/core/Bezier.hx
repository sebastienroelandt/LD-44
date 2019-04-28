package lib.sro.core;

/**
 * ...
 * @author Sebastien roelandt
 */
enum BezierType {
	Linear;
	Simple;
	In;
	Out;	
	Fast;	
	FastIn;	
	FastOut;
	Zigzag;
	Random;
}
 
class Bezier
{
	private var type		:BezierType;
	
	public function new(type:BezierType) {
		if (type == null) {
			type = BezierType.Linear;
		}
		this.setType(type);
	}
	
	private function power2(n:Float) : Float {
		return n * n;
	}
	
	private function power3(n:Float) : Float {
		return n * n * n;
	}
	
	private function bezier(t:Float, x0:Float, x1:Float, x2:Float, x3: Float) : Float {
		return power3(1 - t) * x0 +
			3 * t * power2(1 - t) * x1 +
			3 * power2(t) * (1 - t) * x2 +
				power3(t) * x3;
	}
	
	private function random(t:Float) : Float {
		return 
			if (Std.random(100) < 33) 
				t
			else
				0;
	}
	
	private dynamic function calculate(v:Float) : Float {
		return v;
	}
	
	private function setType(type:BezierType) {
		this.type = type;
		this.calculate = switch(type) {
			case Simple		: function(v) return bezier(v, 0.00, 0.00, 1.00, 1.00);
			case In 		: function(v) return bezier(v, 0.00, 0.00, 0.50, 1.00);
			case Out		: function(v) return bezier(v, 0.00, 0.50, 1.00, 1.00);
			case Fast		: function(v) return bezier(v, 0.00, 1.00, 0.00, 1.00);
			case FastIn		: function(v) return bezier(v, 0.00, 1.00, 1.00, 1.00);
			case FastOut	: function(v) return bezier(v, 0.00, 0.00, 0.00, 1.00);
			case Zigzag		: function(v) return bezier(v, 0.00, 2.50,-1.50, 1.00);
			case Random		: function(v) return random(v);
			default			: function(v) return v;
		}
	}
	
	public function getValue(time:Float) : Float {
		return time > 1 ? -1.00 : calculate(time);
	}
}