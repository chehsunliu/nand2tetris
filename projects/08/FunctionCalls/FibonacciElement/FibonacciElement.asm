// Function { name: "Main.fibonacci", locals: 0 }
(Main.fibonacci)


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

// Lt
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@_LABEL.0
D;JGT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.1
0;JMP

(_LABEL.0)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.1)
@SP
M=M-1

// IfGoto("IF_TRUE")
@SP
M=M-1
A=M
D=M
@IF_TRUE
D;JGT

// Goto("IF_FALSE")
@IF_FALSE
0;JMP

// Label("IF_TRUE")
(IF_TRUE)

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

// Return
@LCL  // Backup M[LCL] to M[frame]
D=M
@frame
M=D

@SP  // Store return value to M[M[ARG]]
A=M-1
D=M
@ARG
A=M
M=D

@ARG  // M[SP] = M[ARG] + 1
D=M+1
@SP
M=D

@frame  // Restore THAT
AM=M-1
D=M
@THAT
M=D

@frame  // Restore THIS
AM=M-1
D=M
@THIS
M=D

@frame  // Restore ARG
AM=M-1
D=M
@ARG
M=D

@frame  // Restore LCL
AM=M-1
D=M
@LCL
M=D

@frame  // Go to RET
A=M-1
0;JMP

// Label("IF_FALSE")
(IF_FALSE)

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

