package vm

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

type Options struct {
	InputPath string
}

func Translate(options *Options) error {
	f, err := os.Open(options.InputPath)
	if err != nil {
		return err
	}
	defer f.Close()

	outputPath := strings.TrimSuffix(options.InputPath, ".vm") + ".asm"
	outputFile, err := os.Create(outputPath)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	filename := strings.TrimSuffix(filepath.Base(outputPath), ".asm")

	parser := NewParser(f, filename)
	for parser.HasMoreCommands() {
		cmd, err := parser.ParseCommand()
		if err != nil {
			return err
		}

		if _, err := fmt.Fprintln(outputFile, "// "+cmd.Raw()); err != nil {
			return err
		}

		if _, err := fmt.Fprintln(outputFile, strings.TrimSpace(cmd.Translate())+"\n"); err != nil {
			return err
		}
	}

	return nil
}