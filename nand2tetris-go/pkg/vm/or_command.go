package vm

type OrCommand struct {
	operation string
	state     *ParserState
}

func (c *OrCommand) Raw() string {
	return c.operation
}

const orTemplate = `
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = addr_y
D=M    // D = M[addr_y] = y
A=A-1  // A = 257 - 1 = addr_x
M=D|M  // M[addr_x] = y | x
@SP
M=M-1
`

func (c *OrCommand) Translate() string {
	return orTemplate
}
