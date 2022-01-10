// Function { name: "Sys.init", locals: 0 }
(Sys.init)


// Push { segment: "constant", index: 4000 }
@4000
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "pointer", index: 0 }
@SP
M=M-1
A=M
D=M
@THIS
M=D

// Push { segment: "constant", index: 5000 }
@5000
D=A
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

// Call { name: "Sys.main", args: 0 }
@RET_ADDRESS_Sys.main0
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

@Sys.main
0;JMP

(RET_ADDRESS_Sys.main0)

// Pop { segment: "temp", index: 1 }
@6
D=A
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

// Label("LOOP")
(Sys.init.LOOP)

// Goto("LOOP")
@Sys.init.LOOP
0;JMP

// Function { name: "Sys.main", locals: 5 }
(Sys.main)
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 4001 }
@4001
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "pointer", index: 0 }
@SP
M=M-1
A=M
D=M
@THIS
M=D

// Push { segment: "constant", index: 5001 }
@5001
D=A
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

// Push { segment: "constant", index: 200 }
@200
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "local", index: 1 }
@1
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

// Push { segment: "constant", index: 40 }
@40
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "local", index: 2 }
@2
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

// Push { segment: "constant", index: 6 }
@6
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "local", index: 3 }
@3
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

// Push { segment: "constant", index: 123 }
@123
D=A
@SP
A=M
M=D
@SP
M=M+1

// Call { name: "Sys.add12", args: 1 }
@RET_ADDRESS_Sys.add121
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

@Sys.add12
0;JMP

(RET_ADDRESS_Sys.add121)

// Pop { segment: "temp", index: 0 }
@5
D=A
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

// Push { segment: "local", index: 1 }
@1
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "local", index: 2 }
@2
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "local", index: 3 }
@3
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "local", index: 4 }
@4
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

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

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

@frame
A=M-1
A=A-1
A=A-1
A=A-1
A=A-1
D=M
@retaddr
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

@retaddr  // Go to RET
A=M
0;JMP

// Function { name: "Sys.add12", locals: 0 }
(Sys.add12)


// Push { segment: "constant", index: 4002 }
@4002
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "pointer", index: 0 }
@SP
M=M-1
A=M
D=M
@THIS
M=D

// Push { segment: "constant", index: 5002 }
@5002
D=A
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

// Push { segment: "constant", index: 12 }
@12
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

// Return
@LCL  // Backup M[LCL] to M[frame]
D=M
@frame
M=D

@frame
A=M-1
A=A-1
A=A-1
A=A-1
A=A-1
D=M
@retaddr
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

@retaddr  // Go to RET
A=M
0;JMP

