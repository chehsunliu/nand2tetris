// Push { segment: "constant", index: 0 }
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "local", index: 0 }
@0
D=A
@LCL
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Label("LOOP_START")
(LOOP_START)

// Push { segment: "argument", index: 0 }
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "local", index: 0 }
@0
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

// Pop { segment: "local", index: 0 }
@0
D=A
@LCL
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Push { segment: "argument", index: 0 }
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 1 }
@1
D=A
@SP
A=M
M=D
@SP
M=M+1

// Sub
@SP
A=M
A=A-1
D=M
A=A-1
M=M-D
@SP
M=M-1

// Pop { segment: "argument", index: 0 }
@0
D=A
@ARG
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Push { segment: "argument", index: 0 }
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// IfGoto("LOOP_START")
@SP
M=M-1
A=M
D=M
@LOOP_START
D;JGT

// Push { segment: "local", index: 0 }
@0
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

