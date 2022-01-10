// Push { segment: "argument", index: 1 }
@1
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "pointer", index: 1 }
@SP
M=M-1
A=M
D=M
@THAT
M=D

// Push { segment: "constant", index: 0 }
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "that", index: 0 }
@0
D=A
@THAT
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

// Push { segment: "constant", index: 1 }
@1
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "that", index: 1 }
@1
D=A
@THAT
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

// Push { segment: "constant", index: 2 }
@2
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

// Label("MAIN_LOOP_START")
(MAIN_LOOP_START)

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

// IfGoto("COMPUTE_ELEMENT")
@SP
M=M-1
A=M
D=M
@COMPUTE_ELEMENT
D;JNE

// Goto("END_PROGRAM")
@END_PROGRAM
0;JMP

// Label("COMPUTE_ELEMENT")
(COMPUTE_ELEMENT)

// Push { segment: "that", index: 0 }
@0
D=A
@THAT
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "that", index: 1 }
@1
D=A
@THAT
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

// Pop { segment: "that", index: 2 }
@2
D=A
@THAT
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

// Push { segment: "pointer", index: 1 }
@THAT
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

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

// Pop { segment: "pointer", index: 1 }
@SP
M=M-1
A=M
D=M
@THAT
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

// Goto("MAIN_LOOP_START")
@MAIN_LOOP_START
0;JMP

// Label("END_PROGRAM")
(END_PROGRAM)

