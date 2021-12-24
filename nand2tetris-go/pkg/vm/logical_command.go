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

type NotCommand struct {
	operation string
	state     *ParserState
}

func (c *NotCommand) Raw() string {
	return c.operation
}

const notTemplate = `
@SP    // A = SP = 0
A=M    // A = M[0] = addr_sp
A=A-1  // A = 258 - 1 = addr_y
M=!M   // M[addr_y] = !y
`

func (c *NotCommand) Translate() string {
	return notTemplate
}

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

type AndCommand struct {
	operation string
	state     *ParserState
}

func (c *AndCommand) Raw() string {
	return c.operation
}

const andTemplate = `
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = addr_y
D=M    // D = M[addr_y] = y
A=A-1  // A = 257 - 1 = addr_x
M=D&M  // M[addr_x] = y & x
@SP
M=M-1
`

func (c *AndCommand) Translate() string {
	return andTemplate
}
