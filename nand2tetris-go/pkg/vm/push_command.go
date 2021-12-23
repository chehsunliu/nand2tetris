package vm

import (
	"fmt"
	"strconv"
	"strings"
)

type PushCommand struct {
	raw     string
	segment string
	index   int
	state   *ParserState
}

func (c *PushCommand) Raw() string {
	return c.raw
}

const pushConstantTemplate = `
@{{ .Index }}
D=A
@SP
A=M
M=D
@SP
M=M+1`

func (c *PushCommand) translateConstant(index int) string {
	data := struct{ Index int }{Index: index}
	return fillTemplate(pushConstantTemplate, data)
}

func (c *PushCommand) Translate() string {
	switch c.segment {
	case "constant":
		return c.translateConstant(c.index)

	default:
		return ""
	}
}

func (c *PushCommand) String() string {
	return fmt.Sprintf("push %s %d", c.segment, c.index)
}

func NewPushCommand(s string, state *ParserState) (*PushCommand, error) {
	tokens := strings.Split(s, " ")

	if len(tokens) != 3 {
		return nil, fmt.Errorf("expect 3 tokens but only got %d: %v", len(tokens), tokens)
	}

	arg2, err := strconv.Atoi(tokens[2])
	if err != nil {
		return nil, err
	}

	return &PushCommand{raw: s, segment: tokens[1], index: arg2, state: state}, nil
}
