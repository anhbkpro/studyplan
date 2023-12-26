package main

import (
	"fmt"
	"os"

	"github.com/anhbkpro/studyplan/gia/chapter3/words"
)

func main() {
	filename := os.Args[1]

	contents, err := os.ReadFile(filename)
	if err != nil {
		fmt.Println("These was an error reading the file", err)
		return
	}

	text := string(contents)
	count := words.CountWords(text)
	fmt.Printf("There are %d words in your text. \n", count)
}
