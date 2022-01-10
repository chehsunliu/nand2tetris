@256
D=A
@SP
M=D

@RET_ADDRESS_Sys.init0
D=A
@SP
A=M
M=D
@SP
M=M+1

@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1

@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1

@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1

@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1

@SP
D=M
@5
D=D-A
@ARG
M=D

@SP
D=M
@LCL
M=D

@Sys.init
0;JMP

(RET_ADDRESS_Sys.init0)

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
@_LABEL.1
D;JGT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.2
0;JMP

(_LABEL.1)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.2)
@SP
M=M-1

// IfGoto("IF_TRUE")
@SP
M=M-1
A=M
D=M
@Main.fibonacci.IF_TRUE
D;JNE

// Goto("IF_FALSE")
@Main.fibonacci.IF_FALSE
0;JMP

// Label("IF_TRUE")
(Main.fibonacci.IF_TRUE)

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
A=M
0;JMP

// Label("IF_FALSE")
(Main.fibonacci.IF_FALSE)

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

// Call { name: "Main.fibonacci", args: 1 }
@RET_ADDRESS_Main.fibonacci3
D=A
@SP
A=M
M=D
@SP
M=M+1

@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1

@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1

@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1

@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1

@SP
D=M
@6
D=D-A
@ARG
M=D

@SP
D=M
@LCL
M=D

@Main.fibonacci
0;JMP

(RET_ADDRESS_Main.fibonacci3)

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

// Call { name: "Main.fibonacci", args: 1 }
@RET_ADDRESS_Main.fibonacci4
D=A
@SP
A=M
M=D
@SP
M=M+1

@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1

@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1

@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1

@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1

@SP
D=M
@6
D=D-A
@ARG
M=D

@SP
D=M
@LCL
M=D

@Main.fibonacci
0;JMP

(RET_ADDRESS_Main.fibonacci4)

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

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
A=M
0;JMP

// Function { name: "Sys.init", locals: 0 }
(Sys.init)


// Push { segment: "constant", index: 4 }
@4
D=A
@SP
A=M
M=D
@SP
M=M+1

// Call { name: "Main.fibonacci", args: 1 }
@RET_ADDRESS_Main.fibonacci5
D=A
@SP
A=M
M=D
@SP
M=M+1

@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1

@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1

@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1

@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1

@SP
D=M
@6
D=D-A
@ARG
M=D

@SP
D=M
@LCL
M=D

@Main.fibonacci
0;JMP

(RET_ADDRESS_Main.fibonacci5)

// Label("WHILE")
(Sys.init.WHILE)

// Goto("WHILE")
@Sys.init.WHILE
0;JMP

