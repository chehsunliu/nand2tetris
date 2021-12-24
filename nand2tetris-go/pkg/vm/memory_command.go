package vm

import (
	"fmt"
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
M=M+1
`

func (c *PushCommand) translateConstant() string {
	data := struct{ Index int }{Index: c.index}
	return fillTemplate(pushConstantTemplate, data)
}

func (c *PushCommand) Translate() string {
	switch c.segment {
	case "constant":
		return c.translateConstant()

	default:
		return ""
	}
}

func (c *PushCommand) String() string {
	return fmt.Sprintf("push %s %d", c.segment, c.index)
}

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
