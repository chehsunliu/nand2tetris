package vm

import (
	"fmt"
	"strings"
)

type Command interface {
	Raw() string
	Translate() string
}

type NotImplementedCommand struct {
	raw string
}

func (n *NotImplementedCommand) Raw() string {
	return n.raw
}

func (n *NotImplementedCommand) Translate() string {
	return ""
}

func NewArithmeticCommand(operation string, state *ParserState) Command {
	switch operation {
	case "eq":
		return &EqCommand{operation, state}

	case "add":
		return &AddCommand{operation, state}

	default:
		panic(fmt.Sprintf("not implemented: %s", operation))
	}
}

func NewCommand(s string, state *ParserState) (Command, error) {
	tokens := strings.Split(s, " ")

	switch tokens[0] {
	case "push":
		return NewPushCommand(s, state)

	case "pop":
		return NewPopCommand(s, state)

	case "eq", "add":
		if len(tokens) != 1 {
			return nil, fmt.Errorf("expect single token but got %d: %v", len(tokens), tokens)
		}

		return NewArithmeticCommand(s, state), nil

	case "sub", "neg", "gt", "lt", "and", "or", "not":
		return &NotImplementedCommand{raw: s}, nil

	default:
		return nil, fmt.Errorf("unknown command: %s", s)
	}
}
