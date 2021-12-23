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
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
@{{ .Label0 }}
D;JEQ  // if D == 0, jump to LABEL0
M=0    // M[256] = false
@{{ .Label1 }}
0;JMP
({{ .Label0 }})
M=-1   // M[256] = true
({{ .Label1 }})
@SP    // A = 0
M=M-1  // M[0] = 258 - 1 = 257`

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
