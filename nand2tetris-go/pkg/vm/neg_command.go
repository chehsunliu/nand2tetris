package vm

type NegCommand struct {
	operation string
	state     *ParserState
}

func (c *NegCommand) Raw() string {
	return c.operation
}

const negTemplate = `
@SP    // A = SP = 0
A=M    // A = M[0] = addr_sp
A=A-1  // A = 258 - 1 = addr_y
M=-M   // M[addr_y] = -y
`

func (c *NegCommand) Translate() string {
	return negTemplate
}
