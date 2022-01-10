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

// Function { name: "Class1.set", locals: 0 }
(Class1.set)


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

// Pop { segment: "static", index: 0 }
@SP
M=M-1
A=M
D=M
@Class1.0
M=D

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

// Pop { segment: "static", index: 1 }
@SP
M=M-1
A=M
D=M
@Class1.1
M=D

// Push { segment: "constant", index: 0 }
@0
D=A
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

// Function { name: "Class1.get", locals: 0 }
(Class1.get)


// Push { segment: "static", index: 0 }
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "static", index: 1 }
@Class1.1
D=M
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


// Push { segment: "constant", index: 6 }
@6
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 8 }
@8
D=A
@SP
A=M
M=D
@SP
M=M+1

// Call { name: "Class1.set", args: 2 }
@RET_ADDRESS_Class1.set1
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
@7
D=D-A
@ARG
M=D

@SP
D=M
@LCL
M=D

@Class1.set
0;JMP

(RET_ADDRESS_Class1.set1)

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

// Push { segment: "constant", index: 23 }
@23
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 15 }
@15
D=A
@SP
A=M
M=D
@SP
M=M+1

// Call { name: "Class2.set", args: 2 }
@RET_ADDRESS_Class2.set2
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
@7
D=D-A
@ARG
M=D

@SP
D=M
@LCL
M=D

@Class2.set
0;JMP

(RET_ADDRESS_Class2.set2)

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

// Call { name: "Class1.get", args: 0 }
@RET_ADDRESS_Class1.get3
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

@Class1.get
0;JMP

(RET_ADDRESS_Class1.get3)

// Call { name: "Class2.get", args: 0 }
@RET_ADDRESS_Class2.get4
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

@Class2.get
0;JMP

(RET_ADDRESS_Class2.get4)

// Label("WHILE")
(Sys.init.WHILE)

// Goto("WHILE")
@Sys.init.WHILE
0;JMP

// Function { name: "Class2.set", locals: 0 }
(Class2.set)


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

// Pop { segment: "static", index: 0 }
@SP
M=M-1
A=M
D=M
@Class2.0
M=D

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

// Pop { segment: "static", index: 1 }
@SP
M=M-1
A=M
D=M
@Class2.1
M=D

// Push { segment: "constant", index: 0 }
@0
D=A
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

// Function { name: "Class2.get", locals: 0 }
(Class2.get)


// Push { segment: "static", index: 0 }
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "static", index: 1 }
@Class2.1
D=M
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

