
// Importing the required modules
const WebSocketServer = require('ws');

// Creating a new websocket server
const wss = new WebSocketServer.Server({ port: 3001 })

const SCORE_TIME = 15;
const MATCH_TIME = 15;

var timer = SCORE_TIME;
var match_status = "pause";

wss.on("connection", ws => {
	if (match_status == "pause") {
		match_status = "score";
		timer = SCORE_TIME;
	}
	run_timer();

	//code that should execute just after the player connects
	console.log("Player joined. " + wss.clients.size + " players connected.");
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
			if (client !== ws && client.readyState === WebSocket.OPEN) {
				client.send(data, { binary: false });
			}
		});
	} catch (error) {
		console.log(error);
		console.log(client);
	}

	//when the client sends us a message
	ws.on("message", data => {
		try {
			data = data.toString();
			data = data.replace(/\0/g, '');
			data = [data.slice(0, 1), "\"id\":" + ws.id + ",", data.slice(1)].join('');
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
			} else {

			}

			wss.clients.forEach(function each(client) {
				if (client !== ws && client.readyState === WebSocket.OPEN) {
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
	console.log(timer);
	console.log(match_status);

	if (match_status == "pause") return;

	if (timer > 0) {
		timer--;
		try {
			data = JSON.stringify({
				"type": "timer",
				"timer": timer,
				"match_status": match_status
			});
			wss.clients.forEach(function each(client) {
				client.send()
				client.send(data, { binary: false });
			});
		} catch (error) {
			console.log(error);
			console.log(client);
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
	}
	run_timer();
}