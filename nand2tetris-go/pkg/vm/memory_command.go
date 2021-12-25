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

const pushLocalTemplate = `
@{{ .I }}
D=A        // D = I
@{{ .S }}
A=D+M      // A = I + M[LCL]
D=M        // D = M[I+M[LCL]]
@SP
A=M
M=D        // M[M[SP]] = D
@SP
M=M+1
`

func (c *PushCommand) translateLocal(s string) string {
	data := struct {
		I int
		S string
	}{I: c.index, S: s}
	return fillTemplate(pushLocalTemplate, data)
}

const pushTempTemplate = `
@{{ .I }}
D=A        // D = I
@5
A=D+A      // A = I + M[LCL]
D=M        // D = M[I+M[LCL]]
@SP
A=M
M=D        // M[M[SP]] = D
@SP
M=M+1
`

func (c *PushCommand) translateTemp() string {
	data := struct{ I int }{I: c.index}
	return fillTemplate(pushTempTemplate, data)
}

const pushPointerTemplate = `
@{{ .Segment }}
D=M
@SP
A=M
M=D
@SP
M=M+1
`

func (c *PushCommand) translatePointer() string {
	s := ""
	if c.index == 0 {
		s = "THIS"
	} else {
		s = "THAT"
	}

	data := struct{ Segment string }{Segment: s}
	return fillTemplate(pushPointerTemplate, data)
}

const pushStaticTemplate = `
@{{ .Symbol }}
D=M
@SP
A=M
M=D
@SP
M=M+1
`

func (c *PushCommand) translateStatic() string {
	data := struct{ Symbol string }{Symbol: c.state.GetStaticSymbol(c.index)}
	return fillTemplate(pushStaticTemplate, data)
}

func (c *PushCommand) Translate() string {
	switch c.segment {
	case "constant":
		return c.translateConstant()

	case "local":
		return c.translateLocal("LCL")

	case "argument":
		return c.translateLocal("ARG")

	case "this":
		return c.translateLocal("THIS")

	case "that":
		return c.translateLocal("THAT")

	case "temp":
		return c.translateTemp()

	case "pointer":
		return c.translatePointer()

	case "static":
		return c.translateStatic()

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

const popLocalTemplate = `
@{{ .I }}  // A = i
D=A        // D = i
@{{ .Segment }}
D=D+M      // D = i + M[LCL]
@SP        // A = SP
A=M        // A = M[SP]
M=D        // M[M[SP]] = i + M[LCL]
@SP
M=M-1      // M[SP] = M[SP] - 1
A=M        // A = M[SP]
D=M        // D = M[M[SP]]
A=A+1      // A = M[SP] + 1
A=M
M=D
`

func (c *PopCommand) translateLocal(addr string) string {
	data := struct {
		I       int
		Segment string
	}{I: c.index, Segment: addr}
	return fillTemplate(popLocalTemplate, data)
}

const popTempTemplate = `
@{{ .I }}
D=A
@5
D=D+A  // D = I + 5
@SP
A=M
M=D    // M[M[SP]] = 5 + I

@SP
M=M-1  // SP--
A=M    // A = M[SP]
D=M    // D = M[M[SP]]
A=A+1  // A = M[SP] + 1
A=M
M=D
`

func (c *PopCommand) translateTemp() string {
	data := struct{ I int }{I: c.index}
	return fillTemplate(popTempTemplate, data)
}

const popPointerTemplate = `
@SP
M=M-1  // SP--
A=M
D=M    // D = M[M[SP]]
@{{ .Segment }}
M=D
`

func (c *PopCommand) translatePointer() string {
	s := ""
	if c.index == 0 {
		s = "THIS"
	} else {
		s = "THAT"
	}

	data := struct{ Segment string }{Segment: s}
	return fillTemplate(popPointerTemplate, data)
}

const popStaticTemplate = `
@SP
M=M-1  // SP--
A=M
D=M    // D = M[M[SP]]
@{{ .Symbol }}
M=D
`

func (c *PopCommand) translateStatic() string {
	data := struct{ Symbol string }{Symbol: c.state.GetStaticSymbol(c.index)}
	return fillTemplate(popStaticTemplate, data)
}

func (c *PopCommand) Translate() string {
	switch c.segment {
	case "local":
		return c.translateLocal("LCL")

	case "argument":
		return c.translateLocal("ARG")

	case "this":
		return c.translateLocal("THIS")

	case "that":
		return c.translateLocal("THAT")

	case "temp":
		return c.translateTemp()

	case "pointer":
		return c.translatePointer()

	case "static":
		return c.translateStatic()

	default:
		return ""
	}
}

func (c *PopCommand) String() string {
	return fmt.Sprintf("pop %s %d", c.segment, c.index)
}
