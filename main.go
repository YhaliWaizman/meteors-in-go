package main

import (
	"github.com/YhaliWaizman/meteors-in-go/game"
	"github.com/hajimehoshi/ebiten/v2"
)

func main() {
	g := game.NewGame()

	err := ebiten.RunGame(g)
	if err != nil {
		panic(err)
	}
}
