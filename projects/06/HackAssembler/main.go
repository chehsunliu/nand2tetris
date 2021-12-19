package main

import (
	"log"
	"os"
	"regexp"

	"github.com/chehsunliu/hack-assembler/assemble"
)

func main() {
	if len(os.Args) != 2 {
		log.Fatalf("%s FILE\n", os.Args[0])
	}
	filepath := os.Args[1]

	f, err := os.Open(filepath)
	if err != nil {
		log.Fatalln(err)
	}
	defer f.Close()

	generator, err := assemble.NewAssembler(f)
	if err != nil {
		log.Fatalln(err)
	}

	pattern := regexp.MustCompile(`\.asm$`)
	f, err = os.Create(pattern.ReplaceAllString(filepath, ".hack"))
	if err != nil {
		log.Fatalln(err)
	}

	for generator.HasNext() {
		if _, err := f.WriteString(generator.Generate() + "\n"); err != nil {
			log.Fatalln(err)
		}
	}
}
