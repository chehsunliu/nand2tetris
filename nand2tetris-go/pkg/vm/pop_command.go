package vm

import (
	"fmt"
	"strconv"
	"strings"
)

type PopCommand struct {
	raw     string
	segment string
	index   int
	state   *ParserState
}

func (c *PopCommand) Raw() string {
	return c.raw
}

func (c *PopCommand) Translate() string {
	return ""
}

func (c *PopCommand) String() string {
	return fmt.Sprintf("pop %s %d", c.segment, c.index)
}

func NewPopCommand(s string, state *ParserState) (*PopCommand, error) {
	tokens := strings.Split(s, " ")

	if len(tokens) != 3 {
		return nil, fmt.Errorf("expect 3 tokens but only got %d: %v", len(tokens), tokens)
	}

	arg2, err := strconv.Atoi(tokens[2])
	if err != nil {
		return nil, err
	}

	return &PopCommand{raw: s, segment: tokens[1], index: arg2, state: state}, nil
}
