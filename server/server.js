
// Importing the required modules
const WebSocketServer = require('ws');

// Creating a new websocket server
const wss = new WebSocketServer.Server({ port: 3001 })

const SCORE_TIME = 10;
const MATCH_TIME = 90;

var timer = SCORE_TIME;
var match_status = "pause";

var fishing_spots = [];

var scoreboard = [];

const fish_spot_coords = [
	{x: 256, y: 896},
	{x: 928, y: 448},
	{x: 1632, y: 288},
	{x: 2368, y: 96},
	{x: 3168, y: 128},
	{x: 3712, y: 352},
	{x: 4288, y: 608},
	{x: 4640, y: 800},
	{x: 4640, y: 1120},
	{x: 3904, y: 1376},
	{x: 3424, y: 1664},
	{x: 2464, y: 1920},
	{x: 1792, y: 1888},
	{x: 1120, y: 1696},
	{x: 576, y: 1472},
	{x: 192, y: 1280},
];

const silly_first_names = [
	"Carlinhos",
	"Dalva",
	"Cleide",
	"Steve Agiota",
	"Bloop",
	"Ziggy",
	"Wobble",
	"Snork",
	"Flapjack",
	"Muffin",
	"Gizmo",
	"Fizz",
	"Booger",
	"Doodle",
	"Noodle",
	"Squiggle",
	"Tootsie",
	"Waffle",
	"Gloop",
	"Fizzy",
	"Bing",
	"Pookie",
	"Snuggle",
	"Tater",
	"Snazzy",
	"Wiggly",
	"Pickle",
	"Scooter",
	"Quirky",
	"Fluffy",
	"Mumbo",
	"Jumbo",
	"Wobblebottom",
	"Froggy",
	"Bubble",
	"Splat",
	"Chuckle",
	"Giggles",
	"Snickers",
	"Peanut",
	"Sprinkle",
	"Banjo",
	"Skippy",
	"Dippy",
	"Wiggles",
	"Bouncy",
	"Goofy",
	"Zonky",
	"Twinkle",
	"Plop",
	"Jiggly",
	"Kooky",
	"Squashy",
	"Dorky",
	"Floop",
	"Twiddly",
	"Gobbly",
	"Snappy",
	"Lolly",
	"Bibbly",
	"Zappy",
	"Hiccup",
	"Sneezy",
	"Yapper",
	"Flippy",
	"Crumpet",
	"Blubber",
	"Scrappy",
	"Grumbles",
	"Quackers",
	"Squirt",
	"Puddles",
	"Cuddles",
	"Biffy",
	"Zoodle",
	"Fuzzle",
	"Womble",
	"Skedaddle",
	"Wheezle",
	"Zonk",
	"Tumbles",
	"Wompy",
	"Yippee",
	"Bimble",
	"Sprocket",
	"Snickersnap",
	"Quibble",
	"Zazzy",
	"Frizzle",
	"Hokey",
	"Bonkers",
	"Lumpy",
	"Toodles",
	"Gribble",
	"Chortle",
	"Dweezle",
	"Fizzpop",
	"Puffin",
	"Moxie",
	"Bibbity",
	"Boopsie",
	"Snorkel",
	"Fuzzlewhack"
];

wss.on("connection", ws => {
	if (match_status == "pause") {
		match_status = "run";
		timer = SCORE_TIME;
		run_timer();
		spawn_fish(5);
	}

	//code that should execute just after the player connects
	console.log("Player joined. " + wss.clients.size + " players connected.");
	// ws.id = silly_first_names[Math.round(Math.random() * silly_first_names.length)];
	ws.id = Math.round(Math.random() * 15000);
	console.log(ws.id);
	ws.x = 2178.0 + Math.random() * 60;
	ws.y = 962.0 + Math.random() * 60;

	var data = {
		"type": "load_instances",
		"players": [],
		"own_id": ws.id
	};

	wss.clients.forEach (function each(client) {
		data.players.unshift({
			"id": client.id,
			"x": client.x,
			"y": client.y
		});
	});
	ws.send(JSON.stringify(data), { binary: false });

	data = JSON.stringify({
		"type": "new_player",
		"id": ws.id,
		"x": ws.x,
		"y": ws.y
	});

	try {
		wss.clients.forEach(function each(client) {
			if (client !== ws && client.readyState === WebSocketServer.OPEN) {
				client.send(data, { binary: false });
			}
		});
	} catch (error) {
		console.log(error);
	}

	//when the client sends us a message
	ws.on("message", data => {
		try {
			data = data.toString();
			data = data.replace(/\0/g, '');
			data = [data.slice(0, 1), "\"id\":\"" + ws.id + "\",", data.slice(1)].join('');
			data_json = JSON.parse((data));
			// console.log(data_json);
			if (data_json.type == "keep_alive") {
				ws.send(JSON.stringify({"type": "keep_alive"}), {binary: false});
				return;
			// } else if (data_json.type == "cutting_tree") {
			// 	console.log("cutting_tree");
			// 	// Nothing to do for now
			// } else if (data_json.type == "cut_tree") {
			// 	console.log(data_json.network_id);
			// 	var tree_found = false;
			// 	trees.forEach(function (item, key) {
			// 		if (item.network_id != data_json.network_id) return;
			// 		trees.splice(key, 1);
			// 	});
			// 	if (!tree_found) {
			// 		console.log("Tree not found");
			// 		return false;
			// 	}
			// } else if (data_json.type == "place_bomb") {
			// 	bombs.unshift({
			// 		owner: ws.id,
			// 		network_id: data_json.network_id
			// 	});
			// } else if (data_json.type == "detonate_bomb") {
			// 	console.log(data_json.network_id);
			// 	var bomb_found = false;
			// 	bombs.forEach(function (item, key) {
			// 		if (item.network_id != data_json.network_id) return;
			// 		bombs.splice(key, 1);
			// 	});
			// 	if (!bomb_found) {
			// 		console.log("Tree not found");
			// 		return false;
			// 	}
			// }  else if (data_json.type == "create_house") {
			// 	console.log(data_json);
			// 	houses.unshift({
			// 		owner: ws.id,
			// 		network_id: data_json.network_id
			// 	});
			// 	console.log(houses);
			} else if (data_json.type == "score") {
				scoreboard[ws.id] = data_json.score;
				scoreboard.sort(function(a, b){return a - b});
				console.log(scoreboard);
				return;
			} else {

			}

			wss.clients.forEach(function each(client) {
				if (client !== ws && client.readyState === WebSocketServer.OPEN) {
					client.send(data, { binary: false });
				}
			});
			
			if (data_json.x && data_json.y) {
				ws.x = data_json.x;
				ws.y = data_json.y;
				// console.log(ws.x);
				// console.log(ws.y);
			}
		} catch (error) {
			console.log(error);
			console.log(data);
		}
	})

	// handling what to do when clients disconnects from server
	ws.on("close", () => {
		if (wss.clients.size == 0) {
			match_status = "pause";
		}
		console.log("Player left. " + wss.clients.size + " players left.");
		wss.clients.forEach(function each(client) {
			client.send("{\"type\":\"disconnect\",\"id\":" + ws.id + "}", { binary: false });
		});
		console.log(scoreboard);
		scoreboard.splice(ws.id, 1);
	})

	// handling client connection error
	ws.onerror = function () {
		console.log("Some Error occurred");
	}
});

console.log("The WebSocket server is running");

function makeid(length) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    let counter = 0;
    while (counter < length) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
      counter += 1;
    }
    return result;
}

function run_timer () {
	// console.log(timer);
	// console.log(match_status);

	if (match_status == "pause") return;

	if (match_status == "score") {
		var fmt_score = ``;
		for (let i in scoreboard) {
			fmt_score += i + `: ` + scoreboard[i] + `\n`;
		}

		var final_score = {
			arr_score: scoreboard,
			fmt_score: fmt_score
		};
	}

	if (timer > 0) {
		timer--;
		try {
			data = {
				"type": "timer",
				"timer": timer,
				"match_status": match_status
			};

			if (match_status == "score") {
				data.final_score = final_score;
			} else if (match_status == "run") {
				spawn_fish(Math.round(Math.random()));
			}

			data = JSON.stringify(data);
			wss.clients.forEach(function each(client) {
				client.send()
				client.send(data, { binary: false });
			});
		} catch (error) {
			console.log(error);
		}

		setTimeout(function () {
			run_timer();
		}, 1000);

		return;
	}

	if (match_status == "run") {
		match_status = "score";
		timer = SCORE_TIME;
	} else if (match_status == "score") {
		match_status = "run";
		timer = MATCH_TIME;
		fishing_spots = [];

		scoreboard = [];
	}
	run_timer();
}

function format_scoreboard () {
	scoreboard_formatted = "";

	// Convert to an array of key-value pairs, sort it, then convert it back
	var ordered_score = Object.entries(scoreboard)
		.sort((a, b) => b[1] - a[1]); // Sort by score (value), descending

	var place = 1;
	for (let i in ordered_score) {
		scoreboard_formatted += place + ") " + i + `: ` + scoreboard[i] + `\n`;
		place++;
	}
}

function spawn_fish (number_to_spawn) {
	try {
		if (number_to_spawn == 0) return;
		for (i = 1; i <= number_to_spawn; i++) {
			var coords = fish_spot_coords[Math.round(Math.random() * fish_spot_coords.length)];
			coords.x += Math.round(Math.random() * 60);
			coords.y += Math.round(Math.random() * 60);
			coords.id = Math.round(Math.random() * 999999);
			console.log("Fishing coords generated");
			console.log(coords);
			fishing_spots.unshift(coords);

			if (fishing_spots.length >= 16) {
				fishing_spots.pop();
			}
		}
		
		var data = {
			"type": "fishing_spots",
			"fishing_spots": fishing_spots,
		};
		data = JSON.stringify(data);
		wss.clients.forEach(function each(client) {
			if (client.readyState === WebSocketServer.OPEN) {
				client.send(data, { binary: false });
			}
		});
	} catch (error) {
		console.log(error);
	}
}