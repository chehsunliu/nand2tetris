package vm

type EqCommand struct {
	operation string
	state     *ParserState
}

func (c *EqCommand) Raw() string {
	return c.operation
}

const eqTemplate = `
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 17
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = 17 - M[256] = 17 - 17 = 0
@{{ .Label0 }}
D;JEQ  // if D == 0, jump to LABEL0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@{{ .Label1 }}
0;JMP

({{ .Label0 }})
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

({{ .Label1 }})
@SP    // A = 0
M=M-1  // M[0] = 258 - 1 = 257
`

func (c *EqCommand) Translate() string {
	data := struct {
		Label0 string
		Label1 string
	}{
		Label0: c.state.GetLabel(),
		Label1: c.state.GetLabel(),
	}

	return fillTemplate(eqTemplate, data)
}

func (c *EqCommand) String() string {
	return c.operation
}

type GtCommand struct {
	operation string
	state     *ParserState
}

func (c *GtCommand) Raw() string {
	return c.operation
}

const gtTemplate = `
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@{{ .LabelTrue }}
D;JLT  // if y - x < 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@{{ .LabelMoveSpUp }}
0;JMP

({{ .LabelTrue }})
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

({{ .LabelMoveSpUp }})
@SP
M=M-1
`

func (c *GtCommand) Translate() string {
	data := struct {
		LabelMoveSpUp string
		LabelTrue     string
	}{
		LabelMoveSpUp: c.state.GetLabel(),
		LabelTrue:     c.state.GetLabel(),
	}
	return fillTemplate(gtTemplate, data)
}

type LtCommand struct {
	operation string
	state     *ParserState
}

func (c *LtCommand) Raw() string {
	return c.operation
}

const ltTemplate = `
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@{{ .LabelTrue }}
D;JGT  // if y - x > 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@{{ .LabelMoveSpUp }}
0;JMP

({{ .LabelTrue }})
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

({{ .LabelMoveSpUp }})
@SP
M=M-1
`

func (c *LtCommand) Translate() string {
	data := struct {
		LabelMoveSpUp string
		LabelTrue     string
	}{
		LabelMoveSpUp: c.state.GetLabel(),
		LabelTrue:     c.state.GetLabel(),
	}
	return fillTemplate(ltTemplate, data)
}
