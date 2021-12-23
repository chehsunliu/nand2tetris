package vm

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
