package ld.screen.layer;

import ld.event.IAlertListener;
import ld.event.ITimeOutListener;
import ld.screen.layer.sub.ContractSubLayer;
import lib.sro.layers.DrawableLayer;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;
import lib.sro.core.Text;
import lib.sro.core.GameController;
import lib.sro.input.Keys;
import openfl.ui.Keyboard;
import ld.core.StringUtils;

/**
 * ...
 * @author Roelandt Sebastien
 */
class WantedLayer extends DrawableLayer
{
	var contracts : Array<ContractSubLayer>;
	var time : Float;
	var timeOutListener: ITimeOutListener;
	
	var secondTimer : TextField;
	var milliSecondTimer : TextField;
	
	var munitions : Array<Bitmap>;
	var munitionsQuantity : Int;
	
	var alertListener: IAlertListener;
	
	var score : Int;
	var scorefield : TextField;
	
	var threeSecond: Bool;
	var twoSecond: Bool;
	var oneSecond: Bool;
	
	var isTimerLaunch: Bool;
	
	public function new() 
	{
		super();
		addBackground();
		
		this.contracts = new Array<ContractSubLayer>();
		this.time = -1;
		this.timeOutListener = null;
		initTimer();
		initMunitions();
		initScore();
		resetSecondAlerts();
		
		displayContracts([]);
		isTimerLaunch = false;
	}
	
	private function initTimer() {
		this.secondTimer = Text.createText("Minecraftia.ttf", 24);
		this.secondTimer.x = 10;
		this.secondTimer.y = 5;
		this.secondTimer.text = "00";
		this.addChild(this.secondTimer);
		this.milliSecondTimer = Text.createText("Minecraftia.ttf", 16, 0xDDDDDD);
		this.milliSecondTimer.x = 45;
		this.milliSecondTimer.y = 8;
		this.milliSecondTimer.text = "00";
		this.addChild(this.milliSecondTimer);
	}
	
	private function initMunitions() {
		munitionsQuantity = 10;
		munitions = new Array<Bitmap>();
		for (i in 0...10) {
			var munition = new Bitmap(GameController.assets.getBitmapData("munition"));
			munition.x = i * 20 + 10;
			munition.y = 43;
			this.addChild(munition);
			munitions.push(munition);
		}
	}
	
	private function initScore() {
		this.score = 0;
		this.scorefield = Text.createText("Minecraftia.ttf", 24);
		this.scorefield.x = 685;
		this.scorefield.y = 5;
		updateScore();
		this.addChild(scorefield);
	}
	
	private function resetSecondAlerts() {
		threeSecond = false;
		twoSecond = false;
		oneSecond = false;
	}
	
	public function displayContracts(infos : Array<{color: String, value: Int}>) {
		for (contract in contracts) {
			this.remove(contract);
		}
		contracts = new Array<ContractSubLayer>();
		
		for (info in infos) {
			var contact = new ContractSubLayer(info.color, info.value);
			//contact.x = contracts.length * (68 + 20) + 800/2 - (infos.length * (68 + 20))/2;
			var totalWidth = 75 * infos.length + 20 * (infos.length - 1);
			var beginPoint = 800 / 2 - totalWidth / 2;
			contact.x = beginPoint + ((75 + 20 ) * contracts.length);
			this.add(contact);
			contracts.push(contact);
		}
	}
	
	private function addBackground() {
		var background = new Sprite();
		background.graphics.beginFill(0x3e4d71);
		background.graphics.drawRect(0, 0, 800, 70);
		background.graphics.endFill();
		this.addChild(background);
	}
	
	public function resetTimer(time: Float) {
		this.time = time;
		resetSecondAlerts();
		updateTimerValue();
	}
	
	public function start() {
		this.isTimerLaunch = true;
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (isTimerLaunch) {
			this.time -= delta;
			if (time < 0) {
				fireTimeOutEvent();
				this.time = 0;
				isTimerLaunch = false;
			}
			
			updateTimerValue();
			
			var seconds = Math.floor(this.time / 1000);
			if (seconds <= 2 && !threeSecond) {
				threeSecond = true;
				fireAlertEvent();
			}
			
			if (seconds <= 1 && !twoSecond) {
				twoSecond = true;
				fireAlertEvent();
			}
			
			if (seconds <= 0 && !oneSecond) {
				oneSecond = true;
				fireAlertEvent();
			}
		}
	}
	
	private function updateTimerValue() {
		var seconds = Math.floor(this.time / 1000);
		if (seconds < 10) {
			this.secondTimer.text = "0" + seconds;
		} else {
			this.secondTimer.text = "" + seconds;
		}
		
		var milliseconds = Math.floor(this.time / 10) - seconds * 100;
		if (milliseconds < 10) {
			this.milliSecondTimer.text = "0" + milliseconds;
		} else {
			this.milliSecondTimer.text = "" + milliseconds;
		}
	}
	
	private function fireTimeOutEvent() {
		if (timeOutListener != null) {
			timeOutListener.onTimeOut();
		}
	}
	
	public function setTimeOutListener(listener: ITimeOutListener) {
		this.timeOutListener = listener;
	}
	
	public function resetMunitions(quantity: Int) {
		munitionsQuantity = quantity;
		for (i in 0...10) {
			munitions[i].visible = i < quantity;
		}
	}
	
	public function useMunition() {
		if (munitionsQuantity != 0) {
			munitionsQuantity --;
			munitions[munitionsQuantity].visible = false;
		}
	}
	
	public function getMunitionsQuantity() {
		return munitionsQuantity;
	}
	
	public function setAlertListener(alertListener: IAlertListener) {
		this.alertListener = alertListener;
	}
	
	private function fireAlertEvent() {
		if (this.alertListener != null) {
			this.alertListener.onAlert();
		}
	}
	
	public function getScore() {
		return this.score;
	}
	
	public function setScore(score) {
		this.score = score;
		updateScore();
	}
	
	private function updateScore() {
		scorefield.text = StringUtils.intToString(score, 4);
	}
	
	public function getContracts(): Array<{color: String, value: Int}> {
		var result = new Array<{color: String, value: Int}>();
		for (contract in contracts) {
			result.push({color: contract.getColor(), value: contract.getValue()});
		}
		return result;
	}	
	
	public function pauseTimer() {
		isTimerLaunch = false;
	}
}