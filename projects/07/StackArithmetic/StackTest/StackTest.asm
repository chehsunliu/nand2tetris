// Push { segment: "constant", index: 17 }
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 17 }
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// Eq
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@_LABEL.0
D;JEQ

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

// Push { segment: "constant", index: 17 }
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 16 }
@16
D=A
@SP
A=M
M=D
@SP
M=M+1

// Eq
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@_LABEL.2
D;JEQ

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.3
0;JMP

(_LABEL.2)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.3)
@SP
M=M-1

// Push { segment: "constant", index: 16 }
@16
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 17 }
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// Eq
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@_LABEL.4
D;JEQ

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.5
0;JMP

(_LABEL.4)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.5)
@SP
M=M-1

// Push { segment: "constant", index: 892 }
@892
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 891 }
@891
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
@_LABEL.6
D;JGT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.7
0;JMP

(_LABEL.6)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.7)
@SP
M=M-1

// Push { segment: "constant", index: 891 }
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 892 }
@892
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
@_LABEL.8
D;JGT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.9
0;JMP

(_LABEL.8)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.9)
@SP
M=M-1

// Push { segment: "constant", index: 891 }
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 891 }
@891
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
@_LABEL.10
D;JGT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.11
0;JMP

(_LABEL.10)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.11)
@SP
M=M-1

// Push { segment: "constant", index: 32767 }
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 32766 }
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// Gt
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@_LABEL.12
D;JLT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.13
0;JMP

(_LABEL.12)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.13)
@SP
M=M-1

// Push { segment: "constant", index: 32766 }
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 32767 }
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1

// Gt
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@_LABEL.14
D;JLT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.15
0;JMP

(_LABEL.14)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.15)
@SP
M=M-1

// Push { segment: "constant", index: 32766 }
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 32766 }
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// Gt
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@_LABEL.16
D;JLT

@SP
A=M
A=A-1
A=A-1
M=0
@_LABEL.17
0;JMP

(_LABEL.16)
@SP
A=M
A=A-1
A=A-1
M=-1

(_LABEL.17)
@SP
M=M-1

// Push { segment: "constant", index: 57 }
@57
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 31 }
@31
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 53 }
@53
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

// Push { segment: "constant", index: 112 }
@112
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

// Neg
@SP
A=M
A=A-1
M=-M

// And
@SP
A=M
A=A-1
D=M
A=A-1
M=D&M
@SP
M=M-1

// Push { segment: "constant", index: 82 }
@82
D=A
@SP
A=M
M=D
@SP
M=M+1

// Or
@SP
A=M
A=A-1
D=M
A=A-1
M=D|M
@SP
M=M-1

// Not
@SP
A=M
A=A-1
M=!M

