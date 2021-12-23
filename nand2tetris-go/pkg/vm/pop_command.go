package vm

import (
	"fmt"
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
