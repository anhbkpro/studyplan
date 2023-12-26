package main

import (
	"log"
	"os"

	_ "github.com/anhbkpro/studyplan/gia/chapter2/matchers"
	"github.com/anhbkpro/studyplan/gia/chapter2/search"
)

func init() {
	log.SetOutput(os.Stdout)
}

func main() {
	// Perform the search for the specified term.
	search.Run("president")
}
