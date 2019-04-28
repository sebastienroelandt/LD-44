package ld.screen.layer;

import ld.engine.Target;
import ld.event.IInfoDisplayClosedListener;
import ld.screen.layer.base.InfoDisplayLayer;
import openfl.text.TextField;
import lib.sro.core.Text;
import lib.sro.core.Bresenham;
import ld.core.StringUtils;

/**
 * ...
 * @author Roelandt Sebastien
 */
class ConclusionLayer extends InfoDisplayLayer
{
	static var ROUND_COST = 200;
	static var SPACESHIP_COST = 800;
	static var TYPE = "CONCLUSION";
	
	var beginDisplayTimer: Float;
	var isBeginDisplay: Bool;
	var targetDisplayed: Int;
	var nextTargetDisplayedTimer: Float;
	
	var targets: Array<Target>;
	var contracts: Array<{color: String, value: Int}>;
	
	var scoreRoundTextField : TextField;
	var scoreRound : Int;
	
	var nextTextFieldTimer: Float;
	
	var isExpenseUpdated : Bool;
	var expenceRoundTextField : TextField;
	
	var isTotalUpdated : Bool;
	var total: Int;
	var totalTextField : TextField;
	
	var isSpaceshipDestroyed: Bool;
	
	public function new(targets: Array<Target>, contracts: Array<{color: String, value: Int}>, 
		total: Int, isSpaceshipDestroyed: Bool) 
	{
		super("messageBackground", 600, 300, 10);
		
		this.x = 100;
		this.y = 200;
		this.isSpaceshipDestroyed = isSpaceshipDestroyed;
		
		displayClose(false);
		
		var index = 0;
		for (target in targets) {
			target.visible = false;
			target.x = 15 + 35 * (index % 16);
			target.y = 15 + Std.int(index/16) * 30;
			target.displayProfil();
			this.addChild(target);
			index ++;
		}
		
		isBeginDisplay = false;
		beginDisplayTimer = 500;
		targetDisplayed = 0;
		
		nextTargetDisplayedTimer = 1000;
		this.targets = targets;
		this.contracts = contracts;
		
		var text = Text.createText("Minecraftia.ttf", 24);
		text.x = 200;
		text.y = 80;
		text.text = "Gain";
		this.addChild(text);
		this.scoreRound = 0;
		this.scoreRoundTextField = Text.createText("Minecraftia.ttf", 24);
		this.scoreRoundTextField.x = 305;
		this.scoreRoundTextField.y = 80;
		updateScoreRoundTextField();
		this.addChild(this.scoreRoundTextField);
		
		nextTextFieldTimer = 0;
		
		var text = Text.createText("Minecraftia.ttf", 24);
		text.x = 200;
		text.y = 110;
		text.text = "Cost";
		this.addChild(text);
		this.isExpenseUpdated = false;
		this.expenceRoundTextField = Text.createText("Minecraftia.ttf", 24);
		this.expenceRoundTextField.x = 305;
		this.expenceRoundTextField.y = 110;
		this.expenceRoundTextField.text = " 0000";
		this.addChild(this.expenceRoundTextField);
		
		
		var text = Text.createText("Minecraftia.ttf", 24);
		text.x = 200;
		text.y = 140;
		text.text = "Total";
		this.addChild(text);
		this.isTotalUpdated = false;
		this.total = total;
		this.totalTextField = Text.createText("Minecraftia.ttf", 24);
		this.totalTextField.x = 305;
		this.totalTextField.y = 140;
		this.totalTextField.text = intToString(total, 4);
		this.addChild(this.totalTextField);
		
		this.visible = true;
	}
	
	private function displayClose(display: Bool) {
		close.defaultMessage.visible = display;
		close.shadowLeft.visible = display;
		close.shadowRight.visible = display;
		close.shadowTop.visible = display;
		close.shadowBottom.visible = display;
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (isBeginDisplay) {
			if (targetDisplayed == targets.length) {
				nextTextFieldTimer += delta;
				if (nextTextFieldTimer > 500 && !this.expenceRoundTextField.visible) {
					this.expenceRoundTextField.visible = true;
				} else if (nextTextFieldTimer > 1000 && !isExpenseUpdated) {
					this.expenceRoundTextField.text = intToString(getCost(), 4);
					this.isExpenseUpdated = true;
				} else if (nextTextFieldTimer > 1500 && !isTotalUpdated) {
					this.isTotalUpdated = true;
					this.total = this.total + scoreRound - getCost();
					if (this.total < 0) {
						this.totalTextField.x = 302;
					} else {
						this.totalTextField.x = 305;
					}
					this.totalTextField.text = intToString(total, 4);
				} else if (this.expenceRoundTextField.visible && isExpenseUpdated && isTotalUpdated) {
					nextTextFieldTimer = 0;
					if (!close.defaultMessage.visible) {
						close.defaultMessage.visible = true;
					}
				}
			} else {
				nextTargetDisplayedTimer -= delta;
				if (nextTargetDisplayedTimer < 0) {
					nextTargetDisplayedTimer = 500;
					targets[targetDisplayed].visible = true;
					updateCurrentScore(targets[targetDisplayed]);
					targetDisplayed ++;
				}
			}
		} else {
			beginDisplayTimer -= delta;
			if (beginDisplayTimer < 0) {
				beginDisplayTimer = 0;
				isBeginDisplay = true;
			}
		}
	}
	
	private function getCost():Int {
		var result = ROUND_COST;
		if (isSpaceshipDestroyed) {
			result = ROUND_COST + SPACESHIP_COST;
		}
		return result;
	}
	
	private function updateCurrentScore(target: Target) {
		var value = getValueOf(target);
		scoreRound += value;
		updateScoreRoundTextField();
	}
	
	private function updateScoreRoundTextField() {
		var scoreRoundText = intToString(scoreRound, 4);
		this.scoreRoundTextField.text = scoreRoundText;
	}
	
	private function intToString(value: Int, length: Int): String {
		return StringUtils.intToString(value, length);
	}
	
	private function getValueOf(target: Target) {
		for (contract in contracts) {
			if (contract.color == target.getColor()) {
				return contract.value;
			}
		}
		return 0;
	}
	
	public function getTotal() {
		return this.total;
	}
	
	override public function getType():String 
	{
		return ConclusionLayer.TYPE;
	}
	
	
}