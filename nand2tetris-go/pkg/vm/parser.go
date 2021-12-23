package vm

import (
	"bufio"
	"io"
	"strings"
)

type Parser struct {
	scanner *bufio.Scanner
	state   *ParserState
}

func NewParser(r io.Reader) *Parser {
	scanner := bufio.NewScanner(r)
	return &Parser{scanner: scanner, state: &ParserState{}}
}

func (p *Parser) HasMoreCommands() bool {
	for p.scanner.Scan() {
		s := strings.TrimSpace(p.scanner.Text())
		if len(s) != 0 && !strings.HasPrefix(s, "//") {
			return true
		}
	}

	return false
}

func (p *Parser) ParseCommand() (Command, error) {
	s := p.scanner.Text()
	s = strings.TrimSpace(strings.SplitN(s, "//", 2)[0])
	return NewCommand(s, p.state)
}
