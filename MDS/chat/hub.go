// Copyright 2013 The Gorilla WebSocket Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package main

import (
	"log"
	"strconv"
)

// Hub maintains the set of active clients and broadcasts messages to the
// clients.
type Hub struct {
	// Registered clients.
	clients map[*Client]bool

	// Inbound messages from the clients.
	broadcast chan []byte

	// Register requests from the clients.
	register chan *Client

	// Unregister requests from clients.
	unregister chan *Client

	game       *Game
	joinQueue  chan *Client
	leaveQueue chan *Client
}

func newHub() *Hub {
	return &Hub{
		broadcast:  make(chan []byte),
		register:   make(chan *Client),
		unregister: make(chan *Client),
		clients:    make(map[*Client]bool),
		game:       new(Game),
		joinQueue:  make(chan *Client),
		leaveQueue: make(chan *Client),
	}
}

// Player contains details about the player
type Player struct {
	client *Client
	role   int
}

func newPlayer(client *Client, role int) *Player {
	return &Player{
		client: client,
		role:   role,
	}

}

// Game maintains the state of the game
type Game struct {
	players   map[*Player]bool
	freeSlots int
	freeRoles []int
}

func newGame() *Game {
	return &Game{
		players:   make(map[*Player]bool),
		freeSlots: 3,
		freeRoles: make([]int, 2),
	}

}

func (h *Hub) run() {
	for {
		select {
		case client := <-h.register:
			h.clients[client] = true
		case client := <-h.unregister:
			if _, ok := h.clients[client]; ok {
				delete(h.clients, client)
				close(client.send)
			}
		case message := <-h.broadcast:
			for client := range h.clients {
				select {
				case client.send <- message:
				default:
					close(client.send)
					delete(h.clients, client)
				}
			}
		case client := <-h.joinQueue:
			if h.game.freeSlots < 3 {
				var player = newPlayer(client, 0)
				h.game.players[player] = true
				h.game.freeSlots--
				var message = "Joined queue " + strconv.Itoa(h.game.freeSlots) + " /3"
				log.Println(message)
				var x = []byte(message)
				for player := range h.game.players {
					select {
					case player.client.send <- x:
					default:
						close(player.client.send)
						delete(h.clients, player.client)
						delete(h.game.players, player)
					}
				}
			}
		case client := <-h.leaveQueue:
			if h.game.freeSlots > 0 {
				var player *Player
				for x := range h.game.players {
					if x.client == client {
						player = x
					}
				}
				delete(h.game.players, player)
				h.game.freeSlots++
				var message = "Leaved queue " + strconv.Itoa(h.game.freeSlots) + " /3"
				var x = []byte(message)
				for player := range h.game.players {
					select {
					case player.client.send <- x:
					default:
						close(player.client.send)
						delete(h.clients, player.client)
						delete(h.game.players, player)
					}
				}
			}
		}
	}
}
