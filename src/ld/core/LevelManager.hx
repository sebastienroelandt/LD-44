package ld.core;

/**
 * Classe qui doit renvoyer les contrats, les cibles et les tips à afficher
 * 
 * @author Roelandt Sebastien
 */
typedef Level = {
	contracts : Array<{color: String, value: Int}>,
	targets : Array<{color: String, quantity: Int}>,
	instructions : Array<String>,
	timer: Int,
	munitions: Int
}
 
class LevelManager
{
	static var currentLevel = 0;
	
	static var levelsContracts = [
		[
			// Level 1
			{color: "blue", value: 400}
		],
		[
			// Level 2
			{color: "red", value: 100}
		],
		[
			// Level 3
			{color: "red", value: 30}
		],
		[
			// Level 4
			{color: "green", value: 60},
			{color: "red", value: 30},
			{color: "blue", value: -30},
		],
		[
			// Level 5
			{color: "yellow", value: 30},
			{color: "blue", value: 10},
			{color: "green", value: -50}
		],
		[
			// Level 6
			{color: "yellow", value: 400},
			{color: "blue", value: -100}
		],
		[
			// Level 7
			{color: "blue_cross", value: 60},
			{color: "blue_square", value: -30}
		],
		[
			// Level 8
			{color: "blue", value: 150},
			{color: "yellow", value: 30},
			{color: "blue_point", value: -50}
		],
		[
			// Level 9
			{color: "red", value: 40}
		],
		[
			// Level 10
			{color: "yellow", value: 500}
		],
		[
			// Level 11
			{color: "blue_point", value: 40},
			{color: "red_square", value: 40}
		],
		[
			// Level 12
			{color: "blue", value: 30}
		],
		[
			// Level 13
			{color: "chameleon", value: 600}
		]
	];
	
	static var levelsTargets = [
		[
			// Level 1
			{color: "red", quantity: 1},
			{color: "blue", quantity: 1}
		], 
		[
			// Level 2
			{color: "red", quantity: 5},
			{color: "blue", quantity: 10}
		], 		
		[
			// Level 3
			{color: "red", quantity: 20},
			{color: "blue", quantity: 40}
		], 		
		[
			// Level 4
			{color: "green", quantity: 5},
			{color: "red", quantity: 15},
			{color: "blue", quantity: 20}
		],
		[
			// Level 5
			{color: "green", quantity: 20},
			{color: "red", quantity: 20},
			{color: "blue", quantity: 20},
			{color: "yellow", quantity: 20}
		],
		[
			// Level 6
			{color: "blue", quantity: 200},
			{color: "yellow", quantity: 1}
		],
		[
			// Level 7
			{color: "blue_cross", quantity: 15},
			{color: "blue_square", quantity: 30},
			{color: "blue_point", quantity: 30}
		],
		[
			// Level 8
			{color: "blue", quantity: 1},
			{color: "yellow", quantity: 15},
			{color: "green", quantity: 20},
			{color: "blue_point", quantity: 8}
		],
		[
			// Level 9
			{color: "yellow", quantity: 10},
			{color: "green", quantity: 15},
			{color: "red", quantity: 20},
			{color: "tnt", quantity: 8}
		],
		[
			// Level 10
			{color: "yellow", quantity: 1},
			{color: "tnt", quantity: 300}
		],
		[
			// Level 11
			{color: "blue_square", quantity: 20},
			{color: "blue_cross", quantity: 20},
			{color: "blue_point", quantity: 20},
			{color: "red_square", quantity: 20},
			{color: "red_cross", quantity: 20},
			{color: "red_point", quantity: 20},
		],
		[
			// Level 12
			{color: "blue", quantity: 200},
			{color: "tnt", quantity: 40},
		],
		[
			// Level 13
			{color: "blue", quantity: 10},
			{color: "red", quantity: 10},
			{color: "purple", quantity: 10},
			{color: "gray", quantity: 10},
			{color: "green", quantity: 10},
			{color: "yellow", quantity: 10},
			{color: "brown", quantity: 10},
			{color: "tnt", quantity: 2},
			{color: "chameleon", quantity: 2}
		]
	];
	
	static var levelsInstruction = [
		[
			// Level 1
			'"CATCH THEM ALL !" \n\n' +
			'Ludum dare 44\n\n' +
			'48h game created by Sebastien Roelandt',
			
			'CONTROL\n\n' +
			'Mouse : \n' +
			'- Move to target the little monsters\n' +
			'- Left click to use weapon',
			
			'TIPS\n\n' +
			'- Top: Prices of your targets\n' +
			'- Left: Time before they see you and below the number of shoots you have\n' +
			'- Right: Your current score !\n' +
			'Your boss is not very happy, I hope that you will earn enough this time !'
			
		], 
		[	
			'TIP \n\n' +
			'Unfortunately, on each level, you have to use your own weapon and spaceship... And it will cost you\n200 !'
		], 
		[], 
		[	
			'TIP \n\n' +
			'Red coin : sometimes, the value of a monster may be so low that it\'s not profitable to catch them !'
		], 
		[], 
		[], 
		[], 
		[], 
		[
			// 9
			'TIP \n\n' +
			'Some look like TNT ! I think it\'s not a good idea to catch them !'
		], 
		[], 
		[], 
		[], 
		[
			// 13
			'TIP \n\n' +
			'[chameleon] \nThe most uncommun : a Chameleon ! He can change this color !'
		]
	];
	
	static var levelsTimers = [
		10,
		10,
		15,
		10,
		10,
		10,
		14,
		15, //8
		10, //9
		15, //10
		20, //11
		5,  // 12
		20 //13
	];
	
	static var levelsMunitions = [
		1,
		3,
		6,
		5,
		7,
		1,
		7,
		5, //8
		5, //9
		1, //10
		10, //11
		10, //12
		1
	];
	
	static public function getNextLevel() : Level {
		var data : Level;
		if (currentLevel >= levelsContracts.length) {
			data = null;
		} else {
			data = {
				contracts : levelsContracts[currentLevel],
				targets : levelsTargets[currentLevel],
				instructions : levelsInstruction[currentLevel],
				timer : levelsTimers[currentLevel] * 1000,
				munitions : levelsMunitions[currentLevel]
			};
		}
		
		currentLevel ++;
		return data;
	}
	

	
}