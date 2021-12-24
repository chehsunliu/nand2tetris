package vm

type AddCommand struct {
	operation string
	state     *ParserState
}

func (c *AddCommand) Raw() string {
	return c.operation
}

const addTemplate = `
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 8
A=A-1  // A = 257 - 1 = 256
M=D+M  // M[256] = 8 + M[256] = 8 + 7 = 15
@SP
M=M-1
`

func (c *AddCommand) Translate() string {
	return addTemplate
}

type SubCommand struct {
	operation string
	state     *ParserState
}

func (c *SubCommand) Raw() string {
	return c.operation
}

const subTemplate = `
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] (y)
A=A-1  // A = 257 - 1 = 256
M=M-D  // M[256] = x - y
@SP
M=M-1
`

func (c *SubCommand) Translate() string {
	return subTemplate
}
