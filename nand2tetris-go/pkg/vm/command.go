package vm

import (
	"fmt"
	"strconv"
	"strings"
)

type Command interface {
	Raw() string
	Translate() string
}

func newPushPopCommand(s string, state *ParserState) (Command, error) {
	tokens := strings.Split(s, " ")

	if len(tokens) != 3 {
		return nil, fmt.Errorf("expect 3 tokens but only got %d: %v", len(tokens), tokens)
	}

	arg2, err := strconv.Atoi(tokens[2])
	if err != nil {
		return nil, err
	}

	switch tokens[0] {
	case "push":
		return &PushCommand{raw: s, segment: tokens[1], index: arg2, state: state}, nil

	case "pop":
		return &PopCommand{raw: s, segment: tokens[1], index: arg2, state: state}, nil

	default:
		panic(fmt.Sprintf("not implemented: %s", s))
	}
}

func newArithmeticCommand(s string, state *ParserState) (Command, error) {
	tokens := strings.Split(s, " ")
	if len(tokens) != 1 {
		return nil, fmt.Errorf("expect single token but got %d: %v", len(tokens), tokens)
	}

	operation := tokens[0]

	switch operation {
	case "eq":
		return &EqCommand{operation, state}, nil

	case "lt":
		return &LtCommand{operation, state}, nil

	case "gt":
		return &GtCommand{operation, state}, nil

	case "add":
		return &AddCommand{operation, state}, nil

	case "sub":
		return &SubCommand{operation, state}, nil

	case "neg":
		return &NegCommand{operation, state}, nil

	case "and":
		return &AndCommand{operation, state}, nil

	case "or":
		return &OrCommand{operation, state}, nil

	case "not":
		return &NotCommand{operation, state}, nil

	default:
		panic(fmt.Sprintf("not implemented: %s", s))
	}
}

func NewCommand(s string, state *ParserState) (Command, error) {
	tokens := strings.Split(s, " ")

	switch tokens[0] {
	case "push", "pop":
		return newPushPopCommand(s, state)

	case "eq", "lt", "gt", "add", "sub", "neg", "and", "or", "not":
		return newArithmeticCommand(s, state)

	default:
		return nil, fmt.Errorf("unknown command: %s", s)
	}
}
